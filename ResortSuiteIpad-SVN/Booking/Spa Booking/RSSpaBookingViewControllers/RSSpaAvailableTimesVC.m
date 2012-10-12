//
//  RSSpaAvailableTimesVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/2/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSSpaAvailableTimesVC.h"
#import "RSBaseBookTableCell.h" 
#import "RSSpaAvailibility.h"
#import "RSSpaServiceConfirmationVC.h"
#import "RSSelectedSpaLocation.h"

@implementation RSSpaAvailableTimesVC

@synthesize availableTimes;
@synthesize spaServiceSelected;
@synthesize selectedStaffName;
@synthesize selectedStaffGender;

- (void)dealloc {
	[availableTimes release];
	[spaServiceSelected release];
    
    [selectedStaffName release];//not released earlier
    [selectedStaffGender release];
	
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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withAvailableTimes:(NSArray *)times forSelectedSpaService:(RSSpaService *)spaService
    WithSelectedStaff:(NSString *)staffName andGender:(NSString *)staffGender
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.availableTimes = times;
		self.spaServiceSelected = spaService;
		self.selectedStaffName = staffName;
		self.selectedStaffGender = staffGender;
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
    self.instructionLbl.text = SpaAvailableTimeText;
	self.instructionLbl.numberOfLines = 3;
	[self.instructionLbl setFont:[UIFont boldSystemFontOfSize:FontOfSize16]];
    
	self.instructionLbl.textColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0];
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
    DLog(@"table row selected");
    RSSpaServiceConfirmationVC *spaConfirmationView = [[RSSpaServiceConfirmationVC alloc] 
                                                       initWithSpaAvailibilityArray:[NSArray arrayWithObject:[self.availableTimes objectAtIndex:indexPath.row]]
                                                       forSelectedSpaService:self.spaServiceSelected
                                                       WithSelectedStaff:self.selectedStaffName andGender:self.selectedStaffGender];
    

    self.selectedStaffGender = nil;
    self.selectedStaffName = nil;
	
	[self.navigationController pushViewController:spaConfirmationView animated:YES];
	[spaConfirmationView release];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [availableTimes count];
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
    
    RSSpaAvailibility *spaAvailability = [availableTimes objectAtIndex:indexPath.row];
    cell.cellText.text = [spaAvailability.startTime substringFromIndex:[spaAvailability.startTime length] -8];
    [cell setBgForSelectedCell:tableView forIndex:indexPath];
    [cell setAccessoryViewImage:YES];
    return cell;
}

@end
