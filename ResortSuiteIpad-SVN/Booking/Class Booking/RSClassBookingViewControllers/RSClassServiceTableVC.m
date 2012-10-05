//
//  RSClassServiceTableVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/29/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSClassServiceTableVC.h"
#import "RSBaseServiceTableCell.h"
#import "RSSpaClass.h"
#import "customAccesoryButton.h"
#import "RSAppDelegate.h"
#import "RSSpaClassDescriptionVC.h"
#import "RSSelectedSpaLocation.h"
#import "DateManager.h"
@implementation RSClassServiceTableVC
@synthesize classArray;

-(void)dealloc
{
    [classArray release];
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
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withSpaClassArray:(NSArray *)spaClassesArray
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.classArray = spaClassesArray;
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
    
    self.instructionLbl.backgroundColor = [UIColor whiteColor];
	self.instructionLbl.opaque = YES;
	self.instructionLbl.textColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0];
	[self.instructionLbl setFont:[UIFont boldSystemFontOfSize:FontOfSize14]];
	[self.instructionLbl setText:searchResultText];
    // add select button, note: new y is already calculated
	
    [self AddSelectButtonWithTag:0];
	self.selectButton.enabled = NO;
}

-(void)AddSelectButtonWithTag:(int)rowinfo
{
    // add booking button note new y is already calculated
    
	[self.selectButton setBackgroundColor:[UIColor clearColor]];	
    self.selectButton.tag = rowinfo;
    
    UIImage *disabledBtnImage = [UIImage imageNamed:Disabled_Select_button];
    UIImage *enabledBtnImage = [UIImage imageNamed:Enabled_Select_button];
	
	[self.selectButton setBackgroundImage:disabledBtnImage forState:UIControlStateDisabled];
	[self.selectButton setBackgroundImage:enabledBtnImage forState:UIControlStateNormal];
	
    //
    [self.selectButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)selectAction:(id)sender     //post notification
{
    UIButton *tempButton = (UIButton *)sender;
    DLog(@"tempButton tag = %d",tempButton.tag);
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"spaClassSelected" object:[self.classArray objectAtIndex:tempButton.tag]];    //send the object as notification obj
    
    RSAppDelegate *appDelegate = (RSAppDelegate *)[[UIApplication sharedApplication]delegate];
    if (appDelegate.selectedLocBookingType == ALL) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:BOOK_SERVICE_PAGE_CONTROLLER_COUNT_FOR_ALL] animated:YES];
    }
    else if (appDelegate.selectedLocBookingType == SINGLE)
    {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:BOOK_SERVICE_PAGE_CONTROLLER_COUNT_FOR_CLASSORSERVICE] animated:YES];
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
    DLog(@"table row selected");
    
	self.selectButton.enabled = YES;
    self.selectButton.tag = indexPath.row;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.classArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
	//Create a custom cell to display content on the screen
    RSBaseServiceTableCell *cell = (RSBaseServiceTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *customCellArray = [[NSBundle mainBundle]loadNibNamed:@"RSBaseServiceTableCell" owner:nil options:nil];
        
        
        cell = (RSBaseServiceTableCell*)[customCellArray objectAtIndex:0];
    }
    
    RSSpaClass *selectedClass = (RSSpaClass *)[self.classArray objectAtIndex:indexPath.row];
    cell.serviceNameLbl.text = [selectedClass spaItemName];
    cell.startTimeLbl.text = [self getTimeFromString:[selectedClass startTime]];
    cell.priceLbl.text = [NSString stringWithFormat:@"%.02f", [selectedClass price]];
    cell.serviceDurationLbl.text = [NSString stringWithFormat:@"%.0f",[selectedClass serviceTime]];
    
    customAccesoryButton *dButton = (customAccesoryButton *)cell.customAccessoryButton;
    dButton.path = indexPath;
	[dButton addTarget:self action:@selector(checkThis:) forControlEvents:UIControlEventTouchDown];
    
    return cell;
}

-(void)checkThis:(id)sender
{
    customAccesoryButton *button = (customAccesoryButton *)sender;
    NSIndexPath *indexPath = button.path;
    DLog(@"check this = %d", indexPath.row);
    RSSpaClassDescriptionVC *spaClassDescVC = [[RSSpaClassDescriptionVC alloc] initWithSelectedClass:
                                               [self.classArray objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:spaClassDescVC animated:YES];
    [spaClassDescVC release];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark Set Date Format

- (NSString *) getTimeFromString:(NSString *) dateString
{    
	NSDate *startTime = [DateManager dateFromString:dateString withDateFormat:MMMM_dd_yyyy_hh_mm_aFormat];
    
    NSString *startTimeStr = [DateManager stringFromDate:startTime withDateFormat:hh_mm_aFormat];
	return startTimeStr;
}
@end
