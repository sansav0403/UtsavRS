//
//  RSBaseSpaServiceTableVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/29/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSBaseSpaServiceTableVC.h"
#import "RSBaseServiceTableCell.h"
@implementation RSBaseSpaServiceTableVC

@synthesize serviceNameLbl;
@synthesize startTimeLbl;
@synthesize priceLbl;
@synthesize serviceDurationLbl;
@synthesize instructionLbl;
@synthesize seperatorLbl;
@synthesize serviceTable;
@synthesize selectButton;

-(void)dealloc
{
    [serviceNameLbl release];
    [startTimeLbl release];
    [priceLbl release];
    [serviceDurationLbl release];
    [instructionLbl release];
    [seperatorLbl release];
    [serviceTable release];
    [selectButton release];
    
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
    [self.seperatorLbl setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:SeparatorImage]]];
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
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
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

    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
