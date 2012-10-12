//
//  DOBPickerView.m
//  ResortSuite
//
//  Created by Cybage on 1/23/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "DOBPickerView.h"
#import "DateManager.h"
@implementation DOBPickerView
@synthesize datePicker;
@synthesize doneButton;
@synthesize delegate;

-(void) dealloc
{
    [datePicker release];
    [doneButton release];
    delegate = nil;
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
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.maximumDate = [NSDate date];
    //set up button
    [doneButton setBackgroundColor:[UIColor clearColor]];
	UIImage *btnImageenabled  = [UIImage imageNamed:kEnabled_Button_img];
	[doneButton setBackgroundImage:btnImageenabled forState:UIControlStateNormal];
    //set the frame below the screen//

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}
- (void)viewDidUnload
{
    delegate = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];
    
}
#pragma mark - done Button action
-(IBAction)doneButtonAction:(id)sender
{
    //call the delegate method and push date value to it

        NSString *dateString = [NSString stringWithString:[DateManager stringFromDate:datePicker.date withDateFormat:dd_MMM_yyyyFormat]];
    DLog(@"date from picker = %@",dateString);

    if (delegate) {
        [delegate dateSelected:dateString];
    }

}
@end
