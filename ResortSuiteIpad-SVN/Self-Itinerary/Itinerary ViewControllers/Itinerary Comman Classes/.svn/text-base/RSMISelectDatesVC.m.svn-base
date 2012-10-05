//
//  RSMGSelectDatesVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/27/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSMISelectDatesVC.h"
#import "RSDateselectionTableCell.h"
#import "DateManager.h"
#import "RSItineraryMainVC.h"
#import "RSMyItineraryModel.h"
#import "ErrorPopup.h"
#import "RSAppDelegate.h"
#import "RSAlertView.h"
@implementation RSMISelectDatesVC
@synthesize dateTable;
@synthesize datePicker;
@synthesize doneButton;

@synthesize startDate;
@synthesize endDate;
@synthesize pathForfirstCell;
@synthesize pathForcurrentSelectedCell;
@synthesize guestItinerary;
-(void)dealloc
{
    [dateTable release];
    [datePicker release];
    [doneButton release];
    
    [startDate release];
    [endDate release];
    [endDateString release];
    [startDateString release];
    [pathForfirstCell release];
    [pathForcurrentSelectedCell release];
    [guestItinerary release];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.@"Select Dates";

    [self setTitle:SelectDates_ViewTitle];
    //Table initialization
	dateTable.rowHeight = 44;
	dateTable.backgroundColor = [UIColor clearColor];
    dateTable.backgroundView = nil;
    //Date Picker initialization
	self.datePicker.datePickerMode = UIDatePickerModeDate;
	self.datePicker.hidden = NO;
	self.datePicker.date = [NSDate date];
	
	//Action on Date Picker
	[datePicker addTarget:self
	               action:@selector(changeDateInTableCell:)
	     forControlEvents:UIControlEventValueChanged];
    
    endDateString = [[NSMutableString alloc]initWithString:@""];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
    dateFormatter.dateStyle = NSDateFormatterFullStyle;
    self.startDate = datePicker.date;
    startDateString = [[NSMutableString alloc]initWithString:[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:datePicker.date]]];
    [dateFormatter release];
    currentSelectedRowIndex = MIStartDateSection; //should be selected by default
    [self drawDoneButton];
}
-(void)drawDoneButton
{
    // add booking button note new y is already calculated
    UIImage *disabledBtnImage = [UIImage imageNamed:Disabled_Done_button];
    UIImage *enabledBtnImage = [UIImage imageNamed:Enabled_Done_button];
	
	[doneButton setBackgroundImage:disabledBtnImage forState:UIControlStateDisabled];
	[doneButton setBackgroundImage:enabledBtnImage forState:UIControlStateNormal];
    
    doneButton.enabled = NO;    
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

#pragma mark - event method of picker view
- (void)changeDateInTableCell:(id)sender{
    //Use NSDateFormatter to write out the date in a friendly format
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
    dateFormatter.dateStyle = NSDateFormatterFullStyle;
    
    //Set the labels on selection of the date from the picker
    if (currentSelectedRowIndex == MIStartDateSection) {	
    	self.startDate = datePicker.date;
        [startDateString setString:[NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:datePicker.date]]];
         //reload the selected row only
    	[dateTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:pathForcurrentSelectedCell] withRowAnimation:UITableViewRowAnimationNone];
    	}
  	else if (currentSelectedRowIndex == MIEndDateSection) {	
  		self.endDate = datePicker.date;
        [endDateString setString:[NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:datePicker.date]]];
        //reload the selected row only
        [dateTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:pathForcurrentSelectedCell] withRowAnimation:UITableViewRowAnimationNone];
        RSDateselectionTableCell* cell = (RSDateselectionTableCell*)[dateTable cellForRowAtIndexPath:self.pathForcurrentSelectedCell];
        
        UIImageView *BackgroundImageView = [[UIImageView alloc] init];
        BackgroundImageView.image = [UIImage imageNamed:bottom_arrow_image];
        cell.backgroundView = BackgroundImageView;
        [BackgroundImageView release];

        }	
	[dateFormatter release];
       
      if (! [startDateString isEqualToString:@""] && ! [endDateString isEqualToString:@""]) 
      {
            doneButton.enabled = YES;
      }
}

