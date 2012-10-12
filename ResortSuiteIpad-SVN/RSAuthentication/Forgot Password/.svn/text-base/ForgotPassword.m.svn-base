//
//  ForgotPassword.m
//  ResortSuite
//
//  Created by Cybage on 12/27/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import "ForgotPassword.h"
#import "NewUserForm.h"
#import "SoapRequests.h"
#import "RSFolio.h"
#import "RSAlertView.h"

@implementation ForgotPassword
@synthesize responseString;
@synthesize resetPasswordHandler = _resetPasswordHandler;
@synthesize emailAddressTxtView;
@synthesize BGImageView;
@synthesize whiteOverLayImageView;

-(void)dealloc
{

    [BGImageView release];
    [whiteOverLayImageView release];
    [_resetPasswordHandler release];
    [responseString release];
    [emailAddressTxtView release];
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
    [self setTitle:FORGOT_PASSWORD_VIEW_TITLE];
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

#pragma mark - button action methods
-(IBAction)resetButton:(id)sender
{
    if ([NewUserForm validateEmail:[emailAddressTxtView text]]) {
        [emailAddressTxtView resignFirstResponder];
        [self createResetPasswordRequest];
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
    //create notification and pass the email address for which user forgot 
    //the pasword and set it in the email filed in login page
    if (alertView == successAlertView)
    {        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"resetPasswordSuccessful" object:[self.emailAddressTxtView text]];
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
-(void) createResetPasswordRequest
{
    [self startLoadingAnimation];
    NSString *requestBody = [NSString stringWithFormat:
                             @"<rsap:ResetPasswordCustomerRequest>"
                             "<Source>IPAD</Source>"
                             "<EmailAddress>%@</EmailAddress>"    
                             "</rsap:ResetPasswordCustomerRequest>",
                             [self.emailAddressTxtView text]
                             ];
    _resetPasswordHandler = [[ResetPasswordReqResponseHandler alloc]init];
    [_resetPasswordHandler setDelegate:self];
    [_resetPasswordHandler callConectionManagerForRequestBody:requestBody];
}


#pragma mark RSParseBase delegate
-(void)parsingComplete:(id)parserModelData
{	
    [self stopLoadingAnimation];    
    if ([parserModelData isKindOfClass:[Result class]]) {
		[self showErrorMessage:parserModelData];
	}
	else if ([parserModelData isKindOfClass:[ResetPasswordReqResponseHandler class]]) {
		[self resetPasswordDataRecieved:parserModelData];
	}

}

#pragma mark processing of the data received after parsing
-(void) showErrorMessage:(id)parserModelData
{
    Result *result = (Result *) parserModelData;
    [self createAlertMessageWithTitle:nil withMessage:result.resultText withDelegate:nil];
    [self.emailAddressTxtView setText:@""];
}

#pragma mark - action to taken on successful responce
-(void)resetPasswordDataRecieved:(id)parserModelData
{
    //show alert for success
    ResetPasswordReqResponseHandler *parser = (ResetPasswordReqResponseHandler *) parserModelData;
   successAlertView = [[UIAlertView alloc]initWithTitle:parser.resetPasswordResult.resultText message:alertMessageForPassWordResset delegate:self cancelButtonTitle:ALERT_OK_TITLE otherButtonTitles:nil, nil];
    [successAlertView show];
    [successAlertView release];


}

-(void)createAlertMessageWithTitle:(NSString *)title withMessage:(NSString *)message withDelegate:(id)delegate
{
    RSAlertView *rsAlertView = [[RSAlertView alloc]initWithTitle:title andMessage:message withDelegate:delegate cancelButttonTitle:ALERT_OK_TITLE otherButtonTitle:nil];
    [rsAlertView release];
}



@end
