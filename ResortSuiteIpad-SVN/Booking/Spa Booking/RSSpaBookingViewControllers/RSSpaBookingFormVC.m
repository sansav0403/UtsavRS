//
//  RSSpaBookingFormVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/28/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSBaseBookTableCell.h"
#import "RSDateTimeSelectionVC.h"
#import "RSSelectedSpaLocation.h"
#import "RSSpaStaffSeletionVC.h"
#import "RSSpaServiceCategoryVC.h"
#import "RSSpaServiceConfirmationVC.h"
#import "ErrorPopup.h"
#import "RSSpaAvailableTimesVC.h"
#import "RSSpaServiceTableVC.h"
#import "RSAlertView.h"
#import "DateManager.h"
#import "RSSpaBookingFormVC.h"

@implementation RSSpaBookingFormVC

@synthesize viewTitle;
@synthesize prefStaffGender;
@synthesize spaStaffreResponseHandler = _spaStaffreResponseHandler;
@synthesize spaStaffs;

@synthesize selectedDateAndTime;
@synthesize notifiedSpaService;

@synthesize selectedStaff;
@synthesize selectedGender;

@synthesize spaServiceReqResponseHandler = _spaServiceReqResponseHandler;
@synthesize modelSpaService;
@synthesize spaAvailibilityReqResponseHandler = _spaAvailibilityReqResponseHandler;
@synthesize modelSpaAvailibilities;
@synthesize isCurrentTimeUpdated;

static NSMutableString *selectedDate ;      //to save the time date and duration of the pervious selected service.
static NSMutableString *selectedTime ;

static NSMutableString *startTime ;      //to save the time date and duration of the pervious selected service.
static NSMutableString *endTime ;

static int selectedSpaServiceSection;
static int serviceDuration = 0; 

-(void)dealloc
{
    [viewTitle release];
    [prefStaffGender release];
	[_spaStaffreResponseHandler release];
    [_spaServiceReqResponseHandler release];
    [_spaAvailibilityReqResponseHandler release];
    [modelSpaAvailibilities release];
    [spaStaffs release];
    [modelSpaService release];
    [selectedDateAndTime release];
    [notifiedSpaService release];

    [spaCategoryDictionary release];
    //----------released after leake found in instrument
    [mainFieldArray release];
    [subFieldArray release];
    [prefStaffGenders release];
    //------------------------------
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
    
    if (!selectedDate && !selectedTime) {
        selectedDate = [[NSMutableString alloc]initWithString:NONE ];
        selectedTime = [[NSMutableString alloc]initWithString:NONE ];
        
    }
    
	if (!startTime && !endTime) {
        startTime = [[NSMutableString alloc]initWithString:@"" ];
        endTime = [[NSMutableString alloc]initWithString:@"" ];
        
    }
	
	if (mainFieldArray) {
		[mainFieldArray removeAllObjects];
		[mainFieldArray release];
	}
	mainFieldArray = [[NSMutableArray alloc] initWithObjects:SpaBookingFormService, SpaBookingFormDate, SpaBookingFormTime, SpaBookingFormStafGender,SpaBookingFormStaff, nil];
	
	if (subFieldArray) {
		[subFieldArray removeAllObjects];
		[subFieldArray release];
	}
	subFieldArray = [[NSMutableArray alloc] initWithObjects:NONE, NONE, NONE, @"No Pref.",@"No Pref.", nil];
    
    if (![selectedDate isEqualToString:NONE]) {
        [subFieldArray replaceObjectAtIndex:DateSection withObject:selectedDate];
    }
    if (![selectedTime isEqualToString:NONE]) {
        [subFieldArray replaceObjectAtIndex:TimeSection withObject:selectedTime];
    }
	
	if (prefStaffGenders) {
		[prefStaffGenders removeAllObjects];
		[prefStaffGenders release];
	}	
	prefStaffGenders = [[NSMutableArray alloc] initWithObjects:@"No Pref.", Gender_Male, Gender_Female, nil];
	
	prefStaffGender = @"";		//For No Pref.
    
    self.selectedGender = @"No Pref.";
    self.selectedStaff = @"No Pref.";
	

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
    
    
    //Notification for selecting the Service
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onSpaServiceSelection:)
                                                 name:@"spaServiceSelected" object:nil];
	
	//Notification for selecting the Date/Time
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onPickerValueChanged:)
                                                 name:@"DatePickerValueChanged" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDateTimeChanged:)
                                                 name:@"DayTimesAccordingToDate" object:nil];
	
	//Notification for selecting the Staff Gender/Name
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onStaffPickerValueChanged:)
                                                 name:@"StaffPickerValueChanged" object:nil];
    
	//Notification for selecting the Staff Gender/Name
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateCurrentBookingTime:)
                                                 name:@"updateNextBookingTime" object:nil];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
