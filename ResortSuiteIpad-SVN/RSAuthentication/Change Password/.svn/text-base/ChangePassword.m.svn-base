//
//  ChangePassword.m
//  ResortSuite
//
//  Created by Cybage on 12/27/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//

#import "ChangePassword.h"
#import "NewUserForm.h"
#import "SoapRequests.h"
#import "RSFolio.h"
#import "RSAlertView.h"
@implementation ChangePassword
@synthesize responseString;
@synthesize changePasswordHandler = _changePasswordHandler;
@synthesize emailAddressTxtView;
@synthesize currentPasswordTxtView;
@synthesize newerPasswordTxtView;
@synthesize confirmPasswordTxtView;
@synthesize BGImageView;
@synthesize whiteOverLayImageView;
-(void)dealloc
{

    [emailAddressTxtView release];
    [currentPasswordTxtView release];
    [newerPasswordTxtView release];
    [confirmPasswordTxtView release];
    [responseString release];

    [BGImageView release];
    [whiteOverLayImageView release];
    [_changePasswordHandler release];
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
-(BOOL) validNewPasswordAndConfirmPassword
{    
    if (([[newerPasswordTxtView text] length] >= PASSWORD_REQ_LENGTH) &&([[confirmPasswordTxtView text] length] >= PASSWORD_REQ_LENGTH)
        && ([[newerPasswordTxtView text] isEqualToString:[confirmPasswordTxtView text]]))
    {
        return  YES;
    }
        return  NO;
    
}
-(IBAction)changeButton:(id)sender
{
    //change the pass word  when every field is correct.
    // 1 valid email addres
    //2 valid old password
    // current and new passwrd are same
    //create abool to keep track of all validation,set it to No if one fails
    BOOL AllVaildated = NO;
    
    if ([NewUserForm validateEmail:[emailAddressTxtView text]]) {
        AllVaildated = YES;
    }else
    {
        [self alertForInvalidEmailAddress];
        [self.emailAddressTxtView setText:@""];
        return;
    }
    if ([[currentPasswordTxtView text] length] >= PASSWORD_REQ_LENGTH) {  //IF LEN LESS THAN REQ PASSWORD LENGTH
        AllVaildated = YES;
    }else
    {
        [self alertForInvalidPassword];
        [self.currentPasswordTxtView setText:@""];
        return;
    }
    if ([self validNewPasswordAndConfirmPassword]) {    //FOR INVAILD NEW AND CONFIRM PASS  
        AllVaildated = YES;
    }else
    {
        [self alertForDiffNewAndConfirmPassword];
        [self.newerPasswordTxtView setText:@""];
        [self.confirmPasswordTxtView setText:@""];
        return;
    }
    if (AllVaildated) 
    {
        [self createChangePasswordRequest];
    }

}
-(IBAction)cancelButton:(id)sender
{
    
    //pop to the root viewController
    [self.navigationController popToRootViewControllerAnimated:YES];

}

#pragma mark - UITextField Delegate Methods
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - Alert message function
-(void)alertForInvalidEmailAddress
{
    [self createAlertMessageWithTitle:alertTitleForInvalidEmailAddress withMessage:alertMessageForInvalidEmailAddress withDelegate:nil];
}
-(void)alertForInvalidPassword
{
    [self createAlertMessageWithTitle:alertTitleForImproperPassord withMessage:[NSString stringWithFormat:alertMessageForImproperPassord,PASSWORD_REQ_LENGTH ] withDelegate:nil];
}

-(void)alertForDiffNewAndConfirmPassword
{
    [self createAlertMessageWithTitle:alertTitleForUnmatchedPassword withMessage:alertMessageForUnmatchedPassword withDelegate:nil];
}
#pragma mark - UIalertView delegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
     [self dismissModalViewControllerAnimated:YES];   
}

#pragma mark create new user request
-(void) createChangePasswordRequest
{
    [self startLoadingAnimation];
    NSString *requestBody = [NSString stringWithFormat:
                             @" <rsap:ChangePasswordCustomerRequest>"
                             "<Source>IPAD</Source>"
                             "<EmailAddress>%@</EmailAddress>"  
                             "<PasswordOld>%@</PasswordOld>"  
                             "<PasswordNew>%@</PasswordNew>"    
                             "</rsap:ChangePasswordCustomerRequest>",
                             [self.emailAddressTxtView text],
                             [self.currentPasswordTxtView text],
                             [self.newerPasswordTxtView text]
                             ];
    _changePasswordHandler = [[ChangePasswordReqResponseHandler alloc]init];
    [_changePasswordHandler setDelegate:self];
    [_changePasswordHandler callConectionManagerForRequestBody:requestBody];
}


#pragma mark RSParseBase delegate
-(void)parsingComplete:(id)parserModelData
{	
    [self stopLoadingAnimation];
    if ([parserModelData isKindOfClass:[Result class]]) {
		[self showErrorMessage:parserModelData];
	}
	else if ([parserModelData isKindOfClass:[ChangePasswordReqResponseHandler class]]) {
		[self changePasswordDataRecieved:parserModelData];
	}
}
#pragma mark processing of the data received after parsing
-(void) showErrorMessage:(id)parserModelData
{    
    Result *result = (Result *) parserModelData;
    [self createAlertMessageWithTitle:nil withMessage:result.resultText withDelegate:nil];
    [self.emailAddressTxtView setText:@""];
    [self.currentPasswordTxtView setText:@""];
    [self.newerPasswordTxtView setText:@""];
    [self.confirmPasswordTxtView setText:@""];
}
#pragma action to taken on successful responce
-(void)changePasswordDataRecieved:(id)parserModelData
{
    //show alert for success
    ChangePasswordReqResponseHandler *parser = (ChangePasswordReqResponseHandler *) parserModelData;
    successAlertView = [[UIAlertView alloc]initWithTitle:@"" message:parser.changePasswordResult.resultText delegate:self cancelButtonTitle:ALERT_OK_TITLE otherButtonTitles:nil, nil];
    [successAlertView show];
    [successAlertView release];
    //perform action on change password
}
-(void)createAlertMessageWithTitle:(NSString *)title withMessage:(NSString *)message withDelegate:(id)delegate
{    
    RSAlertView *rsAlertView = [[RSAlertView alloc]initWithTitle:title andMessage:message withDelegate:delegate cancelButttonTitle:ALERT_OK_TITLE otherButtonTitle:nil];
    [rsAlertView release];
}
-(void)connectionFinishedWithData:(NSData *)data
{
    NSString *recievedData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    DLog(@"ChangePasswordReqResponseHandler recieved data = %@", recievedData);
    [recievedData release];
    DLog(@"connectionFinishedWithData connection manager delegate method");
}
@end
