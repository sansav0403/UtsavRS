//
//  ForgotPassword.h
//  ResortSuite
//
//  Created by Cybage on 12/27/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 *class to handle the user request retrieve lost password
 
 ================================================================================
 */
#import <UIKit/UIKit.h>
#import "ConnectionManager.h"
#import "ResetPasswordReqResponseHandler.h"

@interface ForgotPassword : BaseViewController<UITextFieldDelegate,UIAlertViewDelegate,BaseReqResponseHandlerDelegate>
{
    IBOutlet UITextField            *emailAddressTxtView;
    IBOutlet UIImageView            *BGImageView;
    IBOutlet UIImageView            *whiteOverLayImageView;
    NSString                        *responseString;    
    UIAlertView                     *successAlertView;
    ResetPasswordReqResponseHandler *_resetPasswordHandler;

}

@property (nonatomic, copy) NSString                            *responseString;
@property (nonatomic, retain) IBOutlet UIImageView              *whiteOverLayImageView;
@property (nonatomic, retain) IBOutlet UIImageView              *BGImageView;
@property(nonatomic, retain) IBOutlet UITextField               *emailAddressTxtView;
@property (nonatomic, retain) ResetPasswordReqResponseHandler   *resetPasswordHandler;

/*!
 @method		resetButton
 @brief			reset password
 @details		take action to reset password of the user
 @param			(id)sender
 @return		
 */
-(IBAction)resetButton:(id)sender;
/*!
 @method		cancelButton
 @brief			cancel Button action
 @details		pop back to the root view controller on cancel action
 @param			(id)sender
 @return		
 */
-(IBAction)cancelButton:(id)sender;
/*!
 @method		alertForInvalidEmailAddress
 @brief			alert For Invalid Email Address
 @details		--
 @param			(id)sender
 @return		
 */
-(void)alertForInvalidEmailAddress;
/*!
 @method		createResetPasswordRequest
 @brief			create soap request boady to reset password
 @details		--
 @param			--
 @return		void
 */
-(void) createResetPasswordRequest;

/*!
 @method		parsingComplete
 @brief			delegate method of RSParser when data from WebSErver is parsed
 @details		--
 @param			(id)parserModelData
 @return		void
 */
-(void)parsingComplete:(id)parserModelData;
/*!
 @method		showErrorMessage
 @brief			show Error Message if recieved from Web services
 @details		--
 @param			(id)parserModelData
 @return		void
 */
-(void) showErrorMessage:(id)parserModelData;
/*!
 @method		resetPasswordDataRecieved
 @brief			perform action when successful resetpassword responce is recived
 @details		--
 @param			(id)parserModelData
 @return		void
 */
-(void)resetPasswordDataRecieved:(id)parserModelData;
/*!
 @method		createAlertMessageWithTitle
 @brief			create an alert view to show message to user
 @details		--
 @param			(NSString *)title,(NSString *)message,(id)delegate
 @return		void
 */
-(void)createAlertMessageWithTitle:(NSString *)title withMessage:(NSString *)message withDelegate:(id)delegate;
@end