#pragma mark Service selection
- (void)onSpaServiceSelection:(NSNotification *)notification
{
    RSSpaService *spaService = [notification object];
    self.notifiedSpaService = spaService;           //object saved in the controller release in dealloc
    
    [subFieldArray removeObjectAtIndex:SpaServiceSection];
    [subFieldArray insertObject:spaService.itemName atIndex:SpaServiceSection];
    
    [self.bookMenuTable reloadData];
    
    [self shouldBookButtonEnabled];
}


#pragma mark Date and Time picker selection

- (void) onDateTimeChanged:(NSNotification *)notice
{
    NSMutableArray* dayTimes = [notice object];   
    [startTime setString:[dayTimes objectAtIndex:0]];
    [endTime setString:[dayTimes objectAtIndex:1]];
    DLog(@"onDateTimeChanged startTime and endtime = %@  %@ ",startTime,endTime);
}

- (void) onPickerValueChanged:(NSNotification *)notice
{
	NSString *date = [notice object];	
	[subFieldArray removeObjectAtIndex:selectedSpaServiceSection];
	[subFieldArray insertObject:date atIndex:selectedSpaServiceSection];
    
    if(selectedSpaServiceSection == DateSection)
    {
        [selectedDate setString:date];
        
        //To set the start time for the selected date
        DLog(@"onPickerValueChanged start time = %@",startTime);
        [selectedTime setString:startTime];        
        if (![selectedTime isEqualToString:NONE]) {
            [subFieldArray replaceObjectAtIndex:TimeSection withObject:selectedTime];   //should be DateSectionin plac of time section
        }
    }
    else if(selectedSpaServiceSection == TimeSection)
    {
        //To set the start time for the selected date
        [selectedTime setString:date];        
    }
    
	[self.bookMenuTable reloadData];
	
	[self shouldBookButtonEnabled];
}

