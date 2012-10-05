//
//  RSGolfBookingFormVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/5/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSGolfBookingFormVC.h"
#import "RSBaseBookTableCell.h"
#import "RSDateTimeSelectionVC.h"
#import "RSSelectedGolfLocation.h"
#import "RSGolfPlayerSelectionVC.h"
#import "ErrorPopup.h"
#import "RSAvailableTeeTimeVC.h"
#import "RSAlertView.h"
#import "DateManager.h"
#define PM                          @"pm"
#define DIFFERENT_TEETIMES          2

@implementation RSGolfBookingFormVC
@synthesize selectedCourseID;
@synthesize teeTimeReqResponseHandler = _teeTimeReqResponseHandler;
@synthesize teeTimesModel;

static NSMutableString *golfSelectedDate ;  //to save the selected date 

-(void)dealloc
{
    [mainFieldArray release];
    [subFieldArray release];
    [selectedCourseID release];
    [_teeTimeReqResponseHandler release];   //use nil to release else where
    [teeTimesModel release];
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
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withCourseId:(NSString *)CourseID
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.selectedCourseID = CourseID;
        teeTimesModel = nil;
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
    
    self.title = BookGolf_ViewTilte;
    
    //intialize the static date value to be used to save selected Date.
    if (!golfSelectedDate) {
        golfSelectedDate = [[NSMutableString alloc]initWithString:NONE ];
    }
	
    //	appDelegate = (ResortSuiteAppDelegate *) [[UIApplication sharedApplication] delegate];
	
	if (mainFieldArray) {
		[mainFieldArray removeAllObjects];
		[mainFieldArray release];
	}
	mainFieldArray = [[NSMutableArray alloc] initWithObjects:GolfBookingFormDate, GolfBookingFormPrefTeeTime, GolfBookingFormNoOfPlayer, nil];
	
	if (subFieldArray) {
		[subFieldArray removeAllObjects];
		[subFieldArray release];
	}
	subFieldArray = [[NSMutableArray alloc] initWithObjects:NONE, NONE, NONE, nil];
    
    //to modify the sub field array if static date(previous selected date) is available
    
    if (![golfSelectedDate isEqualToString:NONE]) {
        [subFieldArray replaceObjectAtIndex:GolfDateSection withObject:golfSelectedDate];
    }
    
    self.instructionLbl.text = pleaseSelectText;
	[self.instructionLbl setFont:[UIFont boldSystemFontOfSize:FontOfSize17]];
	self.instructionLbl.textColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0];
    
    //change the image of the done button image
    
    [self.doneButton setBackgroundColor:[UIColor clearColor]];
	self.doneButton.enabled = NO;
	UIImage *disabledCheckImage  = [UIImage imageNamed:Disabled_Availibility_button];
	UIImage *enabledCheckImage  = [UIImage imageNamed:Enabled_Availibility_button];
	
	[self.doneButton setBackgroundImage:disabledCheckImage forState:UIControlStateDisabled];
	[self.doneButton setBackgroundImage:enabledCheckImage forState:UIControlStateNormal];
    
    //also update the button action
    
    //Notification for selecting the Date/Time
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onPickerValueChanged:)
                                                 name:@"DatePickerValueChanged" object:nil];
    
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onSelctionOfPlayers:)
                                                 name:@"NoOfPlayerSelected" object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
#pragma mark Date and Time picker selection

- (void) onSelctionOfPlayers:(NSNotification *)notice
{
    NSString *noOfPlayer = [notice object];
    
    [subFieldArray removeObjectAtIndex:selectedSection];
	[subFieldArray insertObject:noOfPlayer atIndex:selectedSection];
    
	[self.bookMenuTable reloadData];
	
	[self shouldBookButtonEnabled];
}
#pragma mark Date and Time picker selection
- (void) onPickerValueChanged:(NSNotification *)notice
{
	NSString *date = [notice object];	
	[subFieldArray removeObjectAtIndex:selectedSection];
	[subFieldArray insertObject:date atIndex:selectedSection];
    
    if(selectedSection == GolfDateSection)
    {
        [golfSelectedDate setString:date];
    }
    
	[self.bookMenuTable reloadData];
	
	[self shouldBookButtonEnabled];
}
#pragma mark Book Button actions

