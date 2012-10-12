//
//  RSAlertView.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 4/18/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSAlertView : UIView
{
    UIAlertView *alertView;
}

/*!
 @method		initWithTitle:andMessage:withDelegate
 @brief			initialize the object
 @details		....
 @param			(NSString *)title, (NSString *)message, (id)delegate
 @return		id
 */
- (id)initWithTitle:(NSString *)title andMessage:(NSString *)message withDelegate:(id)delegate cancelButttonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle;



@end