- (void) updateCurrentBookingTime:(NSNotification *)notice
{
    NSMutableArray* timeAndDuration = [notice object];
    NSString *newTime = [timeAndDuration objectAtIndex:0];
    serviceDuration = [[timeAndDuration objectAtIndex:1] intValue];
	
    if((serviceDuration % TIME_INTERVAL) > 0)
    {
        serviceDuration += (TIME_INTERVAL - (serviceDuration % TIME_INTERVAL)); 
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
    [dateFormatter setDateFormat:hh_mm_aFormat];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
    [dateFormatter1 setDateFormat:MMMM_d_yyyy_hh_mm_aFormat];  
    
    NSString* newDate = [selectedDate stringByAppendingString:@" "];
    newDate = [newDate stringByAppendingString:newTime];
    
    NSString* endDate = [selectedDate stringByAppendingString:@" "];
    endDate = [endDate stringByAppendingString:endTime];
    
    //after adding time durartion
    NSDate *selectedTimeInDF = [[NSDate alloc]initWithTimeInterval:serviceDuration * 60 sinceDate:[dateFormatter1 dateFromString:newDate]];  
    NSDate *endTimeInDF = [[NSDate alloc]initWithTimeInterval:0 sinceDate:[dateFormatter1 dateFromString:endDate]];  
    [dateFormatter1 release];
    
    if ([selectedTimeInDF compare:endTimeInDF] == NSOrderedDescending )
    {
        [selectedTime setString:startTime];        
    }
    else
    {
        [selectedTime setString:[dateFormatter stringFromDate:selectedTimeInDF]];  
    }
    [selectedTimeInDF release];
    [endTimeInDF release];
    [dateFormatter release];
    
}

#pragma mark Staff picker selection
- (void) onStaffPickerValueChanged:(NSNotification *)notice
{
	NSString *date = [notice object];	
	
	[subFieldArray removeObjectAtIndex:selectedSection];
	[subFieldArray insertObject:date atIndex:selectedSection];
	
	if (selectedSection == PrefStaffGenderSection) {
		[subFieldArray removeObjectAtIndex:selectedSection+1];
		[subFieldArray insertObject:@"No Pref." atIndex:selectedSection+1];
	}
	[self.bookMenuTable reloadData];
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
    selectedSpaServiceSection = indexPath.row;
    
    [self shouldBookButtonEnabled];
    
    selectedSection =  indexPath.row;
    switch (selectedSection)
    {
        case SpaServiceSection:
        {
            DLog(@"Load Spa Services View...");
            //fetch spa service at the start and create dictionary
            [self fetchSpaServices];
            
        }
            break;
        case DateSection:
            //Load the Date Picker for date 
        {
            NSString *dateSelected = [subFieldArray objectAtIndex:1];
            
            RSDateTimeSelectionVC *dateSelectionVC = [[RSDateTimeSelectionVC alloc]initWithNibName:@"RSDateTimeSelectionVC" bundle:[NSBundle mainBundle] withSection:DatePicker dateString:dateSelected];
            RSSelectedSpaLocation *location = [RSSelectedSpaLocation sharedInstance];
            dateSelectionVC.title = [NSString stringWithFormat:@"Book %@", location.spaLocation.locationName];
            
            [self.navigationController pushViewController:dateSelectionVC animated:YES];
            [dateSelectionVC release];

        }                
            break;
            
        case TimeSection:
            //Load the Date Picker for time 
            if (![[subFieldArray objectAtIndex:DateSection] isEqualToString:NONE])
            {
                RSDateTimeSelectionVC *dateSelectionVC = [[RSDateTimeSelectionVC alloc]initWithNibName:@"RSDateTimeSelectionVC" bundle:[NSBundle mainBundle] withSection:TimeSection dateString:[subFieldArray objectAtIndex:DateSection] timeString:[subFieldArray objectAtIndex:TimeSection]]; //NONE string is passed for the first time.
                
                RSSelectedSpaLocation *location = [RSSelectedSpaLocation sharedInstance];
                dateSelectionVC.title = [NSString stringWithFormat:@"Book %@", location.spaLocation.locationName];
                
                [self.navigationController pushViewController:dateSelectionVC animated:YES];
                [dateSelectionVC release];

            }			
            else {
                RSAlertView *rsAlertView = [[RSAlertView alloc]initWithTitle:POPUP_Error andMessage:POPUP_Select_Date withDelegate:nil cancelButttonTitle:POPUP_Button_Ok otherButtonTitle:nil];
                [rsAlertView release];
            }
            break;
            
        case PrefStaffGenderSection:
            //Load the staff gender pref picker 
        {
            RSSpaStaffSeletionVC *spaStaffSelVC = [[RSSpaStaffSeletionVC alloc] initWithNibName:@"RSSpaStaffSeletionVC" bundle:[NSBundle mainBundle] withSection:selectedSection prefStaffs:prefStaffGenders];
            [self.navigationController pushViewController:spaStaffSelVC animated:YES];
            [spaStaffSelVC release];


        }
            break;
            
        case PrefStaffSection:			
            if ([[subFieldArray objectAtIndex:0] isEqualToString:NONE]) {

                RSAlertView *rsAlertView = [[RSAlertView alloc]initWithTitle:POPUP_Error andMessage:POPUP_Select_Service withDelegate:nil cancelButttonTitle:POPUP_Button_Ok otherButtonTitle:nil];
                [rsAlertView release];
            }
            else {		
                //Set the prefStaffGender Male/Female/No Pref.
                if ([[subFieldArray objectAtIndex:3] isEqualToString:@"Male"]) {
                    prefStaffGender = @"M";
                }
                else if ([[subFieldArray objectAtIndex:3] isEqualToString:@"Female"]) {
                    prefStaffGender = @"F";
                }			
                else {
                    prefStaffGender = @"";
                }
                
               //Fetch the spa staffs for the selected spa item and gender preference
                NSString *selectedSpaItemId = [NSString stringWithFormat:@"%d", notifiedSpaService.spaItemID];				
                [self fetchSpaStaffsForId:selectedSpaItemId forGender:prefStaffGender];				
            }                
            break;
            
        default:
            break;


    }
}
//
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
    cell.cellText.text = [mainFieldArray objectAtIndex:indexPath.row];
    cell.menuDetailText.text = [subFieldArray objectAtIndex:indexPath.row];
    [cell setBgForSelectedCell:tableView forIndex:indexPath];
    [cell setAccessoryViewImage:YES];
    return cell;
}


