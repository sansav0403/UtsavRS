//
//  RSSpaServiceConfirmationVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/2/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSSpaServiceConfirmationVC.h"
#import "RSSelectedSpaLocation.h"
#import "RSSpaAvailibility.h"
#import "RSBookingConfirmedVC.h"
#import "DateManager.h"
@implementation RSSpaServiceConfirmationVC

@synthesize bookedService;
@synthesize spaAvailibilities;
@synthesize prefGender;
@synthesize prefStaffName;
@synthesize  selectedDateAndTime;
@synthesize spaServiceBookingReqResponseHandler = _spaServiceBookingReqResponseHandler;

- (void)dealloc
{
	[selectedDateAndTime release];
    [bookedService release];
    [spaAvailibilities release];
	[_spaServiceBookingReqResponseHandler release];
    
    if(bookingTime)
    {
        [bookingTime release];
    }
    [spaCustomerConflictCheck release];
    [super dealloc];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithSpaAvailibilityArray:(NSArray *)Availibilites forSelectedSpaService:(RSSpaService *)spaService 
{
//    self = [super init];
    self = [super initWithNibName:@"RSConfirmationBaseClass" bundle:[NSBundle mainBundle]];
    if (self)
    {
        //self.bookingDate = date;
        self.bookedService  = spaService;
        self.spaAvailibilities = Availibilites;
    }
    return self;
}

-(id)initWithSpaAvailibilityArray:(NSArray *)Availibilites forSelectedSpaService:(RSSpaService *)spaService
                WithSelectedStaff:(NSString *)staffName andGender:(NSString *)selectedStaffgender
{
    self = [super init];
    if (self)
    {
        self.bookedService  = spaService;
        self.spaAvailibilities = Availibilites;
        self.prefGender = selectedStaffgender;
        self.prefStaffName = staffName;
    }
    return self;
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	RSSelectedSpaLocation *location = [RSSelectedSpaLocation sharedInstance];
    self.title = [NSString stringWithFormat:@"Book %@",location.spaLocation.locationName];
    
    spaCustomerConflictCheck = [[RSSpaCustomerConflictCheck alloc]init];
    [ self displayBookingConfirmation];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)displayBookingConfirmation
{
    NSString *bookingStr = nil;
	
	if ([spaAvailibilities count] == 0) {
		bookingStr = self.selectedDateAndTime;
	}
	else if ([spaAvailibilities count] > 0)
	{
		RSSpaAvailibility *tempAvailibility = (RSSpaAvailibility *)[spaAvailibilities objectAtIndex:0];
		bookingStr = [tempAvailibility startTime];
	}
	
	NSDate *bookingDate = [self dateFromString:bookingStr];
    [self createTitleHeader:@"Book" yPosition:TitleHeaderYcord];
    
    [self drawSeperatorImageAtYCord:sepratorImageYcord - dot_height];
    
    //Set current booking time
    bookingTime = [[NSString alloc] initWithString:[self timeStringFromDate:bookingDate]];
    
    //generate the array of the static label text and the dynamioc label text
    NSMutableArray *staticLabelTexts = [[[NSMutableArray alloc]initWithObjects:SpaConfirmationView_Service,SpaConfirmationView_Date,SpaConfirmationView_Time,SpaConfirmationView_Duration,SpaConfirmationView_Price,SpaConfirmationView_Description, nil]autorelease];
    NSMutableArray *DynamicLabelTexts = [[[NSMutableArray alloc]initWithObjects:
                                          bookedService.itemName,
                                          
                                          [self stringFromDate:bookingDate],
                                          [self timeStringFromDate:bookingDate],
                                          [NSString stringWithFormat:@"%d",bookedService.serviceTime],
                                          [NSString stringWithFormat:@"%0.02f",bookedService.price],
                                          bookedService.itemDesc,
                                          nil
                                          ] autorelease];
    
    if(![self.prefGender isEqualToString:@"No Pref."])
    {
        [staticLabelTexts insertObject:@"Gender" atIndex:2];
        [DynamicLabelTexts insertObject:self.prefGender atIndex:2];
        
        if (![self.prefStaffName isEqualToString:@"No Pref."])
        {
            [staticLabelTexts insertObject:@"Staff Name" atIndex:3];
            [DynamicLabelTexts insertObject:self.prefStaffName atIndex:3];
        }
    }
    
    if (![self.prefStaffName isEqualToString:@"No Pref."] && [self.prefGender isEqualToString:@"No Pref."])
    {
        [staticLabelTexts insertObject:@"Staff Name" atIndex:2];
        [DynamicLabelTexts insertObject:self.prefStaffName atIndex:2];
    }
    
    
    [self createDescriptionBody:staticLabelTexts dataArray:DynamicLabelTexts];

}
-(void)bookAction:(id) sender
{
    DLog(@"take booking action");
	
	//If there are colflicts with the bookings exists
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onOKPressed:)
                                                 name:@"OKPressed" object:nil];
	
	//Fetch the data to check if there are conflict doesn't exist
  	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(createSpaServiceBooking:)
                                                 name:@"NoSpaConflictsNotification" object:nil];
    

    [spaCustomerConflictCheck checkForSpaCustomerConflicts:bookedService forDateAndTime:[[spaAvailibilities objectAtIndex:0] startTime]];
}

