//
//  RSBookMenuVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/28/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSBookMenuVC.h"
#import "ErrorPopup.h"
#import "RSBaseBookTableCell.h"
#import "RSGolfLocationVC.h"
#import "RSClassServiceVC.h"
#import "RSSpaBookingFormVC.h"
#import "RSClassBookingFormVC.h"
#import "RSSelectedGolfLocation.h"
#import "RSSelectedSpaLocation.h"
#import "RSAppDelegate.h"
@implementation RSBookMenuVC
@synthesize golfLocationsModel;
@synthesize spaLocationsModel;


@synthesize isGolfLocation;
-(void)dealloc
{
    [mainFieldArray release];//was missing
    [golfLocationsModel release];
    [spaLocationsModel release];
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
    //allocating memory for main field array only once and removing all object evry time the serive is called on view will Appear
    mainFieldArray = [[NSMutableArray alloc] init];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    RSAppDelegate *appDelegate = (RSAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate showUpdatedLoginButton:YES onController:self];
    [self fetchGolfLocation];

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
#pragma mark - fetch services functions
-(void)fetchGolfLocation
{
    [self startLoadingAnimation];
    golfLocationReqResponseHandler = [[RSGolfLocationReqResponseHandler alloc]init];
    [golfLocationReqResponseHandler setDelegate:self];
    
    [golfLocationReqResponseHandler fetchGolfLocationsRequest];
}
-(void)fetchSpaLocations
{
    [self startLoadingAnimation];
    spaLocationReqResponseHandler = [[RSSpaLocReqResponseHandler alloc]init];
    [spaLocationReqResponseHandler setDelegate:self];
    
    [spaLocationReqResponseHandler fetchSpaLocationsRequest];
}
#pragma mark RSParseBase delegate
-(void)parsingComplete:(id)parserModelData
{	[self stopLoadingAnimation];
	if ([parserModelData isKindOfClass:[Result class]]) {
		[self showErrorMessage:parserModelData];
	}	
	else if ([parserModelData isKindOfClass:[RSGolfLocations class]]) {
		//If the data received is of type RSGolfLocations
		[self golfBookingsDataReceived:parserModelData];
		
		//Create the Spa locations request
		[self fetchSpaLocations];
	}
	else if ([parserModelData isKindOfClass:[RSSpaLocations class]]) {
		//If the data received is of type RSSpaLocations
		[self spaBookingsDataReceived:parserModelData];
        
        if([mainFieldArray count] ==0)
        {
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:NoBookingTitle
                                                                 message:NoBookingMessage
                                                                delegate:nil
                                                       cancelButtonTitle:POPUP_Button_Ok
                                                       otherButtonTitles:nil];
            
            [errorAlert show];
            [errorAlert release];	
            DLog(@"We are currently not accepting mobile reservation at this time.");
        }
        
	}
	else {
		//Exception handling if WS gives an exception
		ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
		[errorPopup initWithTitle:kFaultTitle];
	}	
}
-(void) showErrorMessage:(id)parserModelData
{	
        Result *resultError = (Result *) parserModelData;

		NSString *errorMessage = [NSString stringWithFormat:@"%@", resultError.resultText];
		
		ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
		[errorPopup initWithTitle:errorMessage];
    
}

-(void) golfBookingsDataReceived:(id) parserModelData
{

    //	self.navigationController.navigationBar.userInteractionEnabled = YES;
	self.golfLocationsModel = (RSGolfLocations *) parserModelData;
    //memory for the main array should assigned even if the golf location is zero
    if (mainFieldArray) {
        [mainFieldArray removeAllObjects];

    }

	if ([self.golfLocationsModel.golfLocations count] > 0) {
		//Add "Golf" as static label in an array if Golf locations are available 

        [mainFieldArray addObject:@"Golf"];
        
		self.isGolfLocation = YES;  //set is golf location if data is recieved
		[self.menuTable reloadData];
	}	
    
    //release the golfLocationReqResponseHandler
    [golfLocationReqResponseHandler release];
}

