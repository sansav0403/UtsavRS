//
//  EmailVerificationVC.m
//  ResortSuite
//
//  Created by Cybage on 2/1/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "EmailVerificationVC.h"
#import "NewUserForm.h"
#import "NewUserForm.h"
#import "SoapRequests.h"
#import "RSFolio.h"
#import "RSAlertView.h"
@implementation EmailVerificationVC

@synthesize emailAddressTxtView;
@synthesize emailVerificationReqResponseHandler = _emailVerificationReqResponseHandler;
@synthesize responseString;
-(void)dealloc
{
    [BGImageView release];
    [whiteOverLayImageView release];
    [emailAddressTxtView release];
    [_emailVerificationReqResponseHandler release];
    [responseString release];
    
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

    [self setTitle:VerifyEmail_viewtitle];

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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.backBarButtonItem.title = BackButtonTitle;
}

///---------------------------------------------
#pragma mark - button action methods
-(IBAction)verifyButton:(id)sender
{
    if ([NewUserForm validateEmail:[emailAddressTxtView text]]) {
        [emailAddressTxtView resignFirstResponder];
        [self createEmailVerificationRequest];
    }
    else
    {
        //pop an alert view to say invalid email address
        [self alertForInvalidEmailAddress];
        [emailAddressTxtView setText:@""];
        [emailAddressTxtView becomeFirstResponder];
    }
    
}

-(IBAction)cancelButton:(id)sender
{    //pop to the root viewController
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - UITextField Delegate Methods
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //test if the string is a valid email address
    if ([NewUserForm validateEmail:[textField text]]) {
        [textField resignFirstResponder];
    }
    else
    {
        //pop an alert view to say invalid email address
        [self alertForInvalidEmailAddress];
        [textField setText:@""];
        [textField becomeFirstResponder];
    }
    
    return YES;
}

#pragma mark - UIalertView delegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == successAlertView)
    {        
        [self.navigationController popToRootViewControllerAnimated:YES]; 
    }
    [self.navigationController popToRootViewControllerAnimated:YES];   
}

#pragma mark - Alert message function
-(void)alertForInvalidEmailAddress
{
    
    [self createAlertMessageWithTitle:alertTitleForInvalidEmailAddress withMessage:alertMessageForInvalidEmailAddress withDelegate:nil];
}
#pragma mark create new user request
-(void) createEmailVerificationRequest
{
    [self startLoadingAnimation];

    _emailVerificationReqResponseHandler = [[EmailVerificationReqResponseHandler alloc]init];
    [_emailVerificationReqResponseHandler setDelegate:self];
    [_emailVerificationReqResponseHandler createEmailVerificationRequestWithEmailAddress:[self.emailAddressTxtView text]];
}

#pragma mark RSParseBase delegate
-(void)parsingComplete:(id)parserModelData
{	
    [self stopLoadingAnimation];
    if ([parserModelData isKindOfClass:[Result class]]) {
		[self showErrorMessage:parserModelData];
	}
	else if ([parserModelData isKindOfClass:[EmailVerificationReqResponseHandler class]]) {
		[self verificationDataRecieved:parserModelData];
	}
    
}

#pragma mark processing of the data received after parsing
-(void) showErrorMessage:(id)parserModelData
{

    Result *result = (Result *) parserModelData;
    [self createAlertMessageWithTitle:nil withMessage:result.resultText withDelegate:nil];
    
    //push notification to signin with the registred email ID in the sigin screen
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"resetPasswordSuccessful" object:[self.emailAddressTxtView text]];
    //pop to the root viewController
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - action to taken on successful responce
-(void)verificationDataRecieved:(id)parserModelData
{

    
    NewUserForm *newUserForm = [[NewUserForm alloc]initWithNibName:@"NewUser" bundle:[NSBundle mainBundle]];
    
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:BackButtonTitle style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [item release];
    
    [self.navigationController pushViewController:newUserForm animated:YES];
    
    [newUserForm.emailTxtView setText:[self.emailAddressTxtView text]];
    [newUserForm.confirmEmailTxtView setText:[self.emailAddressTxtView text]];
    
    [newUserForm release];

    
}

-(void)createAlertMessageWithTitle:(NSString *)title withMessage:(NSString *)message withDelegate:(id)delegate
{    
    RSAlertView *rsAlertView = [[RSAlertView alloc]initWithTitle:title andMessage:message withDelegate:delegate cancelButttonTitle:ALERT_OK_TITLE otherButtonTitle:nil];
    [rsAlertView release];
}
-(void)connectionFinishedWithData:(NSData *)data
{
    NSString *recievedData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    DLog(@"EmailVerificationReqResponseHandler recieved data = %@", recievedData);
    [recievedData release];
    DLog(@"connectionFinishedWithData connection manager delegate method");
}
@end
