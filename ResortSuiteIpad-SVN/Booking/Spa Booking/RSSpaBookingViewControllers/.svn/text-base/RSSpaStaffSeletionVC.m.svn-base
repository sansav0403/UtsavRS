//
//  RSSpaStaffSeletionVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/1/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSSpaStaffSeletionVC.h"
#import "RSBaseBookTableCell.h"
#import "RSSelectedSpaLocation.h"
@implementation RSSpaStaffSeletionVC

@synthesize prefStaffNames;
@synthesize prefStaffPicker;
@synthesize selectButton;
@synthesize instructioLbl;
@synthesize mainTableView;
-(void)dealloc
{
    [prefStaffGenders release]; //released after leak being found in instrument
    [prefStaffNames release];
    [prefStaffPicker release];
    [selectButton release];
    [instructioLbl release];
    [mainTableView release];
    //----------released after leake found in instrument
    [mainFieldArray release];
    [subFieldArray release];
    //------------------------------
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
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withSection:(int) section prefStaffs:(NSArray *) prefstaffs
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        pickerType = section;
        self.prefStaffNames = prefstaffs;
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
    RSSelectedSpaLocation *location = [RSSelectedSpaLocation sharedInstance];
    self.title = [NSString stringWithFormat:@"%@ %@",kBook_Title,location.spaLocation.locationName];
    if (mainFieldArray) {
		[mainFieldArray removeAllObjects];
		[mainFieldArray release];
	}
	if (pickerType == PrefStaffGenderPicker) {
		mainFieldArray = [[NSMutableArray alloc] initWithObjects:SpaBookingFormStafGender,nil];
	}
	else if (pickerType == PrefStaffPicker)
	{
		mainFieldArray = [[NSMutableArray alloc] initWithObjects:SpaBookingFormStaff,nil];
	}		
    
	if (subFieldArray) {
		[subFieldArray removeAllObjects];
		[subFieldArray release];
	}
	subFieldArray = [[NSMutableArray alloc] initWithObjects:SpaBookingNoPref, nil];  // by deafult no pref in sub array
    //thus when button is selected without selecting from picker.No pref is passed via notification.
    
	if (prefStaffGenders) {
		[prefStaffGenders removeAllObjects];
		[prefStaffGenders release];
	}	
	prefStaffGenders = [[NSMutableArray alloc] initWithObjects:SpaBookingNoPref, Gender_Male, Gender_Female, nil];
	
//    //Add UI controls to the view
        [self addControlsToView];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [mainFieldArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	//Create a custom cell to display content on the screen
    RSBaseBookTableCell *cell = (RSBaseBookTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *customCellArray = [[NSBundle mainBundle]loadNibNamed:@"RSBaseBookTableCell" owner:nil options:nil];
        
        
        cell = (RSBaseBookTableCell*)[customCellArray objectAtIndex:0];
    }
    cell.cellText.text = [mainFieldArray objectAtIndex:indexPath.row];
    cell.menuDetailText.text = [subFieldArray objectAtIndex:indexPath.row];
    [cell setBgForSelectedCell:tableView forIndex:indexPath];
    [cell setAccessoryViewImage:NO];
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	if (pickerType == PrefStaffGenderPicker) {
		return 3;
	}
	else if (pickerType == PrefStaffPicker) {
		return [prefStaffNames count];
	}
	return 0;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	if (pickerType == PrefStaffGenderPicker) {
		return [prefStaffGenders objectAtIndex:row];
	}
	else if (pickerType == PrefStaffPicker) {
		return [prefStaffNames objectAtIndex:row];
	}
	return @"";
} 

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
	  inComponent:(NSInteger)component
{ 
	[subFieldArray removeObjectAtIndex:0];
	
	if (pickerType == PrefStaffGenderPicker) {		
		[subFieldArray insertObject:[prefStaffGenders objectAtIndex:row] atIndex:0];
	}
	else if (pickerType == PrefStaffPicker) {
		[subFieldArray insertObject:[prefStaffNames objectAtIndex:row] atIndex:0];
	}
	self.selectButton.enabled = YES;
	[mainTableView reloadData];
}


-(void) addControlsToView
{
    self.mainTableView.backgroundView = nil;//to make group table clearcolor
    self.instructioLbl.text = pleaseSelectText;
	[self.instructioLbl setFont:[UIFont boldSystemFontOfSize:FontOfSize17]];
	self.instructioLbl.textColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0];
    
    self.selectButton.enabled = YES;
	
	UIImage *btnImageDisabled  = [UIImage imageNamed:kDisabled_Button_img];
	
	UIImage *btnImageenabled  = [UIImage imageNamed:kEnabled_Button_img];
	
	[self.selectButton setBackgroundImage:btnImageDisabled forState:UIControlStateDisabled];
	[self.selectButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];    
    
	[self.selectButton setBackgroundImage:btnImageenabled forState:UIControlStateNormal];
    [self.selectButton setTitle:kSelect_Title forState:UIControlStateNormal];
    [self.selectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.selectButton.titleLabel setFont:[UIFont boldSystemFontOfSize:kLabelTextFontSize]];
    [self.selectButton titleLabel].shadowOffset = CGSizeMake(0, 1);
	
	//Action for fetching the Spa Classes
	[self.selectButton addTarget:self action:@selector(selectPrefStaffGenderOrName:) 
		   forControlEvents:UIControlEventTouchUpInside];
    
}

//Send the staff gender or name selection
-(void) selectPrefStaffGenderOrName: (id) sender
{
	//Post notification with the selected value
	[[NSNotificationCenter defaultCenter] postNotificationName:@"StaffPickerValueChanged" 
														object:[subFieldArray objectAtIndex:0]];
	
	[self.navigationController popViewControllerAnimated:YES];
}

@end
