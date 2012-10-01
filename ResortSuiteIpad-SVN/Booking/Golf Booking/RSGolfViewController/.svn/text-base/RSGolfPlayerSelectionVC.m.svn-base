//
//  RSGolfPlayerSelectionVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/5/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSGolfPlayerSelectionVC.h"
#import "RSBaseBookTableCell.h"

@implementation RSGolfPlayerSelectionVC
@synthesize playerPicker;
@synthesize instructionLbl;
@synthesize selectButton;
@synthesize playerTable;

- (void)dealloc
{
    [playerPicker release];
    [instructionLbl release];
    [selectButton release];    
    [playerTable release];
    
    [NoPlayersArray release];
    [mainFieldArray release];
    [subFieldArray release];
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
    [self.playerTable setBackgroundView:nil];   //to make clear color
    // Do any additional setup after loading the view from its nib.
    NoPlayersArray = [[NSArray alloc]initWithObjects:@"                       1",@"                       2",@"                       3",@"                       4" ,nil];
    
	if (mainFieldArray) {
		[mainFieldArray removeAllObjects];
		[mainFieldArray release];
	}
    mainFieldArray = [[NSMutableArray alloc] initWithObjects:NoOfPlayerCellText,nil];	
    
    if (subFieldArray) {
		[subFieldArray removeAllObjects];
		[subFieldArray release];
	}
    
    subFieldArray = [[NSMutableArray alloc] initWithObjects:DefaultNoOfPlayers,nil]; //no of plyaer = 2 by default.
    [self updateSubViews];


}

-(void)updateSubViews
{
    self.instructionLbl.text = pleaseSelectText;
	[self.instructionLbl setFont:[UIFont boldSystemFontOfSize:FontOfSize17]];
	self.instructionLbl.textColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0];
    
    [self.selectButton setBackgroundColor:[UIColor clearColor]];
	self.selectButton.enabled = YES;
	
	UIImage *btnImageDisabled  = [UIImage imageNamed:Disabled_Select_button];
	
	UIImage *btnImageenabled  = [UIImage imageNamed:Enabled_Select_button];
	
	[self.selectButton setBackgroundImage:btnImageDisabled forState:UIControlStateDisabled];
	[self.selectButton setBackgroundImage:btnImageenabled forState:UIControlStateNormal];
    
    [self.playerPicker selectRow:1 inComponent:0 animated:YES];
}
-(IBAction)selectButtonAction:(id)sender
{
    //Post notification with the selected value
	[[NSNotificationCenter defaultCenter] postNotificationName:@"NoOfPlayerSelected" 
														object:[subFieldArray objectAtIndex:0]];
	
	[self.navigationController popViewControllerAnimated:YES];
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


#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [NoPlayersArray count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
	return [NoPlayersArray objectAtIndex:row] ;
} 

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
	  inComponent:(NSInteger)component
{ 
	[subFieldArray removeObjectAtIndex:0];
	
    
    [subFieldArray insertObject:[[NoPlayersArray objectAtIndex:row]stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]] atIndex:0];
    
	self.selectButton.enabled = YES;
	[self.playerTable reloadData];
}


#pragma mark - TableView Delegate Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"table row selected");
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
	//Store the text content for the cell
	cell.cellText.text = [mainFieldArray objectAtIndex:indexPath.row];	
    
	cell.menuDetailText.text = [subFieldArray objectAtIndex:indexPath.row];

    
    [cell setBgForSelectedCell:tableView forIndex:indexPath];
    [cell setAccessoryViewImage:NO];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
