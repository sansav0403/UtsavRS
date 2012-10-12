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
//-------
#import "SoapRequests.h"
#import "AuthCustomer.h"
#import "RSAppDelegate.h"
#import "ErrorPopup.h"
@implementation LoginActionSheet

@synthesize txtFieldPMSFolioId;
@synthesize txtFieldGuestPin;
@synthesize welcomeLbl;
@synthesize welcomeMessageLbl;
@synthesize backgroundImage;
@synthesize whiteOverLayImageView;
@synthesize delegate;

@synthesize authCustomer;

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
    [welcomeMessageLbl release];
    [welcomeLbl release];
    [backgroundImage release];
    [whiteOverLayImageView release];
    delegate = nil;
    
    if (authCustomer != nil) {
        [authCustomer release];
        authCustomer = nil;
    }
    if (requestHandler != nil) {
        [requestHandler release];
        requestHandler = nil;
    }
    
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

    //set Titles
    [self setTitle:kLoginTitle];
    
    //since comman in both Hotel and club app
    txtFieldPMSFolioId.keyboardType = UIKeyboardTypeEmailAddress;
    //txtFieldPMSFolioId.placeholder = AccountEmailAddressStaticText;
    //txtFieldGuestPin.placeholder = kPassword_Title;
    #if defined(DEBUG_)
    txtFieldPMSFolioId.keyboardType = UIKeyboardTypeEmailAddress;
    txtFieldPMSFolioId.text = @"js@rs.com";
    txtFieldGuestPin.text = @"club12345";
    #endif
    
    //register for notification from forgot/newuser
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onSuccessfulResetPassowrd:)
                                                 name:@"resetPasswordSuccessful" object:nil];
    //register for notification from newuser
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onSuccessfulCreatecustomer:)
                                                 name:@"createUserSuccessful" object:nil];
    
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
    return [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];

}


#pragma mark - ButtonActionMethods

-(IBAction)loginButton:(id)sender
{

    //create request and parse the object and on succesfuul completion acall the success delegate method.
    [self startLoadingAnimation];
    requestHandler = [[RequestResponseHandlerClass alloc]init];
    [requestHandler authenticateCustomer:[self.txtFieldPMSFolioId text] Password:[self.txtFieldGuestPin text]];
    [requestHandler setDelegate:self];
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
#pragma mark - Request response handler delegate methods
-(void)responseHandledWithObject:(id)dataObject
{
    [self stopLoadingAnimation];
    if ([dataObject isKindOfClass:[AuthCustomer class]]){
        self.authCustomer = (AuthCustomer *)dataObject; //save the auhthentication data in data model
		[self saveAuthenticationInPrefs];
	}
    else if ([dataObject isKindOfClass:[Result class]])
    {
        [self showErrorMessage:dataObject];
        if (delegate) {
            [txtFieldGuestPin resignFirstResponder];
            [txtFieldPMSFolioId resignFirstResponder];
            [delegate ActionSheet:self isLoginSuccesful:NO];
        }
    }
}
#pragma mark processing of the data received after parsing
-(void) showErrorMessage:(id)parserModelData
{

    Result *result = [(Result *)parserModelData retain];
        NSString *errorMessage = [NSString stringWithFormat:@"%@", result.resultText];
        
        ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
        [errorPopup initWithTitle:errorMessage];
    [result release];
        

}
-(void) saveAuthenticationInPrefs
{
    DLog(@"saveAuthenticationInPrefs");
    /*save the authentication parameter in the NSUserDefault Object*/
    
    RSAppDelegate *appDelegate = (RSAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.isLoggedIn = YES;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    // saving a email address and password
    [prefs setObject:[self.txtFieldPMSFolioId text] forKey:EmailAddressKey];
    [prefs setObject:[self.txtFieldGuestPin text] forKey:PasswordKey];
    
    [prefs setObject:self.authCustomer.customerId forKey:CustomerIdKey];
    [prefs setObject:self.authCustomer.customerGUID forKey:CustomerGUIDKey];
    [prefs setObject:self.authCustomer.authorizationId forKey:AuthorizationIdKey];
    [prefs setObject:self.authCustomer.guaranteed forKey:GuaranteedKey];
    
    [prefs setBool:appDelegate.isLoggedIn forKey:LoggedInKey];
    
    [prefs synchronize];	
    
    if (delegate) {
        [txtFieldGuestPin resignFirstResponder];
        [txtFieldPMSFolioId resignFirstResponder];
        [delegate ActionSheet:self isLoginSuccesful:YES];
    }
   
}

@end
