//
//  RSBaseCategoryVC.m
//  
//
//  Created by Cybage on 2/29/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSBaseCategoryVC.h"

@implementation RSBaseCategoryVC
@synthesize keyArray = _keyArray;
@synthesize categoryDictionary = _categoryDictionary;
@synthesize pickerView;
@synthesize selectButton;
@synthesize instructionLbl;

- (void)dealloc
{
    [_categoryDictionary release];
    [_keyArray release];
    
    [pickerView release];
    [selectButton release];
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
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withDictionary:(NSDictionary *)dictionary
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.categoryDictionary = dictionary;
        self.keyArray = [dictionary allKeys];
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
    
    //sort the key in alphabatical order
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES selector:@selector(caseInsensitiveCompare:)];
    self.keyArray = [[self.categoryDictionary allKeys] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    
    //add select button
    
    [self AddSelectButtonWithTag:0];    //by default the 0th index of key array is set as tag ie All
    self.selectButton.enabled = YES;
}

-(void)AddSelectButtonWithTag:(int)rowinfo
{
    // add booking button note new y is already calculated
    [self.selectButton setBackgroundColor:[UIColor clearColor]];	
    self.selectButton.tag = rowinfo;
    
    
    UIImage * disabledImage =  [UIImage imageNamed:Disabled_Select_button];
    
    UIImage * enabledImage =  [UIImage imageNamed:Enabled_Select_button];
    
    [self.selectButton setBackgroundImage:disabledImage forState:UIControlStateDisabled];
    [self.selectButton setBackgroundImage:enabledImage forState:UIControlStateNormal];
    
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
	return [_keyArray count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	
    if ([_keyArray count] > 0) 
    {
        return [_keyArray objectAtIndex:row];
    }
	return @"";
} 

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
	  inComponent:(NSInteger)component
{ 	
    self.selectButton.enabled = YES;
    self.selectButton.tag = row;    //tag store the index of the key from the key array.
    
}

@end
