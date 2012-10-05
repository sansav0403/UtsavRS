//
//  RSGolfLocationVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/28/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSGolfLocationVC.h"
#import "RSBaseBookTableCell.h"
#import "RSGolfCoursesVC.h"
#import "RSSelectedGolfLocation.h"
@implementation RSGolfLocationVC
@synthesize golfLocationsModel;

-(void)dealloc
{
    [golfLocationsModel release];
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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withGolfLocationModel:(RSGolfLocations *)golfLocations
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.golfLocationsModel = golfLocations;
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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/
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
    RSSelectedGolfLocation *selectedGolfLocation = [RSSelectedGolfLocation sharedInstance];
    selectedGolfLocation.golfLocation = [self.golfLocationsModel.golfLocations objectAtIndex:indexPath.row];
    
    //create class for courses and pass the selected golf location iD
    RSGolfCoursesVC *golfCourses = [[RSGolfCoursesVC alloc]initWithNibName:@"RSBaseBookVC" bundle:[NSBundle mainBundle] withGolfLocationID:[[[self.golfLocationsModel.golfLocations objectAtIndex:indexPath.row] locationId] intValue]];
    [golfCourses setTitle:GolfCourse_ViewTilte];
    [self.navigationController pushViewController:golfCourses animated:YES];
    [golfCourses release];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.golfLocationsModel.golfLocations count];
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
    cell.cellText.text = [[self.golfLocationsModel.golfLocations objectAtIndex:indexPath.row] locationName];
    [cell setBgForSelectedCell:tableView forIndex:indexPath];
    [cell setAccessoryViewImage:YES];
    return cell;
}
@end
