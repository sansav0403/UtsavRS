//
//  RSBookingConfirmedVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/1/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSBookingConfirmedVC.h"

@implementation RSBookingConfirmedVC

@synthesize BookingConfirmedMessageLbl;

-(void)dealloc
{
    [BookingConfirmedMessageLbl release];
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
    
    [self.navigationItem setHidesBackButton:YES];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *guaranteeStatus = [prefs stringForKey:GuaranteedKey];
    [self.BookingConfirmedMessageLbl setFont:[UIFont boldSystemFontOfSize:FontOfSize16]];
	self.BookingConfirmedMessageLbl.textColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0];
    
    if ([guaranteeStatus isEqualToString:GuaranteeStatusValueForNo]) {
        self.BookingConfirmedMessageLbl.text = UnGuaranteedBookingMessage;
    }
    else
    {
        self.BookingConfirmedMessageLbl.text = GuaranteedBookingMessage;
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

#pragma mark Buttona action methods
-(IBAction)BookAnotherButtonAction:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(IBAction)HomeViewButtonAction:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
	
	RSAppDelegate *appDelegate = (RSAppDelegate *)[[UIApplication sharedApplication] delegate];
	appDelegate.tabBarController.selectedIndex = HOME_TAB;	
    
    //Pop all controllers from the main screen to show Home screen

    [[appDelegate.tabBarController.viewControllers objectAtIndex:HOME_TAB] popToRootViewControllerAnimated:YES];
}
-(IBAction)veiwItineraryButtonAction:(id)sender;
{
    [self.navigationController popToRootViewControllerAnimated:YES];
	
	RSAppDelegate *appDelegate = (RSAppDelegate *)[[UIApplication sharedApplication] delegate];
	appDelegate.tabBarController.selectedIndex = 2;
    [[appDelegate.tabBarController.viewControllers objectAtIndex:2] popToRootViewControllerAnimated:YES];
}
@end
