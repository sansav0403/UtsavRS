//
//  RSClassServiceVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/28/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSClassServiceVC.h"
#import "RSBaseBookTableCell.h"
#import "RSSpaBookingFormVC.h"
#import "RSClassBookingFormVC.h"

@implementation RSClassServiceVC

-(void)dealloc
{
    [mainFieldArray release];
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
    mainFieldArray = [[NSArray alloc]initWithObjects:ClassActivityCellText, SpaBookingFormService, nil];
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

    
    if (indexPath.row == ClassSection) {
    
    DLog(@"Load Class VC");
    RSClassBookingFormVC *classBookingform = [[RSClassBookingFormVC alloc]initWithNibName:@"RSBaseBookFormVC" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:classBookingform animated:YES];
    [classBookingform release];
    }
    else if (indexPath.row == ServiceSection) {
        
        RSSpaBookingFormVC *spaBookingform = [[RSSpaBookingFormVC alloc]initWithNibName:@"RSBaseBookFormVC" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:spaBookingform animated:YES];
        [spaBookingform release];
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
    cell.cellText.text =[mainFieldArray objectAtIndex:indexPath.row];
    
    [cell setBgForSelectedCell:tableView forIndex:indexPath];
    [cell setAccessoryViewImage:YES];
    return cell;
}
@end
