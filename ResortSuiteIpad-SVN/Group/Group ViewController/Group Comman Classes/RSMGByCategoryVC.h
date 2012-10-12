//
//  RSMIByCategoryVC.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/23/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseListViewController.h"

@interface RSMGByCategoryVC : BaseListViewController
{
    NSArray     *categorySortedKeyArray;
}
@property (nonatomic, retain) NSDictionary  *categoryDictionary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withCategoryDictionay:(NSDictionary *)ItineraryCategoryDictionary;

/*!
 @method		dictionaryofDateFromTheArrayofFolios
 @brief			create a dictionary of dates
 @details		--
 @param			(NSArray *)folioArray
 @return		NSDictionary
 */
- (NSDictionary *)dictionaryofDateFromTheArrayofFolios:(NSArray *)folioArray;

/*!
 @method		stringToDate
 @brief			get date from string
 @details		--
 @param			(NSString *)stringDate
 @return		NSDate
 */
- (NSDate *)stringToDate:(NSString *)stringDate;

/*!
 @method		stringFromDate
 @brief			get string from date
 @details		--
 @param			(NSDate *)date
 @return		NSString
 */
- (NSString *)stringFromDate:(NSDate *)date;
@end