#pragma mark Notifications received
//Pop to the main screen to reselect the date or time as there are conflicts
-(void) onOKPressed:(NSNotification *) notice
{
	DLog(@"onOKPressed");
	
	[self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] 
										  animated:YES];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"OKPressed" object:nil];
}

-(void) createSpaServiceBooking:(NSNotification *) notice
{
	DLog(@"createSpaServiceBooking");	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"NoSpaConflictsNotification" object:nil]; 
	
    [self createSpaBooking];
	
}
-(void)createSpaBooking
{
    _spaServiceBookingReqResponseHandler = [[RSSpaServiceBookingReqResponseHandler alloc]init];
    //NSString *startTime = @"2012-08-16091000";
    NSString *convertedString = [DateManager convertIntoResponseStringFromSpecificFormatString:[[spaAvailibilities objectAtIndex:0] startTime] dateFormatStyle:MMMM_d_yyyy_hh_mm_aFormat withTime:YES];
    
    [_spaServiceBookingReqResponseHandler setDelegate:self];
    
    // old request
    //[_spaServiceBookingReqResponseHandler createSpaBookingForSpaItemId:[NSString stringWithFormat:@"%d", bookedService.spaItemID] withStartDateTime:[[spaAvailibilities objectAtIndex:0] startTime] andSpaStaffId:[NSString stringWithFormat:@"%d",[[spaAvailibilities objectAtIndex:0] spaStaffID]]];
    
    //new request
    [_spaServiceBookingReqResponseHandler createSpaBookingForSpaItemId:[NSString stringWithFormat:@"%d", bookedService.spaItemID] withStartDateTime:convertedString andSpaStaffId:[NSString stringWithFormat:@"%d",[[spaAvailibilities objectAtIndex:0] spaStaffID]]];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];
	return YES;
}

#pragma mark - Date formatting

-(NSDate *)dateFromString:(NSString *)stringDate {
// 	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//	[dateFormatter setDateFormat:MMMM_dd_yyyy_hh_mm_aFormat];		
//    
//    //Need to set one day ahead, dont know why.
//    NSDate *Date = [dateFormatter dateFromString:stringDate];
//	[dateFormatter release];	
    NSDate *Date = [DateManager dateFromString:stringDate withDateFormat:MMMM_dd_yyyy_hh_mm_aFormat];
	return Date;	
}

#pragma mark RSParseBase delegate
-(void)parsingComplete:(id)parserModelData
{	
	if ([parserModelData isKindOfClass:[Result class]]) {
		Result *resultError = (Result *) parserModelData;		
		NSString *errorMessage = [NSString stringWithFormat:@"%@", resultError.resultText];
		ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
		if (resultError.ErrorID == kGuaranteeRequiredErrorId) {
            [errorPopup initWithErrorId:resultError.ErrorID];
        }
        else{
            [errorPopup initWithTitle:errorMessage];    
        }
	}	
	else if ([parserModelData isKindOfClass:[RSSpaServiceBooking class]]) {
		//Booking successful
        [self updateBookingTime];
        
        RSBookingConfirmedVC *spaBookingConfirmVC = [[RSBookingConfirmedVC alloc] initWithNibName:@"RSBookingConfirmedVC" bundle:[NSBundle mainBundle]];
		[self.navigationController pushViewController:spaBookingConfirmVC animated:YES];
		[spaBookingConfirmVC release];
	}
	else {
		//Exception handling if WS gives an exception
		ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
		[errorPopup initWithTitle:@"Fault"];
	}	
}

-(void) updateBookingTime
{
    DLog(@"bookingTime %@     %@",bookingTime , [NSString stringWithFormat:@"%d",bookedService.serviceTime]);
    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithObjects:bookingTime,[NSString stringWithFormat:@"%d",bookedService.serviceTime], nil];
    
	//Post notification with the selected value
	[[NSNotificationCenter defaultCenter] postNotificationName:@"updateNextBookingTime" 
														object:dataArray];
    [dataArray release];	
}
@end
