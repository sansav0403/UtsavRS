//
//  RSGolfCoursesVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/28/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSGolfCoursesVC.h"
#import "RSBaseBookTableCell.h"
#import "ErrorPopup.h"
#import "RSGolfCourses.h"
#import "RSGolfBookingFormVC.h"
@implementation RSGolfCoursesVC
@synthesize golfLocationID;


-(void)dealloc
{
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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withGolfLocationID:(int)locationID
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.golfLocationID = locationID;
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
    //create array to store all the Golf Courses
    golfCourseArray = [[NSMutableArray alloc]initWithObjects:@" ", nil];
    TableDataArray = [[NSMutableArray alloc]initWithObjects:@" ", nil];
    
    /*the golfcourse req res handler*/
    [self startLoadingAnimation];
    golfCourseReqResponseHandler = [[RSGolfCourseReqResponseHandler alloc]init];
    [golfCourseReqResponseHandler setDelegate:self];
    
    [golfCourseReqResponseHandler fetchGolfCoursesForLocationId:self.golfLocationID];
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
    //create class for courses and pass the selected golf location iD
    RSGolfCourse *golfCourse = (RSGolfCourse *)[TableDataArray objectAtIndex:indexPath.row];
    RSGolfBookingFormVC *golfBookingForm = [[RSGolfBookingFormVC alloc]initWithNibName:@"RSBaseBookFormVC" bundle:[NSBundle mainBundle] withCourseId:golfCourse.courseId];
    
    [self.navigationController pushViewController:golfBookingForm animated:YES];
    [golfBookingForm release];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return [TableDataArray count];
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
    // Configure the cell...
    
    DLog(@"table data array = %d",[TableDataArray count]);
	if (([TableDataArray count] == 1) &&([[TableDataArray objectAtIndex:indexPath.row] isKindOfClass:[NSString class]])) {
        cell.cellText.text = [TableDataArray objectAtIndex:indexPath.row]; //older crash
    }
    else
    {
        RSGolfCourse *golfCourse = (RSGolfCourse *)[TableDataArray objectAtIndex:indexPath.row];
        cell.cellText.text = golfCourse.courseName;	
    }
    
    [cell setBgForSelectedCell:tableView forIndex:indexPath];
    [cell setAccessoryViewImage:YES];
    return cell;
}

#pragma mark RSParseBase delegate delegate
-(void)parsingComplete:(id)parserModelData
{	
	
	[self stopLoadingAnimation];
	if ([parserModelData isKindOfClass:[Result class]])
    {
		//[self showErrorMessage:parserModelData];
        Result *resultError = (Result *) parserModelData;		
		NSString *errorMessage = [NSString stringWithFormat:@"%@", resultError.resultText];
		
		ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
		[errorPopup initWithTitle:errorMessage];
	}	
	else if ([parserModelData isKindOfClass:[RSGolfCourses class]])
    {
		//If the data received is of type RSSpaServices fill the service into array
        RSGolfCourses *golfCoursesModel = (RSGolfCourses *)parserModelData;
        
        
        [golfCourseArray removeAllObjects];
        [golfCourseArray addObjectsFromArray:golfCoursesModel.golfCources];
        
        [TableDataArray removeAllObjects];
        [TableDataArray addObjectsFromArray:golfCourseArray];
        
        [self.menuTable reloadData];
       
    }else {
		//Exception handling if WS gives an exception
		ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
		[errorPopup initWithTitle:kFaultTitle];
	}	
    
    
}
@end
