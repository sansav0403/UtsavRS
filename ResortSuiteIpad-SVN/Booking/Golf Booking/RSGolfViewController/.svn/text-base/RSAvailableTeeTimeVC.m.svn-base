//
//  RSAvailableTeeTimeVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/5/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSAvailableTeeTimeVC.h"
#import "RSGolfTeeTimes.h"
#import "RSGolfConfirmationVC.h"
#import "RSSelectedGolfLocation.h"
@implementation RSAvailableTeeTimeVC

@synthesize AvailableTeeTimeArray;
@synthesize selectedCourseId;
@synthesize selectedNoOfPlayers;

- (void)dealloc
{
    [AvailableTeeTimeArray release];
    [selectedCourseId release];
    [selectedNoOfPlayers release];
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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withTeeTimeArray:(NSArray *)TeeTime withSelectedCourseId:(NSString *)courseID andNoOfPlayer:(NSString *)players
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.AvailableTeeTimeArray = TeeTime;   
        self.selectedCourseId = courseID;
        self.selectedNoOfPlayers = players;
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
    RSSelectedGolfLocation *location = [RSSelectedGolfLocation sharedInstance];
    self.title = [NSString stringWithFormat:@"Book %@", location.golfLocation.locationName];
    self.instructionLbl.text = pleaseSelectText;
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
    DLog(@"golf course selected");    
    
    RSGolfConfirmationVC *golfConfirmation = [[RSGolfConfirmationVC alloc]initWithSelectedTime:
                                                [[AvailableTeeTimeArray objectAtIndex:indexPath.row] dateTime] 
                                                                               andSelectedCourseID:self.selectedCourseId andSelectedPlayer:self.selectedNoOfPlayers];
    [self.navigationController pushViewController:golfConfirmation animated:YES];
    [golfConfirmation release];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [AvailableTeeTimeArray count];
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
    
    RSGolfTeeTime *TeeTime = (RSGolfTeeTime *)[AvailableTeeTimeArray objectAtIndex:indexPath.row];
    NSString *DateString = TeeTime.dateTime;
    cell.cellText.text = [DateString substringFromIndex:[DateString length] - 8];

    [cell setBgForSelectedCell:tableView forIndex:indexPath];
    [cell setAccessoryViewImage:YES];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
