//
//  LogoutScreen.m
//  ResortSuite
//
//  Created by Cybage on 1/6/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "LogoutScreen.h"
#import "ChangePassword.h"

@implementation LogoutScreen

@synthesize okButton;
@synthesize changeButton;
@synthesize cancelButton;
@synthesize delegate;

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

-(void)dealloc
{
    DLog(@"logout released");
    [okButton release];
    [changeButton release];
    [cancelButton release];
    delegate = nil;
    [super dealloc];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //set Titles
    [self setTitle:kLogOutTitle];
    
    // set button images
    [okButton setBackgroundImage:[UIImage imageNamed:kEnabled_Button_img] forState:UIControlStateNormal];
    [okButton setBackgroundImage:[UIImage imageNamed:kDisabled_Button_img] forState:UIControlStateSelected];
    
    [changeButton setBackgroundImage:[UIImage imageNamed:kEnabled_Button_img] forState:UIControlStateNormal];
    
    [cancelButton setBackgroundImage:[UIImage imageNamed:kEnabled_Button_img] forState:UIControlStateNormal];
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
    return [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];

}

#pragma mark - button action

-(IBAction)okButtonAction:(id)sender
{
    if (delegate) {
        [delegate logoout:self buttonSelectedAtindex:Logout_ok];
    }
}
-(IBAction)changeButtonAction:(id)sender
{

    ChangePassword *changePasswordVC = [[ChangePassword alloc]initWithNibName:@"ChangePassword" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:changePasswordVC animated:YES];
    [changePasswordVC release];
}
-(IBAction)cancelButtonAction:(id)sender
{

    [self dismissModalViewControllerAnimated:YES];
}


@end