#pragma mark Book Button actions

-(void) shouldBookButtonEnabled
{
	if ([[subFieldArray objectAtIndex:SpaServiceSection] isEqualToString:NONE] || 
		[[subFieldArray objectAtIndex:DateSection] isEqualToString:NONE] ||
		[[subFieldArray objectAtIndex:TimeSection] isEqualToString:NONE])
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
    [self startLoadingAnimation];
    	self.selectedDateAndTime = [NSString stringWithFormat:@"%@ %@", [subFieldArray objectAtIndex:1], [subFieldArray objectAtIndex:2]];
    DLog(@"selectedDateAndTime =%@",self.selectedDateAndTime);
    
    NSString *convertedSelectedDateAndTime = [DateManager convertIntoResponseStringFromSpecificFormatString:self.selectedDateAndTime dateFormatStyle:MMMM_dd_yyyy_hh_mm_aFormat withTime:YES];
    
    DLog(@"selectedDateAndTime =%@",convertedSelectedDateAndTime);
    _spaAvailibilityReqResponseHandler = [[RSSpaAvailibiltyReResponseHandler alloc]init];
    [_spaAvailibilityReqResponseHandler setDelegate:self];
    [_spaAvailibilityReqResponseHandler checkAvailabilityForSpaBookingForSpaItemId:[NSString stringWithFormat:@"%d", self.notifiedSpaService.spaItemID] forDateTime:convertedSelectedDateAndTime andSpaLocationID:[NSString stringWithFormat:@"%d", self.notifiedSpaService.location]];
}

#pragma mark fetch the data for staffs
-(void) fetchSpaStaffsForId:(NSString *) spaItemId forGender:(NSString *) gender
{
    [self startLoadingAnimation];
    _spaStaffreResponseHandler = [[RSSpaStaffReqResponseHandler alloc]init];
    [_spaStaffreResponseHandler setDelegate:self];
    [_spaStaffreResponseHandler fetchSpaStaffsForId:spaItemId forGender:gender];
}

