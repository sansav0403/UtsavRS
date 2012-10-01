//
//  BaseViewController.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/16/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "BaseViewController.h"
#import "RSAppDelegate.h"

#define ScreenHeightForBaseViewController    1024

@implementation BaseViewController

-(void)dealloc
{
    [loadingView release];
    [baseView release];
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
    baseView = [[BaseView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    
        loadingView = [[RSLoadingView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    /*just start and stop animatin in the child class*/
    [self.view addSubview:baseView];
    [self.view sendSubviewToBack:baseView];    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
            
    [baseView setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, ScreenHeightForBaseViewController, Screen_Width)];
        
    [loadingView setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, ScreenHeightForBaseViewController, Screen_Width)];

}
- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{

    RSAppDelegate *appDelegate = (RSAppDelegate *)[[UIApplication sharedApplication]delegate];

if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight ){
    
    appDelegate.currentOrientation = landscape;
    [baseView setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, ScreenHeightForBaseViewController, Screen_Width)];
   
    [loadingView setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, ScreenHeightForBaseViewController, Screen_Width)];
    return YES;
}
    return NO;
}

-(void)startLoadingAnimation
{

    [self.view addSubview:loadingView];
    [loadingView startAnimating];

}

-(void)stopLoadingAnimation
{
    [loadingView stopAnimating];
    [loadingView removeFromSuperview];

}
@end
