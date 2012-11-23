//
//  UIManager.m
//  Ipad-ResortSuite
//
//  Created by Basant Sarda on 10/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIManager.h"

@implementation UIManager
#define kCurrentScreenHeight [UIScreen mainScreen].bounds.size.height;
#define kCurrentScreenWidth [UIScreen mainScreen].bounds.size.width;

+ (void)setButtonProperties:(UIButton *)customButton title:(NSString *)titelText isDisable:(BOOL)isDisable   
{    
    if (isDisable) {
         UIImage * disabledImage =  [UIImage imageNamed:kDisabled_Button_img];
        [customButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        [customButton setBackgroundImage:disabledImage forState:UIControlStateDisabled];
    }
       
    UIImage * enabledImage =  [UIImage imageNamed:kEnabled_Button_img];
    [customButton setBackgroundImage:enabledImage forState:UIControlStateNormal];
    [customButton setTitle:titelText forState:UIControlStateNormal];
    [customButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [customButton.titleLabel setFont:[UIFont boldSystemFontOfSize:kLabelTextFontSize]];
    [customButton titleLabel].shadowOffset = CGSizeMake(0, 1);
}

+ (int)currentScreenHeight
{
    return kCurrentScreenHeight;
}

+ (int)currentScreenWidth
{
    return kCurrentScreenWidth;
}

+ (NSString *)imageName:(NSString *)imageName extention:(NSString *)extention
{
    int height = kCurrentScreenHeight;
    NSString *dynamicImageName = nil;
    NSString *imageName568 = [NSString stringWithFormat:@"%@%@",imageName,@"-568h"];
    
    dynamicImageName = (height == 568)?imageName568:imageName;
   
    NSString *imageNameWithExtention = [NSString stringWithFormat:@"%@%@",dynamicImageName,extention];
    
    return imageNameWithExtention;
}

+ (BOOL)isCurrentDeviceTypeIPhone5
{
    return ([self currentScreenHeight]>=568)?TRUE:FALSE;
    
}

@end