#pragma mark fetch the data for the spa services
-(void) fetchSpaServices
{
    [self startLoadingAnimation];
    _spaServiceReqResponseHandler = [[RSSpaServiceReqResponseHandler alloc]init];
    [_spaServiceReqResponseHandler setDelegate:self];
    [_spaServiceReqResponseHandler fetchSpaServices];
}
///
#pragma mark RSParseBase delegate
-(void)parsingComplete:(id)parserModelData
{	

	[self stopLoadingAnimation];
	if ([parserModelData isKindOfClass:[Result class]]) {
		Result *resultError = (Result *) parserModelData;		
		NSString *errorMessage = [NSString stringWithFormat:@"%@", resultError.resultText];
		
		ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
		[errorPopup initWithTitle:errorMessage];
	}	
	else if ([parserModelData isKindOfClass:[RSSpaStaffs class]]) {
		//Load the staff names in the picker
		[self loadStaffNamesinPicker:parserModelData];	
	}
    else if ([parserModelData isKindOfClass:[RSSpaServices class]])
    {
        
		//If the data received is of type RSSpaServices fill the service into array 
        self.modelSpaService = (RSSpaServices *)parserModelData;    //save the data in the modal data.
        self.spaServiceReqResponseHandler = nil;
        [self createDictionaryAndReloadTable];
        
    }
	else 
        if ([parserModelData isKindOfClass:[RSSpaAvailibilties class]])
            {
        DLog(@"RSSpaAvailibilties response");
		self.modelSpaAvailibilities = (RSSpaAvailibilties *) parserModelData;
		
		if ([self.modelSpaAvailibilities.spaAvailibilities count] == 1) {
            if ([self doesAvailableTimeExitsInAvailibilityArray]) {
                
                RSSpaServiceConfirmationVC *spaConfirmationView = [[RSSpaServiceConfirmationVC alloc] 
                                                              initWithSpaAvailibilityArray:[NSArray arrayWithObject:[self.modelSpaAvailibilities.spaAvailibilities objectAtIndex:0]]
                                                              forSelectedSpaService:notifiedSpaService
                                                              WithSelectedStaff:self.selectedStaff andGender:self.selectedGender];
                [selectedStaff release];
                [selectedGender release];
                
                [self.navigationController pushViewController:spaConfirmationView animated:YES];
                [spaConfirmationView release];
            }
            else
            {
                RSSpaAvailableTimesVC *spaAvailableTimesVC = [[RSSpaAvailableTimesVC alloc]initWithNibName:@"RSBaseAvailibiltyTimesVC" bundle:[NSBundle mainBundle] withAvailableTimes:self.modelSpaAvailibilities.spaAvailibilities forSelectedSpaService:notifiedSpaService WithSelectedStaff:self.selectedStaff andGender:self.selectedGender];
                
                [self.navigationController pushViewController:spaAvailableTimesVC animated:YES];
                [spaAvailableTimesVC release];	


            }
            
		}
		else if ([self.modelSpaAvailibilities.spaAvailibilities count] > 1) {
            
            RSSpaAvailableTimesVC *spaAvailableTimesVC = [[RSSpaAvailableTimesVC alloc]initWithNibName:@"RSBaseAvailibiltyTimesVC" bundle:[NSBundle mainBundle] withAvailableTimes:self.modelSpaAvailibilities.spaAvailibilities forSelectedSpaService:notifiedSpaService WithSelectedStaff:self.selectedStaff andGender:self.selectedGender];
            
            [self.navigationController pushViewController:spaAvailableTimesVC animated:YES];
            [spaAvailableTimesVC release];
            
		
		}
		else {
            RSAlertView *rsAlertView = [[RSAlertView alloc]initWithTitle:@"" andMessage:POPUP_Service_Unavailable withDelegate:nil cancelButttonTitle:POPUP_Button_Ok otherButtonTitle:nil];
            [rsAlertView release];
		}
    }
	else {
		//Exception handling if WS gives an exception
		ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
		[errorPopup initWithTitle:@"Fault"];
	}	
}
-(BOOL)doesAvailableTimeExitsInAvailibilityArray
{
    RSSpaAvailibility *spaAvailibility = (RSSpaAvailibility *)[self.modelSpaAvailibilities.spaAvailibilities 
                                                               objectAtIndex:0];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
    [dateFormatter setDateFormat:MMMM_dd_yyyy_hh_mm_aFormat];
    NSDate* userSelectedDate = (NSDate*)[dateFormatter dateFromString:[NSString stringWithFormat:@"%@ %@",
                                                                       [subFieldArray objectAtIndex:DateSection],
                                                                       [subFieldArray objectAtIndex:TimeSection]
                                                                       ]];
    DLog(@"startTime =%@",spaAvailibility.startTime);
    NSDate* availableDate = (NSDate*)[dateFormatter dateFromString:spaAvailibility.startTime];
	[dateFormatter release];
    
    
    if ([availableDate isEqualToDate:userSelectedDate])
    {
        return YES;
    }
    return NO;
  
}
-(void) loadStaffNamesinPicker:(id) parserModelData
{
	//If the data received is of type RSSpaStaffs
    self.spaStaffs = (RSSpaStaffs *) parserModelData;
	//--relese teh statf req res handler here
    self.spaStaffreResponseHandler = nil;
    
	if (prefStaffNames) {
		[prefStaffNames removeAllObjects];
		[prefStaffNames release];
	}	
	prefStaffNames = [[NSMutableArray alloc] initWithObjects:@"No Pref.", nil];
	
	if ([self.spaStaffs.spaStaffs count] > 0) {
		//Add Spa staff names into an array with sorting order	
		NSSortDescriptor *nameSorter = [[NSSortDescriptor alloc] initWithKey:@"spaStaffName" ascending:YES];
		[self.spaStaffs.spaStaffs sortUsingDescriptors:[NSArray arrayWithObject:nameSorter]]; 
		[nameSorter release];
		
		for (int staffIndex =0; staffIndex < [self.spaStaffs.spaStaffs count]; staffIndex++) {
			[prefStaffNames addObject:[[self.spaStaffs.spaStaffs objectAtIndex:staffIndex] spaStaffName]];				
		}	
	}
	
	//Load the staff picker with staff names

    
    RSSpaStaffSeletionVC *spaStaffSelVC = [[RSSpaStaffSeletionVC alloc] initWithNibName:@"RSSpaStaffSeletionVC" bundle:[NSBundle mainBundle] withSection:selectedSection prefStaffs:prefStaffNames];
    [self.navigationController pushViewController:spaStaffSelVC animated:YES];
    [spaStaffSelVC release];
}

