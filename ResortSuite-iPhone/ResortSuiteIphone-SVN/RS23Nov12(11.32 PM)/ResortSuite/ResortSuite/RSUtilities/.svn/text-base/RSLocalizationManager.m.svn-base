//
//  RSLocalizationManager.m
//  ResortSuite
//
//  Created by Cybage on 9/5/12.
//  Copyright (c) 2012 Cybage. All rights reserved.
//

#import "RSLocalizationManager.h"

#define kAppleLanguages     @"AppleLanguages"

static RSLocalizationManager* sharedInstance=nil;


@implementation RSLocalizationManager

/**
 *  @method     :-    sharedInstance 
 *  @parameter  :-    nil
 *  @return     :-    LocalizationManager Object
 *  @description:-    This will create and return LocalizationManager Shared Instance
 */
+ (RSLocalizationManager *)sharedInstance
{
    @synchronized(self)
    {
        if(sharedInstance == nil)
        {
            sharedInstance = [[RSLocalizationManager alloc]init];
        }
    }
    return sharedInstance;
}

/**
 *  @method     :-    localizedStringForKey 
 *  @parameter  :-    stringKey
 *  @return     :-    Localized string for language set into iphone setting
 *  @description:-    This return Localized string
 */
+ (NSString *)localizedStringForKey:(NSString *)stringKey
{
    return NSLocalizedString(stringKey, @"");     
}

/**
*  @method     :-    localizedFileForKey 
*  @parameter  :-    stringKey
*  @return     :-    Localized file to support multi-language into iphone setting
*  @description:-    This add the prefix of current language's initial to stringkey passed in   
                     parameter for image or file name.
*/
+ (NSString *)localizedFileForKey:(NSString *)stringKey
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [userDefaults objectForKey:kAppleLanguages];
    NSString *currentLanguageInitial = [languages objectAtIndex:0];
    
    //NSString *currentLanguageFile = nil; 
    /*if ([currentLanguageInitial isEqalToString:@"en"]) {
        currentLanguageFile = stringKey;
    }
    currentLanguageFile = [NSString stringWithFormat:@"%@_%@",currentLanguageInitial,stringKey]; */
    NSString *formatedFileName = [NSString stringWithFormat:@"%@_%@",currentLanguageInitial,stringKey]; 
    
    NSString *currentLanguageFile = ([currentLanguageInitial isEqualToString:@"en"])?stringKey:formatedFileName;
    
    return currentLanguageFile;     
}

+(UIDatePicker*)localizedDatePickerBasedonCurrentLanguage:(UIDatePicker*)datePicker
{
    NSLocale* locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [datePicker setLocale:locale];
    [datePicker setCalendar:[locale objectForKey:NSLocaleCalendar]];
    
    return datePicker;
}


@end