-(void) spaBookingsDataReceived:(id) parserModelData
{

    self.spaLocationsModel = (RSSpaLocations *)parserModelData;
    //If Golf web services are not availble then mainFieldArray should be recreated
    if(!self.isGolfLocation)
    {
        if (mainFieldArray) {
            [mainFieldArray removeAllObjects];
            [mainFieldArray release];
        }
        mainFieldArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
	if ([self.spaLocationsModel.spaLocations count] > 0) {
		//Add Spa locations list into an array
		for (int locationIndex = 0; locationIndex < [self.spaLocationsModel.spaLocations count]; locationIndex++) {
			[mainFieldArray addObject:[[self.spaLocationsModel.spaLocations objectAtIndex:locationIndex] locationName]];
		}	
	}

	[self.menuTable reloadData];

    [spaLocationReqResponseHandler release];
}


#pragma mark - TableView Delegate Method

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"table row selected");
    int objectAtIndex = indexPath.row;
	
	if (indexPath.row == 0 && self.isGolfLocation) {
        DLog(@"Load Golf Locations VC");
        //by default set the selected golflocation be the 1st ob from the array of golf location.
        RSSelectedGolfLocation *selectedGolfLocation = [RSSelectedGolfLocation sharedInstance];
        selectedGolfLocation.golfLocation = [self.golfLocationsModel.golfLocations objectAtIndex:0];
        
        RSGolfLocationVC *golfLocationVC = [[RSGolfLocationVC alloc]initWithNibName:@"RSBaseBookVC" bundle:[NSBundle mainBundle] withGolfLocationModel:self.golfLocationsModel];
        [golfLocationVC setTitle:GolfLocation_ViewTilte];
        [self.navigationController pushViewController:golfLocationVC animated:YES];
        [golfLocationVC release];
        
    }else {
		if (self.isGolfLocation) {
			//objectAtIndex is set for getting the Spa locations objects
			objectAtIndex = indexPath.row - 1;
		}
        
        //Storing the selected spa location and the booking type in appdelegate
            RSAppDelegate *appDelegate = (RSAppDelegate *)[[UIApplication sharedApplication]delegate];
		RSSelectedSpaLocation *location = [RSSelectedSpaLocation sharedInstance];
		location.spaLocation = [self.spaLocationsModel.spaLocations objectAtIndex:objectAtIndex];
        
        if ([[[self.spaLocationsModel.spaLocations objectAtIndex:objectAtIndex] bookingType] 
             isEqualToString:@"All"]) {
            appDelegate.selectedLocBookingType = ALL;
            RSClassServiceVC *classServiceVC = [[RSClassServiceVC alloc]initWithNibName:@"RSBaseBookVC" bundle:[NSBundle mainBundle]];
            [classServiceVC setTitle:[NSString stringWithFormat:@"%@ %@",kBook_Title,[[self.spaLocationsModel.spaLocations objectAtIndex:objectAtIndex] locationName]]];
            
            [self.navigationController pushViewController:classServiceVC animated:YES];
            [classServiceVC release];
        }
        else if ([[[self.spaLocationsModel.spaLocations objectAtIndex:objectAtIndex] bookingType] isEqualToString:@"Class"]) {
            DLog(@"Load Class VC");
            appDelegate.selectedLocBookingType = SINGLE;
            RSClassBookingFormVC *classBookingform = [[RSClassBookingFormVC alloc]initWithNibName:@"RSBaseBookFormVC" bundle:[NSBundle mainBundle]];
            [classBookingform setTitle:[NSString stringWithFormat:@"%@ %@",kBook_Title, location.spaLocation.locationName]];
            [self.navigationController pushViewController:classBookingform animated:YES];
            [classBookingform release];
        }
        else if ([[[self.spaLocationsModel.spaLocations objectAtIndex:objectAtIndex] bookingType] isEqualToString:@"Service"]) {
            DLog(@"Load Service VC");
            appDelegate.selectedLocBookingType = SINGLE;
            RSSpaBookingFormVC *spaBookingform = [[RSSpaBookingFormVC alloc]initWithNibName:@"RSBaseBookFormVC" bundle:[NSBundle mainBundle]];
            [spaBookingform setTitle:[NSString stringWithFormat:@"%@ %@",kBook_Title, location.spaLocation.locationName]];
            [self.navigationController pushViewController:spaBookingform animated:YES];
            [spaBookingform release];
        }
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
    [cell setBgForSelectedCell:tableView forIndex:indexPath];
    [cell setAccessoryViewImage:YES];
    return cell;
}

@end
