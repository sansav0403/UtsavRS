    //
//  RSSpaBookingConfirmationVC.m
//  ResortSuite
//
//  Created by Cybage on 14/10/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import "RSSpaBookingConfirmationVC.h"
#import "RSMainViewController.h"

#define yPosition		115

@implementation RSSpaBookingConfirmationVC

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	    
	[ResortSuiteAppDelegate setCurrentScreenImageWithWhiteOverlay:Application_BackgroundScreen controller:self];
	[ResortSuiteAppDelegate changeNavigationBarTitleFormat:self text:ConfirmBooking_ViewTilte fontSize:nil];
	

    [self.navigationItem setHidesBackButton:YES];
    
	//Display label to the view
	UILabel *instructionLabel = [[UILabel alloc] initWithFrame:CGRectMake(actionButtonXcord, 50, 300, 90)];
    //instruction label to change upon the guarantee status of authorization
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *guaranteeStatus = [prefs stringForKey:GuaranteedKey];
    if ([guaranteeStatus isEqualToString:GuaranteeStatusValueForNo]) {
        instructionLabel.text = UnGuaranteedBookingMessage;
    }
    else
    {
        instructionLabel.text = GuaranteedBookingMessage;
    }
	
    
	instructionLabel.numberOfLines = 4;
	instructionLabel.backgroundColor = [UIColor clearColor];
	[instructionLabel setFont:[UIFont boldSystemFontOfSize:12]];
	instructionLabel.textColor = [UIColor blackColor];
	[self.view addSubview:instructionLabel];
	[instructionLabel release];
	
	//Add Book Another Button
	UIButton *bookAnotherButton = [[UIButton alloc] initWithFrame:CGRectMake(actionButtonXcord, yPosition+20, actionButtonWidth, actionButtonHeight)];
	[bookAnotherButton setBackgroundColor:[UIColor clearColor]];
	
	/*UIImage *enabledbookAnotherImage  = [UIImage imageNamed:Book_Another_Service_button];
	[bookAnotherButton setBackgroundImage:enabledbookAnotherImage forState:UIControlStateNormal];*/
	
    UIImage *enabledBtnImage  = [UIImage imageNamed:kEnabled_Button_img];
    
	[bookAnotherButton setBackgroundImage:enabledBtnImage forState:UIControlStateNormal];
	[bookAnotherButton setTitle:kBookAnotherService_Title forState:UIControlStateNormal];
    [bookAnotherButton.titleLabel setFont:[UIFont boldSystemFontOfSize:kLabelTextFontSize]];
    [bookAnotherButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bookAnotherButton titleLabel].shadowOffset = CGSizeMake(0, -1);
    
    
	[self.view addSubview:bookAnotherButton];
	[bookAnotherButton release];	
	[bookAnotherButton addTarget:self action:@selector(bookAnotherPressed:) 
			   forControlEvents:UIControlEventTouchUpInside];
	
	//Add View Itinerary Button
	UIButton *viewItineraryButton = [[UIButton alloc] initWithFrame:CGRectMake(actionButtonXcord, yPosition+80, actionButtonWidth, actionButtonHeight)];
	[viewItineraryButton setBackgroundColor:[UIColor clearColor]];
	
	/*UIImage *enabledItineraryImage  = [UIImage imageNamed:View_Itinerary_button];
	[viewItineraryButton setBackgroundImage:enabledItineraryImage forState:UIControlStateNormal];*/
    
    [viewItineraryButton setBackgroundImage:enabledBtnImage forState:UIControlStateNormal];
	[viewItineraryButton setTitle:kViewItinerary_Title forState:UIControlStateNormal];
    [viewItineraryButton.titleLabel setFont:[UIFont boldSystemFontOfSize:kLabelTextFontSize]];
    [viewItineraryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [viewItineraryButton titleLabel].shadowOffset = CGSizeMake(0, -1);
	
	[self.view addSubview:viewItineraryButton];
	[viewItineraryButton release];
	
	[viewItineraryButton addTarget:self action:@selector(viewItineraryPressed:) 
				forControlEvents:UIControlEventTouchUpInside];
	
	//Add Go Home Button	
	UIButton *goHomeButton = [[UIButton alloc] initWithFrame:CGRectMake(actionButtonXcord, yPosition+140, actionButtonWidth, actionButtonHeight)];
	[goHomeButton setBackgroundColor:[UIColor clearColor]];
	
	/*UIImage *enabledHomeImage  = [UIImage imageNamed:Home_button];	
	[goHomeButton setBackgroundImage:enabledHomeImage forState:UIControlStateNormal];*/
	
    [goHomeButton setBackgroundImage:enabledBtnImage forState:UIControlStateNormal];
	[goHomeButton setTitle:kHome_Title forState:UIControlStateNormal];
    [goHomeButton.titleLabel setFont:[UIFont boldSystemFontOfSize:kLabelTextFontSize]];
    [goHomeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [goHomeButton titleLabel].shadowOffset = CGSizeMake(0, -1);
    
	[self.view addSubview:goHomeButton];
	[goHomeButton release];
	
	[goHomeButton addTarget:self action:@selector(goHomePressed:) 
				  forControlEvents:UIControlEventTouchUpInside];
}


-(void) bookAnotherPressed:(id) sender
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}

-(void) viewItineraryPressed:(id) sender
{
	[self.navigationController popToRootViewControllerAnimated:YES];
	
	ResortSuiteAppDelegate *appDelegate = (ResortSuiteAppDelegate *)[[UIApplication sharedApplication] delegate];
	appDelegate.tabBarController.selectedIndex = 2;
   [[appDelegate.tabBarController.viewControllers objectAtIndex:2] popToRootViewControllerAnimated:YES];
}

-(void) goHomePressed:(id) sender
{
	[self.navigationController popToRootViewControllerAnimated:YES];
	
	ResortSuiteAppDelegate *appDelegate = (ResortSuiteAppDelegate *)[[UIApplication sharedApplication] delegate];
	appDelegate.tabBarController.selectedIndex = HOME_TAB;	

    //Pop all controllers from the main screen to show Home screen
    [appDelegate.mainVC.navigationController popToViewController:appDelegate.mainVC animated:YES];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
