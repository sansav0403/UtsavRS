//
//  UIManager.h
//  Ipad-ResortSuite
//
//  Created by Basant Sarda on 10/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIManager : NSObject

/*!
 @method		setButtonProperties
 @brief			Set buttons common properties
 @details		Set buttons common properties
 @param			(NSString *)titelText:- button's title text 
                (BOOL)isDisable:- if disable, set button's disable background image 
 @return		UIButton :- returns updated button's object
 */
+ (void)setButtonProperties:(UIButton *)customButton title:(NSString *)titelText isDisable:(BOOL)isDisable;

/*!
 @method		currentScreenHeight
 @brief			get screen's height
 @details		fetch screen's height
 @param			nil
 @return		int : height of current screen
 */
+ (int)currentScreenHeight;

/*!
 @method		currentScreenWidth
 @brief			get screen's width
 @details		fetch screen's width
 @param			nil
 @return		int : width of current screen
 */
+ (int)currentScreenWidth;

/*!
 @method		imageName
 @brief			set image at run time
 @details		fetch image at run time based on Screen size
 @param			(NSString*)imageName , (NSString*)extention
 @return		NSString : retun dynamic image name
 */
+ (NSString *)imageName:(NSString *)imageName extention:(NSString *)extention;

@end