-(void) shouldBookButtonEnabled
{
	if ([[subFieldArray objectAtIndex:GolfDateSection] isEqualToString:NONE] || 
		[[subFieldArray objectAtIndex:TeeTimeSection] isEqualToString:NONE] ||
		[[subFieldArray objectAtIndex:PlayersCountSection] isEqualToString:NONE])
	{
		self.doneButton.enabled = NO;
	}
	else
	{		
		self.doneButton.enabled = YES;
	}
}

-(IBAction)doneButtonAction:(id)sender  //action for check availibility
{
    DLog(@"Temp loading otherAvailableTime view");
    //call the service for tee time 
    // if teetime count is > 0 then push the tee time control 
    //else show apop out
    
    [self fetchTeeTime];
}

-(void) fetchTeeTime
{
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
    //[dateFormater setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
    [dateFormater setDateFormat:MMMM_dd_yyyy_hh_mm_aFormat];
    NSString *prefTeeTime = [NSString stringWithFormat:@"%@ %@",
                             [subFieldArray objectAtIndex:GolfDateSection],
                             [subFieldArray objectAtIndex:TeeTimeSection]];
    
    NSDate *startTeeDate = [dateFormater dateFromString:prefTeeTime];
    
    NSDate *endTeeDate = [NSDate dateWithTimeInterval:3600 * DIFFERENT_TEETIMES sinceDate:startTeeDate];
    NSString *PrefEndTeeTime = [dateFormater stringFromDate:endTeeDate];
    [dateFormater release];
    
    DLog(@"NSString *PrefTeeTime= %@",prefTeeTime);
    DLog(@"NSString *PrefEndTeeTime= %@",PrefEndTeeTime);
    
    prefTeeTime = [DateManager convertIntoResponseStringFromSpecificFormatString:prefTeeTime dateFormatStyle:MMMM_dd_yyyy_hh_mm_aFormat withTime:YES];
    PrefEndTeeTime = [DateManager convertIntoResponseStringFromSpecificFormatString:PrefEndTeeTime dateFormatStyle:MMMM_dd_yyyy_hh_mm_aFormat withTime:YES];
    
    DLog(@"NSString *PrefTeeTime= %@",prefTeeTime);
    DLog(@"NSString *PrefEndTeeTime= %@",PrefEndTeeTime);
    
    [self startLoadingAnimation];
    _teeTimeReqResponseHandler = [[RSGolfTeeTimeReqResponseHandler alloc]init];
    [_teeTimeReqResponseHandler setDelegate:self];
    [_teeTimeReqResponseHandler fetchGolfTeeTimesForCourseID:[NSString stringWithString:self.selectedCourseID] numberOfPlayer:[NSString stringWithString:[subFieldArray objectAtIndex:2]] onStartDate:[NSString stringWithString:prefTeeTime] onEndDate:[NSString stringWithString:PrefEndTeeTime]];
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

#pragma mark - TableView Delegate Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"table row selected");
    
    selectedSection =  indexPath.row;
    switch (selectedSection)
    {			
            
        case GolfDateSection:
        {
            
            
            RSDateTimeSelectionVC *dateSelectionVC = [[RSDateTimeSelectionVC alloc]initWithNibName:@"RSDateTimeSelectionVC" bundle:[NSBundle mainBundle] withSection:DatePicker dateString:[subFieldArray objectAtIndex:GolfDateSection]];
            dateSelectionVC.isGolf = YES;   //to create start and end time for golf date time selection
            RSSelectedGolfLocation *location = [RSSelectedGolfLocation sharedInstance];
            dateSelectionVC.title = [NSString stringWithFormat:@"Book %@", location.golfLocation.locationName];
            
            [self.navigationController pushViewController:dateSelectionVC animated:YES];
            [dateSelectionVC release];
            
            
        }
            break;
            
        case TeeTimeSection:	
            if (![[subFieldArray objectAtIndex:GolfDateSection] isEqualToString:NONE])
            {
                RSDateTimeSelectionVC *dateSelectionVC = [[RSDateTimeSelectionVC alloc]initWithNibName:@"RSDateTimeSelectionVC" bundle:[NSBundle mainBundle] withSection:TimePicker dateString:[subFieldArray objectAtIndex:GolfDateSection] timeString:[subFieldArray objectAtIndex:TeeTimeSection]]; //NONE string is passed for the first time.
                dateSelectionVC.isGolf = YES;
                RSSelectedGolfLocation *location = [RSSelectedGolfLocation sharedInstance];
                dateSelectionVC.title = [NSString stringWithFormat:@"Book %@", location.golfLocation.locationName];
                
                [self.navigationController pushViewController:dateSelectionVC animated:YES];
                [dateSelectionVC release];
                
            }
            else {
                
                RSAlertView *rsAlertView = [[RSAlertView alloc]initWithTitle:POPUP_Error andMessage:POPUP_Select_Date withDelegate:nil cancelButttonTitle:POPUP_Button_Ok otherButtonTitle:nil];
                [rsAlertView release];
            }
            
            break;
        case PlayersCountSection:
        {
            RSGolfPlayerSelectionVC *spaDateSelVC = [[RSGolfPlayerSelectionVC alloc] init];
            [self.navigationController pushViewController:spaDateSelVC animated:YES];
            [spaDateSelVC release];
        }
            break;
            
            
        default:
            break;
    }	
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mainFieldArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
	//Create a custom cell to display content on the screen
    RSBaseBookTableCell *cell = (RSBaseBookTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *customCellArray = [[NSBundle mainBundle]loadNibNamed:@"RSBaseBookTableCell" owner:nil options:nil];
        
        
        cell = (RSBaseBookTableCell*)[customCellArray objectAtIndex:0];
    }
    
    //Store the text content for the cell
	cell.cellText.text = [mainFieldArray objectAtIndex:indexPath.row];	
    
	cell.menuDetailText.text = [subFieldArray objectAtIndex:indexPath.row];
    
    [cell setBgForSelectedCell:tableView forIndex:indexPath];
    [cell setAccessoryViewImage:YES];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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
		[errorPopup initWithTitle:errorMessage];
        
	}	
	else if ([parserModelData isKindOfClass:[RSGolfTeeTimes class]])
    {
        
		//If the data received is of type RSSpaServices fill the service into array
        self.teeTimesModel = (RSGolfTeeTimes *)parserModelData;
        
        DLog(@"teetime count = %d",[self.teeTimesModel.golfTeeTimes count]);
        for (RSGolfTeeTime *teeTime in self.teeTimesModel.golfTeeTimes) {
            DLog(@"teeTime are = %@",teeTime.dateTime);
        }       
        //push the tee time table view
        if ([self.teeTimesModel.golfTeeTimes count] > 0) {
            //push the tee time table view
            
            RSAvailableTeeTimeVC *otherAvailableTimeView = [[RSAvailableTeeTimeVC alloc]initWithNibName:@"RSBaseAvailibiltyTimesVC" 
                                                                                                 bundle:[NSBundle mainBundle] 
                                                                                       withTeeTimeArray:teeTimesModel.golfTeeTimes 
                                                                                   withSelectedCourseId:self.selectedCourseID
                                                                                          andNoOfPlayer:[subFieldArray objectAtIndex:2]];
            [self.navigationController pushViewController:otherAvailableTimeView animated:YES];
            [otherAvailableTimeView release];
        }
        else
        {
            RSAlertView *rsAlertView = [[RSAlertView alloc]initWithTitle:POPUP_Tee_Times andMessage:POPUP_Tee_Times_Text withDelegate:nil cancelButttonTitle:POPUP_Button_Ok otherButtonTitle:nil];
            [rsAlertView release];
            
        }
    }
    
}


-(NSDate *)dateFromString:(NSString *)stringDate
{
    
    NSDate *Date = [DateManager dateFromString:stringDate withDateFormat:MMMM_dd_yyyyFormat];
	return Date;
	
}
@end
