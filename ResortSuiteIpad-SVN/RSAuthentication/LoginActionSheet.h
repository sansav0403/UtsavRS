//
//  ActionSheet.h
//  ActionSheetWithVC
//
//  Created by Cybage on 12/15/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 *class to handle the user request to login into the system
 *also give the user other options
 *register as a new user
 *retrieve lost password
================================================================================
 */
#import <UIKit/UIKit.h>
#import "RequestResponseHandlerClass.h"

enum LoginOptions { 
    signIn = 1,
    forgotPassword,
    newUser ,
    changePassword,
    cancel
    };


@class LoginActionSheet;
@class AuthCustomer;
@protocol LoginViewDelegate <NSObject>

-(void)ActionSheet:(LoginActionSheet *)actionSheet buttonSelectedAtindex:(int)buttonIndex;
-(void)ActionSheet:(LoginActionSheet *)actionSheet isLoginSuccesful:(BOOL)loginStatus;

@end

@interface LoginActionSheet : BaseViewController <UITextFieldDelegate,RequesetResponseHandlerDelegate>{
    
    id<LoginViewDelegate>delegate;
    

    
    IBOutlet UITextField        *txtFieldPMSFolioId;
    IBOutlet UITextField        *txtFieldGuestPin;   

    IBOutlet UILabel            *welcomeLbl;
    IBOutlet UILabel            *welcomeMessageLbl;
    IBOutlet UIImageView        *backgroundImage;
    IBOutlet UIImageView        *whiteOverLayImageView;
    RequestResponseHandlerClass *requestHandler;
    AuthCustomer                *authCustomer;
}

@property (nonatomic, retain) AuthCustomer *authCustomer;

@property (nonatomic, retain) IBOutlet UIImageView      *whiteOverLayImageView;

@property (nonatomic, retain) IBOutlet UILabel          *welcomeLbl;
@property (nonatomic, retain) IBOutlet UILabel          *welcomeMessageLbl;
@property (nonatomic, retain) IBOutlet UITextField      *txtFieldPMSFolioId;
@property (nonatomic, retain) IBOutlet UITextField      *txtFieldGuestPin;
@property (nonatomic, assign) id<LoginViewDelegate>     delegate;
@property (nonatomic, retain) IBOutlet UIImageView      *backgroundImage;
/*!
 @method		loginButton
 @brief			login button action
 @details		--
 @param			(id)sender
 @return		
 */
-(IBAction)loginButton:(id)sender;
/*!
 @method		forgotPasswordButton
 @brief			forgot password button action
 @details		--
 @param			(id)sender
 @return		
 */
-(IBAction)forgotPasswordButton:(id)sender;
/*!
 @method		newUserButton
 @brief			newUser button action
 @details		--
 @param			(id)sender
 @return		
 */
-(IBAction)newUserButton:(id)sender;
/*!
 @method		changePasswordButton
 @brief			change password button action
 @details		--
 @param			(id)sender
 @return		
 */
-(IBAction)changePasswordButton:(id)sender;
/*!
 @method		cancelButton
 @brief			cancel button action
 @details		--
 @param			(id)sender
 @return		
 */
-(IBAction)cancelButton:(id)sender;

/*!
 @method		saveAuthenticationInPrefs
 @brief			save Authentication In NSUserDefault Object
 @details		....
 @param			....
 @return		void
 */
-(void) saveAuthenticationInPrefs;

/*!
 @method		showErrorMessage
 @brief			Show error messages
 @details		....
 @param			(id)parserModelData
 @return		void
 */
-(void) showErrorMessage:(id)parserModelData;
@end
