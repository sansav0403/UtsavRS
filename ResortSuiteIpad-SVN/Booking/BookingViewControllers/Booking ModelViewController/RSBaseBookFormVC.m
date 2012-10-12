//
//  RSBaseBookFormVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/28/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSBaseBookFormVC.h"
#import "RSBaseBookTableCell.h"

@implementation RSBaseBookFormVC
@synthesize bookMenuTable;
@synthesize doneButton;
@synthesize instructionLbl;

-(void)dealloc
{
    [bookMenuTable release];
    [doneButton release];
    [instructionLbl release];
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
    // Do any additional setup after loading the view from its nib.
    self.bookMenuTable.backgroundColor = [UIColor clearColor];
    self.bookMenuTable.backgroundView = nil;
    self.bookMenuTable.separatorColor = [UIColor colorWithPatternImage:[UIImage imageNamed:BookTableColor]];
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

-(IBAction)doneButtonAction:(id)sender
{
    
}


#pragma mark - TableView Delegate Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"table row selected");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
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
    cell.cellText.text = @"book menu";  //these are only test strings for base class
    cell.menuDetailText.text = @"none";
    [cell setBgForSelectedCell:tableView forIndex:indexPath];
    [cell setAccessoryViewImage:YES];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
@end
