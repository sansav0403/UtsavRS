//
//  ActionSheet.m
//  ActionSheetWithVC
//
//  Created by cybage on 12/15/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import "LoginActionSheet.h"
#import "EmailVerificationVC.h"
#import "NewUserForm.h"
#import "ForgotPassword.h"
#import "ChangePassword.h"
@implementation LoginActionSheet

@synthesize txtFieldPMSFolioId;
@synthesize txtFieldGuestPin;
@synthesize backgroundImage;
@synthesize whiteOverLayImageView;
@synthesize delegate;

@synthesize signButton;
@synthesize forgotPasswordButton;
@synthesize userNewButton;
@synthesize cancelButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)dealloc
{
    DLog(@"LoginActionSheet :: Release");
    
    [txtFieldPMSFolioId release];
    [txtFieldGuestPin release];
    [backgroundImage release];
    [whiteOverLayImageView release];
    delegate = nil;
    
    [signButton release];
    [forgotPasswordButton release];
    [userNewButton release];
    [cancelButton release];
    
    [super dealloc];
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
    
    [backgroundImage setImage:[UIImage imageNamed:Application_HomeScreen]];
    [whiteOverLayImageView setImage:[UIImage imageNamed:ScreenWhiteOverLay]];
    //--------------------*******************************------------    
    //since comman in both Hotel and club app
    txtFieldPMSFolioId.keyboardType = UIKeyboardTypeEmailAddress;
    txtFieldPMSFolioId.placeholder = AccountEmailAddressStaticText;
    txtFieldGuestPin.placeholder = kPassword_Title;
#if defined(DEBUG_)
    txtFieldPMSFolioId.keyboardType = UIKeyboardTypeEmailAddress;
    txtFieldPMSFolioId.text = @"sk@rs.com";
    txtFieldGuestPin.text = @"rsmobile123";
#endif
    
    //register for notification from forgot/newuser
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onSuccessfulResetPassowrd:)
                                                 name:@"resetPasswordSuccessful" object:nil];
    //register for notification from newuser
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onSuccessfulCreatecustomer:)
                                                 name:@"createUserSuccessful" object:nil];
    [self initializeButtons];
}

- (void)initializeButtons
{
    // set sign-in button image
    [signButton setBackgroundImage:[UIImage imageNamed:kEnabled_Button_img] forState:UIControlStateNormal];
    [signButton setTitle:kSignIn_Title forState:UIControlStateNormal];
    [signButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signButton.titleLabel setFont:[UIFont boldSystemFontOfSize:kLabelTextFontSize]];
    [signButton titleLabel].shadowOffset = CGSizeMake(0, -1);
    
    // set forgot button image
    [forgotPasswordButton setBackgroundImage:[UIImage imageNamed:kEnabled_Button_img] forState:UIControlStateNormal];
    [forgotPasswordButton setTitle:kForgotPassword_Title forState:UIControlStateNormal];
    [forgotPasswordButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [forgotPasswordButton.titleLabel setFont:[UIFont boldSystemFontOfSize:kLabelTextFontSize]];
    [forgotPasswordButton titleLabel].shadowOffset = CGSizeMake(0, -1);
    
    // set new user button image
    [userNewButton setBackgroundImage:[UIImage imageNamed:kEnabled_Button_img] forState:UIControlStateNormal];
    [userNewButton setTitle:kNewUSer_Title forState:UIControlStateNormal];
    [userNewButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [userNewButton.titleLabel setFont:[UIFont boldSystemFontOfSize:kLabelTextFontSize]];
    [userNewButton titleLabel].shadowOffset = CGSizeMake(0, -1);
    
    // set cancel button image
    [cancelButton setBackgroundImage:[UIImage imageNamed:kEnabled_Button_img] forState:UIControlStateNormal];
    [cancelButton setTitle:kCancel_Title forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton.titleLabel setFont:[UIFont boldSystemFontOfSize:kLabelTextFontSize]];
    [cancelButton titleLabel].shadowOffset = CGSizeMake(0, -1);
}

-(void)onSuccessfulResetPassowrd:(NSNotification *)notice
{
    DLog(@"reset password successful");
    NSString *emailAddress = (NSString *)[notice object];
    [self.txtFieldPMSFolioId setText:emailAddress];
    [self.txtFieldGuestPin setText:@""];
    [self.txtFieldGuestPin setPlaceholder:kEnterNewPassword_TITLE];
}

-(void)onSuccessfulCreatecustomer:(NSNotification *)notice
{
    DLog(@"create customer successful");
    NSString *emailAddress = (NSString *)[notice object];
    [self.txtFieldPMSFolioId setText:emailAddress];
    [self.txtFieldGuestPin setText:@""];
    [self.txtFieldGuestPin setPlaceholder:kEnterPassword_TITLE];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - ButtonActionMethods

-(IBAction)loginButton:(id)sender
{
    if (delegate) {
        [txtFieldGuestPin resignFirstResponder];
        [txtFieldPMSFolioId resignFirstResponder];
        [delegate ActionSheet:self buttonSelectedAtindex:signIn];
    }
}

-(IBAction)forgotPasswordButton:(id)sender
{
    
    ForgotPassword *forgotPassword = [[ForgotPassword alloc]initWithNibName:@"ForgotPassword" bundle:[NSBundle mainBundle]];
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:BackButtonTitle style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [item release];
    [self.navigationController pushViewController:forgotPassword animated:YES];
    [forgotPassword release];
}

-(IBAction)newUserButton:(id)sender
{
    
    //add the new user form VC modally
    
    EmailVerificationVC *mEmailVerificationVC = [[EmailVerificationVC alloc]initWithNibName:@"EmailVerificationVC" bundle:[NSBundle mainBundle]];
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:BackButtonTitle style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [item release];
    [self.navigationController pushViewController:mEmailVerificationVC animated:YES];
    [mEmailVerificationVC release];
    
}

-(IBAction)changePasswordButton:(id)sender
{
    ChangePassword *changePassword = [[ChangePassword alloc]initWithNibName:@"ChangePassword" bundle:[NSBundle mainBundle]];
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:BackButtonTitle style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [item release];
    [changePassword setTitle:CHANGE_PASSWORD_VIEW_TITLE];
    [self.navigationController pushViewController:changePassword animated:YES];
    [changePassword release];
    
}
-(IBAction)cancelButton:(id)sender
{
    if (delegate) {
        [txtFieldGuestPin resignFirstResponder];
        [txtFieldPMSFolioId resignFirstResponder];
        [delegate ActionSheet:self buttonSelectedAtindex:cancel];
    }
}

#pragma mark - textfield Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
