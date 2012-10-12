//
//  SplashScreenController.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/20/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "SplashScreenController.h"

@implementation SplashScreenController
@synthesize splashScreen;

-(void)dealloc
{
    [splashScreen release];
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
#if defined (HOTEL_VERSION)
    [self.splashScreen setImage:[UIImage imageNamed:Hotel_BGImage]];
#endif
#if defined (CLUB_VERSION)//FrontSplashRS_Club
    [self.splashScreen setImage:[UIImage imageNamed:Club_BGImage]];
#endif
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

    if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight ){
        return YES  ;
    }
    return NO;
}

@end
