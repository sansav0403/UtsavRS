//
//  RSClassBookingFormVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/28/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSClassBookingFormVC.h"
#import "RSBaseBookTableCell.h"

#import "RSDateTimeSelectionVC.h"
#import "RSSelectedSpaLocation.h"
#import "ErrorPopup.h"
#import "RSSpaClassCategoryVC.h"
#import "RSClassConfirmationVC.h"
#import "RSSpaServiceCategoryVC.h"
#import "RSClassServiceTableVC.h"
#import "RSAlertView.h"
#import "DateManager.h"

@implementation RSClassBookingFormVC
@synthesize viewTitle;
@synthesize dailySpaClassesModel;
@synthesize selectedSpaClass;
//@synthesize spaCustomerConflictBookingsParser;

static NSMutableString *selectedDate ;      //to save the time date and duration of the pervious selected service.
- (void)dealloc
{
    [mainFieldArray release];
    [subFieldArray release];
    [selectedSpaClass release];
    
    [dailySpaClassesModel release];
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
    self.title = [NSString stringWithFormat:@"%@ %@",kBook_Title, location.spaLocation.locationName];
    
    if (!selectedDate) {
        selectedDate = [[NSMutableString alloc]initWithString:NONE ];
    }
    
    if (mainFieldArray) {
		[mainFieldArray removeAllObjects];
		[mainFieldArray release];
	}
	mainFieldArray = [[NSMutableArray alloc] initWithObjects:kDateTitle, ClassActivityCellText, nil];
	
	if (subFieldArray) {
		[subFieldArray removeAllObjects];
		[subFieldArray release];
	}
	subFieldArray = [[NSMutableArray alloc] initWithObjects:NONE, NONE,nil];
    
    if (![selectedDate isEqualToString:NONE]) {
        [subFieldArray replaceObjectAtIndex:0 withObject:selectedDate];
    }
    
    self.instructionLbl.text = pleaseSelectText;
	[self.instructionLbl setFont:[UIFont boldSystemFontOfSize:FontOfSize16]];
	self.instructionLbl.textColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0];
	
    
    //change the image of hte done button
    
    [self.doneButton setBackgroundColor:[UIColor clearColor]];
	//checkAvailButton.titleLabel.text = @"Check Availability";
	self.doneButton.enabled = NO;
	
	
	UIImage *disabledCheckImage  = [UIImage imageNamed:kDisabled_Button_img];
	UIImage *enabledCheckImage  = [UIImage imageNamed:kEnabled_Button_img];
	
	[self.doneButton setBackgroundImage:disabledCheckImage forState:UIControlStateDisabled];
    [self.doneButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
	[self.doneButton setBackgroundImage:enabledCheckImage forState:UIControlStateNormal];
    [self.doneButton setTitle:kSelect_Title forState:UIControlStateNormal];
    [self.doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.doneButton.titleLabel setFont:[UIFont boldSystemFontOfSize:kLabelTextFontSize]];
    [self.doneButton titleLabel].shadowOffset = CGSizeMake(0, 1);
         
       
    //action for the button is already specified in xib just need to override in the child class
    //Notification for selecting the Date/Time
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onPickerValueChanged:)
                                                 name:@"DatePickerValueChanged" object:nil];
    
    //Notification for selecting Spa class
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onSpaClassSelection:)
                                                 name:@"spaClassSelected" object:nil];
}
-(IBAction)doneButtonAction:(id)sender
{
    DLog(@"booking action the class form");
    /*show the booking confirmation screen and do booking action and conflict resolution in that screen*/
    
    //show confirmation view
    //there check foe conflicct and  do book action
    RSClassConfirmationVC *classConfirmationVC = [[RSClassConfirmationVC alloc]initWithSelectedClass:self.selectedSpaClass];
    [self.navigationController pushViewController:classConfirmationVC animated:YES];
    [classConfirmationVC release];
}
#pragma mark Date and Spa class selection notification action
- (void) onPickerValueChanged:(NSNotification *)notice
{
	NSString *date = [notice object];	
	[subFieldArray removeObjectAtIndex:selectedSection];
	[subFieldArray insertObject:date atIndex:selectedSection];
    
    if(selectedSection == ClassDateSection)
    {
        [selectedDate setString:date];
    }
    [self.bookMenuTable reloadData];
    [self shouldBookButtonEnabled];
}

-(void)onSpaClassSelection:(NSNotification *)notice
{
    self.selectedSpaClass = (RSSpaClass *)[notice object];
    [subFieldArray removeObjectAtIndex:selectedSection];
	[subFieldArray insertObject:selectedSpaClass.spaItemName atIndex:selectedSection];
    
    [self.bookMenuTable reloadData];
    [self shouldBookButtonEnabled];
}