#pragma mark - dictionary creation function
-(void)createDictionaryAndReloadTable
{
    //create dictionary to divided in category
    //create the dictionary with category as key	
    NSArray *spaServiceArray = self.modelSpaService.spaServices;
    spaCategoryDictionary = [[NSMutableDictionary alloc]init];
    
    for (int i= 0; i < [spaServiceArray count];i++)
    {
        RSSpaService *spaService = [spaServiceArray objectAtIndex:i];
        NSString *spaCategoryKey = spaService.itemCategory;     //key are are string
        
        NSArray *lkeyArray = [spaCategoryDictionary allKeys];
        
        if ([lkeyArray containsObject:spaCategoryKey])
        {
            NSMutableArray *localEventArray = [spaCategoryDictionary objectForKey:spaCategoryKey];
            [localEventArray addObject:spaService];
            [spaCategoryDictionary setObject:localEventArray forKey:spaCategoryKey];
        }
        else 
        {
            NSMutableArray *localEventArray = [[NSMutableArray alloc] initWithObjects:spaService,nil];
            [spaCategoryDictionary setObject:localEventArray forKey:spaCategoryKey];
            [localEventArray release];
        }
    }
    
    [self switchApplicationToSpaServices];
}

-(void)switchApplicationToSpaServices
{
    //now the dictionary is created
    NSArray *categoryAllKey = [spaCategoryDictionary allKeys];
    
    //condition to put in row did select
    if ([categoryAllKey count] == 1) {
        //push the table view   //sending all the services
        RSSpaServiceTableVC *spaServiceTableVC  = [[RSSpaServiceTableVC alloc]initWithNibName:@"RSBaseSpaServiceTableVC" bundle:[NSBundle mainBundle] withSpaServiceArray:self.modelSpaService.spaServices];    
    
        [self.navigationController pushViewController:spaServiceTableVC animated:YES];
        [spaServiceTableVC release];
        
        

        
    }
    else if([categoryAllKey count] > 1)
    {
        //add all key in the dictionary
        [spaCategoryDictionary setObject:self.modelSpaService.spaServices forKey:@"All"];
        //push the category view      
        //call the sub class of the category view base class
        RSSpaServiceCategoryVC *spaSerViceCategoryVC = [[RSSpaServiceCategoryVC alloc]initWithNibName:@"RSBaseCategoryVC" bundle:[NSBundle mainBundle] withDictionary:spaCategoryDictionary];
        [self.navigationController pushViewController:spaSerViceCategoryVC animated:YES];
        [spaSerViceCategoryVC release];
    }
    else 
    {
        RSAlertView *rsAlertView = [[RSAlertView alloc]initWithTitle:POPUP_Error andMessage:POPUP_Service_Unavailable withDelegate:self cancelButttonTitle:POPUP_Button_Ok otherButtonTitle:nil];
        [rsAlertView release];
    }		
    
}

@end
