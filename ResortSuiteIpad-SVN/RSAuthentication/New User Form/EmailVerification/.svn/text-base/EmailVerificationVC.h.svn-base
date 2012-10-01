//
//  EmailVerificationVC.h
//  ResortSuite
//
//  Created by Cybage on 2/1/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionManager.h"

#import "EmailVerificationReqResponseHandler.h"
@interface EmailVerificationVC : BaseViewController<UITextFieldDelegate,UIAlertViewDelegate,BaseReqResponseHandlerDelegate>
{
    IBOutlet UIImageView                *BGImageView;
    IBOutlet UIImageView                *whiteOverLayImageView;
    IBOutlet UITextField                *emailAddressTxtView;

    NSString                            *responseString;    
    UIAlertView                         *successAlertView;
    EmailVerificationReqResponseHandler *_emailVerificationReqResponseHandler;

}

@property(nonatomic, retain) IBOutlet UITextField                   *emailAddressTxtView;
@property (nonatomic, copy) NSString                                *responseString;
@property (nonatomic, retain) EmailVerificationReqResponseHandler   *emailVerificationReqResponseHandler;

/*!
 @method		cancelButton
 @brief			cancel Button action
 @details		pop back to the root view controller on cancel action
 @param			(id)sender
 @return		
 */
-(IBAction)cancelButton:(id)sender;

/*!
 @method		verifyButton
 @brief			verify Button action
 @details		Call web service to verfiy the provided email address
 @param			(id)sender
 @return		
 */
-(IBAction)verifyButton:(id)sender;

/*!
 @method		createEmailVerificationRequest
 @brief			create Email Verification Request
 @details		-
 @param			(id)sender
 @return		void
 */
-(void) createEmailVerificationRequest;

/*!
 @method		showErrorMessage
 @brief			show Error Message
 @details		-
 @param			(id)parserModelData
 @return		void
 */
-(void) showErrorMessage:(id)parserModelData;

/*!
 @method		verificationDataRecieved
 @brief			verification from web service Recieved
 @details		-
 @param			(id)parserModelData
 @return		void
 */
-(void) verificationDataRecieved:(id)parserModelData;

/*!
 @method		createAlertMessageWithTitle:withMessage:withDelegate
 @brief			create Alert Message With Title with Message with Delegate
 @details		-
 @param			(NSString *)title,  (NSString *)message, (id)delegate
 @return		void
 */
-(void) createAlertMessageWithTitle:(NSString *)title withMessage:(NSString *)message withDelegate:(id)delegate;

/*!
 @method		alertForInvalidEmailAddress
 @brief			alert For Invalid Email Address
 @details		-
 @param			
 @return		void
 */
-(void)alertForInvalidEmailAddress;
@end
