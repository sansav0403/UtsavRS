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

enum LoginOptions {
    signIn = 1,
    forgotPassword,
    newUser ,
    changePassword,
    cancel
};


@class LoginActionSheet;
@protocol LoginViewDelegate <NSObject>

-(void)ActionSheet:(LoginActionSheet *)actionSheet buttonSelectedAtindex:(int)buttonIndex;

@end

@interface LoginActionSheet : UIViewController <UITextFieldDelegate>{
    id<LoginViewDelegate>delegate;
    
    IBOutlet UITextField *txtFieldPMSFolioId;
    IBOutlet UITextField *txtFieldGuestPin;   
    IBOutlet UIImageView *backgroundImage;
    
    IBOutlet UIButton *signButton;
    IBOutlet UIButton *forgotPasswordButton;
    IBOutlet UIButton *userNewButton;
    IBOutlet UIButton *cancelButton;
    
    
    IBOutlet UIImageView *whiteOverLayImageView;
}
@property (nonatomic, retain) IBOutlet UIImageView *whiteOverLayImageView;


@property (nonatomic, retain) IBOutlet UITextField *txtFieldPMSFolioId;
@property (nonatomic, retain) IBOutlet UITextField *txtFieldGuestPin;
@property (nonatomic, assign) id<LoginViewDelegate>delegate;
@property (nonatomic, retain) IBOutlet UIImageView *backgroundImage;

@property (nonatomic, retain) IBOutlet UIButton *signButton;
@property (nonatomic, retain) IBOutlet UIButton *forgotPasswordButton;
@property (nonatomic, retain) IBOutlet UIButton *userNewButton;
@property (nonatomic, retain) IBOutlet UIButton *cancelButton;

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


@end