-(IBAction) doneButtonAction:(id)sender
{	
	//Call the WS if End Date is greater than Start Date, otherwise show an alert
    if (! [startDateString isEqualToString:@""] && ! [endDateString isEqualToString:@""]) 
	{
		switch ([self.startDate compare:self.endDate]) {
			case NSOrderedAscending:{
				
				NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                //[dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
				[dateFormatter setDateFormat:yyyy_MM_ddFormat];
                
                requestHandler = [[RSItineraryReqResponseHandler alloc]init];
                [requestHandler setDelegate:self];

                NSString *startDateforFunc = [DateManager stringFromDate:startDate];
                
                NSString *endDateforFunc = [DateManager stringFromDate:endDate];
                [self startLoadingAnimation];
                [requestHandler fetchGuestItineraryForHotelWithStartDate:startDateforFunc EndDate:endDateforFunc];
                

				
				[dateFormatter release];
			}
				break;
				
			case NSOrderedSame:
				
			case NSOrderedDescending:{
                
                RSAlertView *rsAlertView = [[RSAlertView alloc]initWithTitle:POPUP_Start_End_Date andMessage:@"" withDelegate:nil cancelButttonTitle:ALERT_OK_TITLE otherButtonTitle:nil];
                [rsAlertView release];
			}			
				break;
		}	
	}
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return MINoOfDatesSections;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
	//Create a custom cell to display content on the screen
    RSDateselectionTableCell *cell = (RSDateselectionTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *customCellArray = [[NSBundle mainBundle]loadNibNamed:@"RSDateselectionTableCell" owner:nil options:nil];
        

        cell = (RSDateselectionTableCell*)[customCellArray objectAtIndex:0];
    }
	
	// Configure the cell...
    
	//Create a lable to display the content in the cell
	cell.cellText.font = [UIFont boldSystemFontOfSize:FontOfSize15];
    
	if (indexPath.row == MIStartDateSection) {		
		cell.cellText.text = DurationSelection_Start;	
        cell.detailText.text = startDateString;
        
        
	}
	else if(indexPath.row == MIEndDateSection){		
		cell.cellText.text = DurationSelection_Ends;
        cell.detailText.text = endDateString;

        
	}
    DLog(@"enddatestring = %@",endDateString);
    DLog(@"sartDateString = %@",startDateString);
    //Set the bg image for selected cell
	[cell setBgForSelectedCell:tableView forIndex:indexPath];
    
    //set the start date/1st row selected by default.
    if (indexPath.row == 0) {
        UIImageView *BackgroundImageView = [[UIImageView alloc] init];
        BackgroundImageView.image = [UIImage imageNamed:top_arrow_image];
        cell.backgroundView = BackgroundImageView;
        [BackgroundImageView release];
        self.pathForfirstCell = indexPath;
        self.pathForcurrentSelectedCell = indexPath;
    }

    return cell;
}

#pragma mark -
#pragma mark Table view delegate

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    RSDateselectionTableCell *cell  = (RSDateselectionTableCell *)[tableView cellForRowAtIndexPath:self.pathForfirstCell];
    UIImageView *BackgroundImageView = [[UIImageView alloc] init];
    BackgroundImageView.image = [UIImage imageNamed:TopNoArrow_white];
    cell.backgroundView = BackgroundImageView;
    [BackgroundImageView release];
    
    self.pathForcurrentSelectedCell = indexPath;
	if (indexPath.row == MIStartDateSection) {
		currentSelectedRowIndex = MIStartDateSection;
        
	}
	else if (indexPath.row == MIEndDateSection) {
		currentSelectedRowIndex = MIEndDateSection;
	}

    
    if (! [startDateString isEqualToString:@""] && ! [endDateString isEqualToString:@""]) 
    {
        doneButton.enabled = YES;
    }
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - base reqResponse Delegate Method
-(void)parsingComplete:(id)ModelData
{
    [self stopLoadingAnimation];
    //@property (nonatomic, retain) RSMyItineraryModel *guestItinerary;
    if ([ModelData isKindOfClass:[RSMyItineraryModel class]]){
        self.guestItinerary = (RSMyItineraryModel *)ModelData; //save the itinerary data in data model
        if ([self.guestItinerary.guestBookings.folios count] > 0) {
            RSItineraryMainVC *groupMainVC = [[RSItineraryMainVC alloc]initWithNibName:@"BaseListViewController" bundle:[NSBundle mainBundle] withGuestItinerary:self.guestItinerary];
            [self.navigationController pushViewController:groupMainVC animated:YES];
            [groupMainVC release];
        }
        else
        {
            RSAlertView *rsAlertView = [[RSAlertView alloc]initWithTitle:POPUP_Error andMessage:POPUP_Booking_Unavailable withDelegate:nil cancelButttonTitle:POPUP_Button_Ok otherButtonTitle:nil];
            [rsAlertView release];
        }


	}
    else if ([ModelData isKindOfClass:[Result class]])
    {
        //show error alertview
        [self showErrorMessage:ModelData];
    }
}
- (void)showErrorMessage:(id)parserModelData
{
    
    Result * result = (Result *) parserModelData;
    
    NSString *errorMessage = [NSString stringWithFormat:@"%@", result.resultText];
    
    ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
    [errorPopup initWithTitle:errorMessage];
    
    RSAppDelegate *appDelegate = (RSAppDelegate *)[[UIApplication sharedApplication]delegate];
    appDelegate.tabBarController.selectedIndex = 0; 
    
}

@end
