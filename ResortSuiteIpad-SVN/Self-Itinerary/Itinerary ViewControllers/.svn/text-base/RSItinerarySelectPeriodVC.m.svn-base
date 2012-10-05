//
//  RSItinerarySelectPeriodVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/16/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSItinerarySelectPeriodVC.h"
#import "RSAppDelegate.h"
#import "RSItineraryMainVC.h"
#import "DateManager.h"         //to manage date releated problems
#import "RSMyItineraryModel.h"
#import "RSMISelectDatesVC.h"
#import "ErrorPopup.h"
#import "RSAppDelegate.h"
#import "RSAlertView.h"
@implementation RSItinerarySelectPeriodVC

@synthesize guestItinerary;

-(void)dealloc
{
    [mainFieldArray release];

    if (guestItinerary != nil) {
        [guestItinerary release];
        guestItinerary = nil;
    }
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

    [self.headerImageView setImage:[UIImage imageNamed:MyItinerary_HI]];
    mainFieldArray = [[NSArray alloc]initWithObjects:AllFutureBooking_CellTitle,SpecificDate_CellTitle, nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    RSAppDelegate *appDelegate = (RSAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate showUpdatedLoginButton:YES onController:self];
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
    return [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];

}

#pragma mark - TableView Delegate Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Adding selected mask image to the selected row.
    BaseListTableViewCell *cell = (BaseListTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.cellOverlayImageView.image = [UIImage imageNamed:SelectedTableCellBackgroudImage];
    
    DLog(@"table row selected");
    switch (indexPath.section) {
        case AllFurtherBookings:
            {
                /* callthe reqresponse andle and on succesfull push the mainVC obj*/
                //-----------
                requestHandler = [[RSItineraryReqResponseHandler alloc]init];
                [requestHandler setDelegate:self];
                NSDate *currentDate = [NSDate date];
                NSString *startDate = [DateManager stringFromDate:currentDate];
                
                NSString *endDate = @"";
                [self startLoadingAnimation];
                [requestHandler fetchGuestItineraryForHotelWithStartDate:startDate EndDate:endDate];
                //-----------
                
            }
            break;
            
        case SelectDates:
        {
            DLog(@"load date selection viewcontroller");
            
            RSMISelectDatesVC *miDateSelectVC = [[RSMISelectDatesVC alloc]initWithNibName:@"RSMISelectDatesVC" bundle:[NSBundle mainBundle]];
            [self.navigationController pushViewController:miDateSelectVC animated:YES];
            [miDateSelectVC release];
        }
        default:
            break;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseListTableViewCell *cell = (BaseListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        NSArray *customCellArray = [[NSBundle mainBundle]loadNibNamed:@"BaseListTableViewCell" owner:nil options:nil];
        
        for (id currerntObject in customCellArray) {
            if ([currerntObject isKindOfClass:[BaseListTableViewCell class]]) {
                cell = (BaseListTableViewCell *)currerntObject;
                break;
            }
        }
    }
    
    switch (indexPath.section)
	{
		case AllFurtherBookings:
			cell.cellImageView.image = [UIImage imageNamed:MyItineraryByDate_Icon];
			break;
            
		case SelectDates:
			cell.cellImageView.image = [UIImage imageNamed:MyItinerary_Icon];
			break;
		default:
			break;
	}

    cell.cellText.text = [mainFieldArray objectAtIndex:indexPath.section];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [mainFieldArray count];
}

#pragma mark - Request response handler delegate methods
-(void)responseHandledWithObject:(id)dataObject
{
    if ([dataObject isKindOfClass:[RSMyItineraryModel class]]){
        self.guestItinerary = (RSMyItineraryModel *)dataObject; //save the itinerary data in data model
        
        RSItineraryMainVC *itineraryMainVC = [[RSItineraryMainVC alloc]initWithNibName:@"BaseListViewController" bundle:[NSBundle mainBundle] withGuestItinerary:self.guestItinerary];
        [self.navigationController pushViewController:itineraryMainVC animated:YES];
        [itineraryMainVC release];

	}
    else if ([dataObject isKindOfClass:[Result class]])
    {
       //show error alertview
    }
}

#pragma mark - base reqResponse Delegate Method
-(void)parsingComplete:(id)ModelData
{
    [self stopLoadingAnimation];
    //@property (nonatomic, retain) RSMyItineraryModel *guestItinerary;
    if ([ModelData isKindOfClass:[RSMyItineraryModel class]]){
        self.guestItinerary = (RSMyItineraryModel *)ModelData; //save the itinerary data in data model
        if ([self.guestItinerary.guestBookings.folios count] > 0) {
            RSItineraryMainVC *itineraryMainVC = [[RSItineraryMainVC alloc]initWithNibName:@"BaseListViewController" bundle:[NSBundle mainBundle] withGuestItinerary:self.guestItinerary];
            [self.navigationController pushViewController:itineraryMainVC animated:YES];
            [itineraryMainVC release];
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
    [requestHandler release];   //not in dealloc, but here as user can come back and hit server again in this VC
    requestHandler = nil; //commented as causing crash
}

#pragma mark processing of the data received after parsing
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
