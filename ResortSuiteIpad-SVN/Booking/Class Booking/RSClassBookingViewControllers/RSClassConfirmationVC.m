//
//  RSClassConfirmationVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/1/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSClassConfirmationVC.h"
#import "ErrorPopup.h"
#import "RSAppDelegate.h"
#import "RSBookingConfirmedVC.h"
#import "RSSelectedSpaLocation.h"
@implementation RSClassConfirmationVC
@synthesize selectedClass;

-(void)dealloc
{
    [spaCustomerConflictCheck release];
    [classBookingHandler release];
    [selectedClass release];
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
-(id)initWithSelectedClass:(RSSpaClass *)selClass
{
//    self = [super init];
    self = [super initWithNibName:@"RSConfirmationBaseClass" bundle:[NSBundle mainBundle]];
    if (self) {
        self.selectedClass = selClass;
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
    self.title = [NSString stringWithFormat:@"Book %@", location.spaLocation.locationName];

    [self createTitleHeader:@"Book" yPosition:TitleHeaderYcord];  
    
    [self drawSeperatorImageAtYCord:sepratorImageYcord - dot_height];
    
    //generate the array of the static label text and the dynamic label text
    
    NSArray *staticLabelTexts = [[[NSArray alloc]initWithObjects:DescClass_activityText, DescNoOfClassText, 
								  DescStartTimeText, @"Date :", DescDurationText,DescPriceText,DescDescriptionText, nil]autorelease];
    
    NSString *descString = [NSString stringWithFormat:@"%@",selectedClass.itemDescription];
	if ([descString isEqualToString:@""])
    {
        descString = [NSString stringWithString:DataNotAvailable];
    }
	
    NSArray *DynamicLabelTexts = [[[NSArray alloc]initWithObjects:
                                   selectedClass.spaItemName,
                                   //selectedClass.itemDescription
								   [NSString stringWithFormat:@"%d", selectedClass.numClasses],
								   [self getDateTimeFromString:selectedClass.startTime format:@"Time"],
								   [self getDateTimeFromString:selectedClass.startTime format:@"Date"],
								   [NSString stringWithFormat:@"%.0f", selectedClass.serviceTime],
                                   [NSString stringWithFormat:@"%.02f", selectedClass.price],
                                   descString,
                                   nil
                                   ] autorelease];
    
    [self createDescriptionBody:staticLabelTexts dataArray:DynamicLabelTexts];
    
    spaCustomerConflictCheck = [[RSSpaCustomerConflictCheck alloc]init];

}
-(void)bookAction:(id)sender
{
    DLog(@"In bookAction");
	
    //Fetch the data to check if there are conflicts exists
  	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onOKPressed:)
                                                 name:@"OKPressed" object:nil];
	
	//Fetch the data to check if there are conflict doesn't exist
  	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(createSpaClassBooking:)
                                                 name:@"NoSpaConflictsNotification" object:nil];
	
    [self startLoadingAnimation];

	[spaCustomerConflictCheck checkForSpaCustomerConflicts:self.selectedClass forDateAndTime:self.selectedClass.startTime]; //this class sends backs notification object in response
    
}
//Pop to the main screen to reselect the date or time as there are conflicts
-(void) onOKPressed:(NSNotification *) notice
{
    [self stopLoadingAnimation];
	DLog(@"onOKPressed");
    RSAppDelegate *appDelegate = (RSAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if (appDelegate.selectedLocBookingType == ALL) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:BOOK_SERVICE_PAGE_CONTROLLER_COUNT_FOR_ALL] animated:YES];
    }
    else if (appDelegate.selectedLocBookingType == SINGLE)
    {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:BOOK_SERVICE_PAGE_CONTROLLER_COUNT_FOR_CLASSORSERVICE] animated:YES];
    }
    
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"OKPressed" object:nil]; 
}

-(void) createSpaClassBooking:(NSNotification *) notice
{
    [self stopLoadingAnimation];
	DLog(@"createSpaClassBooking");
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"NoSpaConflictsNotification" object:nil]; 
    //create spa class booking on no conflict
    [self createClassBooking];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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

#pragma mark Date formatting
-(NSString *) getDateTimeFromString:(NSString *) dateString format:(NSString *) dateOrTime
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
	[dateFormatter setDateFormat:MMMM_dd_yyyy_hh_mm_aFormat];	
	
	NSDate *startTime = nil;
	
	if([dateOrTime isEqualToString:@"Time"])
	{
		startTime = (NSDate *) [dateFormatter dateFromString:dateString];
		[dateFormatter setDateFormat:hh_mm_aFormat];
	}
	else if([dateOrTime isEqualToString:@"Date"])
	{
		startTime = (NSDate *) [dateFormatter dateFromString:dateString];
		[dateFormatter setDateFormat:MMMM_dd_yyyyFormat];
	}			 
	
	NSString *startDateOrTime = [dateFormatter stringFromDate:startTime];
	[dateFormatter release];
	
	return startDateOrTime;
}

-(void)createClassBooking
{
    /*create reqres handler and get data for booking request*/
    [self startLoadingAnimation];
    classBookingHandler = [[RSClassBookingReqResponseHandler alloc]init];
    [classBookingHandler setDelegate:self];
    [classBookingHandler createClassBookingForSelectedClassID:[NSString stringWithFormat:@"%d",self.selectedClass.spaClassId]];
}

#pragma mark RSParseBase delegate
-(void)parsingComplete:(id)parserModelData
{	
	[self stopLoadingAnimation];
	if ([parserModelData isKindOfClass:[Result class]])
    {
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
	else if ([parserModelData isKindOfClass:[RSClassBooking class]])
    {
        DLog(@"class booking succesful");
        /*show the final screen*/
        RSBookingConfirmedVC *spaBookingConfirmVC = [[RSBookingConfirmedVC alloc] initWithNibName:@"RSBookingConfirmedVC" bundle:[NSBundle mainBundle]];
		[self.navigationController pushViewController:spaBookingConfirmVC animated:YES];
		[spaBookingConfirmVC release];
        
        
    }else {
		//Exception handling if WS gives an exception
		ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
		[errorPopup initWithTitle:@"Fault"];
	}
    [classBookingHandler release];
    classBookingHandler = nil;
}

@end
