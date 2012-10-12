//
//  LogoutScreen.h
//  ResortSuite
//
//  Created by Cybage on 1/6/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
enum logoutOptions
{
    Logout_ok = 0,
    Logout_changePassword,
    Logout_cancel
};
@class LogoutScreen;
@protocol LogoutViewDelegate <NSObject>

-(void)logoout:(LogoutScreen *)actionSheet buttonSelectedAtindex:(int)buttonIndex;

@end
@interface LogoutScreen : BaseViewController
{
    IBOutlet UIButton       *okButton;
    IBOutlet UIButton       *changeButton;
    IBOutlet UIButton       *cancelButton;
    

    id<LogoutViewDelegate>  delegate;
}

@property (nonatomic, retain) IBOutlet UIButton     *okButton;
@property (nonatomic, retain) IBOutlet UIButton     *changeButton;
@property (nonatomic, retain) IBOutlet UIButton     *cancelButton;

@property (nonatomic,assign) id<LogoutViewDelegate> delegate;

/*!
 @method		okButtonAction
 @brief			ok ButtonAction on press event
 @details		....
 @param			(id)sender
 @return		void
 */
-(IBAction)okButtonAction:(id)sender;

/*!
 @method		changeButtonAction
 @brief			changeButton Action on press event
 @details		....
 @param			(id)sender
 @return		void
 */
-(IBAction)changeButtonAction:(id)sender;

/*!
 @method		cancelButtonAction
 @brief			cancelButton Action on press event
 @details		....
 @param			(id)sender
 @return		void
 */
-(IBAction)cancelButtonAction:(id)sender;
@end