#pragma mark Book Button actions
-(void)shouldBookButtonEnabled
{
	if ([[subFieldArray objectAtIndex:ClassDateSection] isEqualToString:NONE] ||
		[[subFieldArray objectAtIndex:ClassServiceSection] isEqualToString:NONE] )
	{
		self.doneButton.enabled = NO;
	}
	else
	{		
		self.doneButton.enabled = YES;
	}
    
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
#pragma mark - TableView Delegate Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedSection =  indexPath.row;
    
    switch (selectedSection)
    {			
        case ClassDateSection:
        {
            NSString *dateSelected = [subFieldArray objectAtIndex:0];
            RSDateTimeSelectionVC *dateSelectionVC = [[RSDateTimeSelectionVC alloc]initWithNibName:@"RSDateTimeSelectionVC" bundle:[NSBundle mainBundle] withSection:DatePicker dateString:dateSelected];
            RSSelectedSpaLocation *location = [RSSelectedSpaLocation sharedInstance];
            dateSelectionVC.title = [NSString stringWithFormat:@"%@ %@",kBook_Title, location.spaLocation.locationName];
            
            [self.navigationController pushViewController:dateSelectionVC animated:YES];
            [dateSelectionVC release];
        }
            break;
        case ClassServiceSection:
        {
            if (![[subFieldArray objectAtIndex:ClassDateSection] isEqualToString:NONE])
            {
                [self fetchSpaClasses];
            }
            else {
                
                RSAlertView *rsAlertView = [[RSAlertView alloc]initWithTitle:POPUP_Error andMessage:POPUP_Select_Date withDelegate:nil cancelButttonTitle:POPUP_Button_Ok otherButtonTitle:nil];
                [rsAlertView release];
            }
            
        }
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
    cell.cellText.text = [mainFieldArray objectAtIndex:indexPath.row];
    cell.menuDetailText.text = [subFieldArray objectAtIndex:indexPath.row];
    [cell setBgForSelectedCell:tableView forIndex:indexPath];
    [cell setAccessoryViewImage:YES];
    return cell;
}

-(void)fetchSpaClasses
{
    NSString *selectedDate = [subFieldArray objectAtIndex:ClassDateSection];
	DLog(@"Fetching spa classes view: %@",selectedDate );
    
    selectedDate = [DateManager convertIntoResponseStringFromSpecificFormatString:selectedDate dateFormatStyle:MMMM_d_yyyyFormat withTime:NO];
    DLog(@"Fetching spa classes view: %@",selectedDate );
    
    [self startLoadingAnimation];
    dailySpaCLassReqResHandler = [[RSDailySpaClassReqResponseHandler alloc]init];
    [dailySpaCLassReqResHandler setDelegate:self];
    
    
    //Get the selected Spa location from the shared instance
	RSSelectedSpaLocation *location = [RSSelectedSpaLocation sharedInstance];
    [dailySpaCLassReqResHandler fetchDailySpaClassesForSelectedDate:selectedDate withSpaLocationId:[NSString stringWithFormat:@"%d",location.spaLocation.locationID]];
}

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
	else if ([parserModelData isKindOfClass:[RSDailySpaClasses class]])
    {
		[self stopLoadingAnimation];
		self.dailySpaClassesModel = (RSDailySpaClasses *) parserModelData;
		
		
		if ([self.dailySpaClassesModel.spaClasses count] > 0)
        {
            [self createDictionaryAndReloadTable];
		}
		else 
        {
            RSAlertView *rsAlertView = [[RSAlertView alloc]initWithTitle:POPUP_Error andMessage:POPUP_Activity_Data_Unavailable withDelegate:self cancelButttonTitle:POPUP_Button_Ok otherButtonTitle:nil];
            [rsAlertView release];
		}		
	}
	else
    {
		//Exception handling if WS gives an exception
		ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
		[errorPopup initWithTitle:kFaultTitle];
	}	
}

-(void)createDictionaryAndReloadTable
{
    
    classCategoryDictionary = [[NSMutableDictionary alloc]init];
    
    NSArray *classArray = self.dailySpaClassesModel.spaClasses;      //get the refrence of classes in classArray
    
    for (int i= 0; i < [classArray count];i++)
    {
        RSSpaClass *spaClass = (RSSpaClass *)[classArray objectAtIndex:i];
        NSString *spaCategoryKey = [NSString stringWithFormat:@"%@", spaClass.itemCategory];     //key are string
        
        DLog(@"spaCategoryKey %@ = ",spaCategoryKey)	;	
        
        NSArray *lkeyArray = [classCategoryDictionary allKeys];
        
        if ([lkeyArray containsObject:spaCategoryKey])
        {
            NSMutableArray *localEventArray = [classCategoryDictionary objectForKey:spaCategoryKey];
            [localEventArray addObject:spaClass];
            [classCategoryDictionary setObject:localEventArray forKey:spaCategoryKey];		
        }
        else 
        {
            NSMutableArray *localEventArray = [[NSMutableArray alloc] initWithObjects:spaClass,nil];
            [classCategoryDictionary setObject:localEventArray forKey:spaCategoryKey];
            [localEventArray release];			
	    }
        
    }
    //class dictionary is now created
    //check the count of the key 
    //the push tabl;e or cate4gory on condition
    if ([[classCategoryDictionary allKeys] count] == 1 )
    {        
        RSClassServiceTableVC *spaClassTableVC;
        
        spaClassTableVC = [[RSClassServiceTableVC alloc] initWithNibName:@"RSBaseSpaServiceTableVC" bundle:[NSBundle mainBundle] withSpaClassArray: self.dailySpaClassesModel.spaClasses];      
        
        [self.navigationController pushViewController:spaClassTableVC animated:YES];
        [spaClassTableVC release];
    }
    else if([[classCategoryDictionary allKeys] count] > 1 && [[classCategoryDictionary allKeys] count] > 0)
    {
        [classCategoryDictionary setObject:classArray forKey:@"All"];
        
        //call the sub class of the category view base class
        RSSpaClassCategoryVC *classCategoryVC = [[RSSpaClassCategoryVC alloc]initWithNibName:@"RSBaseCategoryVC" bundle:[NSBundle mainBundle] withDictionary:classCategoryDictionary];
        [self.navigationController pushViewController:classCategoryVC animated:YES];
        [classCategoryVC release];
    }else 
    {
        RSAlertView *rsAlertView = [[RSAlertView alloc]initWithTitle:POPUP_Error andMessage:POPUP_Activity_Data_Unavailable withDelegate:self cancelButttonTitle:POPUP_Button_Ok otherButtonTitle:nil];
        [rsAlertView release];
    }		
    
}

@end
