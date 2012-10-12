//
//  RSGolfConfirmationVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/5/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSGolfConfirmationVC.h"
#import "ErrorPopup.h"
#import "RSGolfRates.h"
#import "DateManager.h"
#import "RSBookingConfirmedVC.h"

@implementation RSGolfConfirmationVC
@synthesize TimeOfBooking;
@synthesize selectedCourseId;
@synthesize selectedPlayers;
@synthesize golfRate;
@synthesize golfRateReqResponseHandler = _golfRateReqResponseHandler;
@synthesize timeString;
@synthesize dateString;

@synthesize golfBookingReqhandler = _golfBookingReqhandler;

- (void)dealloc
{
    [TimeOfBooking release];
    [selectedCourseId release];
    [selectedPlayers release];
    
    [golfRate release];
    [_golfRateReqResponseHandler release];
    [timeString release];   //not released earlier check
    [dateString release];
    
    [_golfBookingReqhandler release];
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

-(id)initWithSelectedTime:(NSString *)dateTime andSelectedCourseID:(NSString *)courseId andSelectedPlayer:(NSString *)player
{
    self =[super initWithNibName:@"RSConfirmationBaseClass" bundle:[NSBundle mainBundle]];
    if (self) {
        
        self.TimeOfBooking = dateTime;
        self.selectedCourseId = courseId;
        self.selectedPlayers = player;
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
    [self setTitle:BookGolf_ViewTilte];
    
    [self createTitleHeader:ConfirmGolfBookDetailheader yPosition:TitleHeaderYcord];
    
    [self drawSeperatorImageAtYCord:sepratorImageYcord - dot_height];
    
    int dateTimeStingLen = [self.TimeOfBooking length];
    
    self.timeString = [self.TimeOfBooking substringFromIndex:dateTimeStingLen - 8];
    self.dateString = [self.TimeOfBooking substringToIndex:dateTimeStingLen - 8];
    
    DLog(@"date=%@time=%@ss",dateString,timeString);
    DLog(@"dself.TimeOfBooking=%@",self.TimeOfBooking);
    
    NSString *convertedDateString = [DateManager convertResponseStringFromStandardDateFormateString:self.dateString withTime:NO];
    NSString *convertedTimeString = [DateManager convertTimeIntoStandardFormat:self.timeString currentTimeFormat:kCurrentTimeFormat];
    DLog(@"date after conversion=%@",convertedDateString);
    DLog(@"time after conversion=%@",convertedTimeString);
    
    [self startLoadingAnimation];
    _golfRateReqResponseHandler = [[RSGolfRatesReqResponseHandler alloc]init];
    [_golfRateReqResponseHandler setDelegate:self];
    [_golfRateReqResponseHandler fetchGolfRateForSelectedCourseID:[NSString stringWithString:self.selectedCourseId] forDate:[NSString stringWithString:convertedDateString] andTime:[NSString stringWithString:convertedTimeString]];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)bookAction:(id) sender
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    [self createGolfBooking];
}

- (void)createGolfBooking
{
    [self startLoadingAnimation];
    
    //convert booking time before sending response to server
    NSString *convertedDateTimeString = [DateManager convertResponseStringFromStandardDateFormateString:self.TimeOfBooking withTime:YES];
    
    _golfBookingReqhandler = [[RSGolfBookingReqResponseHandler alloc]init];
    [_golfBookingReqhandler setDelegate:self];
    [_golfBookingReqhandler BookGolfServiceForBookingTime:[NSString stringWithString:convertedDateTimeString] forSelectedCourseID:[NSString stringWithString:self.selectedCourseId] forNumberOfPlayers:[NSString stringWithString:self.selectedPlayers] withGolfItemID:[NSString stringWithString:self.golfRate.itemId] andPlayingCost:[NSString stringWithString:self.golfRate.price]];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];
	return YES;
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
	else if ([parserModelData isKindOfClass:[RSGolfRates class]])
    {
        
        self.golfRate = (RSGolfRates *)parserModelData;
        DLog(@"golf Rate is %@",self.golfRate.price);
        [self createMainBodyLabelArray];
        self.golfRateReqResponseHandler = nil;
    }
    else if ([parserModelData isKindOfClass:[RSGolfBookingReqResponseHandler class]])   //as success returm self
    {
        
        DLog(@"Golf Booking SuccesFull and golfBookingId %@",self.golfBookingReqhandler.golfBookingId);
        self.golfBookingReqhandler = nil;        
        DLog(@"Golf booking succesful");
        /*show the final screen*/
        RSBookingConfirmedVC *spaBookingConfirmVC = [[RSBookingConfirmedVC alloc] initWithNibName:@"RSBookingConfirmedVC" bundle:[NSBundle mainBundle]];
		[self.navigationController pushViewController:spaBookingConfirmVC animated:YES];
		[spaBookingConfirmVC release];
        
    }else {
		//Exception handling if WS gives an exception
		ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
		[errorPopup initWithTitle:kFaultTitle];
	}	
}

-(void)createMainBodyLabelArray
{
    DLog(@"values datestrin %@ timestring %@ no of player = %@ golfrate  = %@",dateString,timeString,self.selectedPlayers,[self.golfRate price]);
    
    NSString *date = [NSString stringWithFormat:@"%@ :",kDateTitle];
    NSString *teeTime = [NSString stringWithFormat:@"%@ :",kTeeTimeTitle];
    NSString *players = [NSString stringWithFormat:@"%@ :",kOf_Players_Title];
    NSString *pricePerLayer = [NSString stringWithFormat:@"%@ :",kPricePerPlayerTitle];
    
    NSMutableArray *staticLabelTexts = [[[NSMutableArray alloc]initWithObjects:
                                         date,
                                         teeTime
                                         ,players
                                         ,pricePerLayer
                                         ,nil
                                         ]autorelease];
    
    NSMutableArray *DynamicLabelTexts = [[[NSMutableArray alloc]initWithObjects:
                                          dateString,
                                          timeString,
                                          self.selectedPlayers,
                                          [[self.golfRate price] isEqualToString:@""] ? DataNotAvailable:[self.golfRate price],
                                          nil
                                          ] autorelease];
    
    
    [self createDescriptionBody:staticLabelTexts dataArray:DynamicLabelTexts];
    
}

@end
