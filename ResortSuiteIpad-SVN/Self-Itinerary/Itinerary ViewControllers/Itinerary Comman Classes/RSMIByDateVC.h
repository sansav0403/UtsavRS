//
//  RSMIByDateVC.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/23/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseListViewController.h"


@interface RSMIByDateVC : BaseListViewController
{
    NSArray *dateSortedKeyArray;
}
@property (nonatomic, retain) NSDictionary *dateDictionary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withDateDictionary:(NSDictionary *)itineraryDateDictionary;

/*!
 @method		dictionaryofDateFromTheArrayofFolios
 @brief			create dictionary of folios with dates as key
 @details		--
 @param			(NSArray *)folioArray
 @return		NSDictionary
 */
-(NSDictionary *)dictionaryofDateFromTheArrayofFolios:(NSArray *)folioArray;

/*!
 @method		stringFromDate
 @brief			get string from date
 @details		--
 @param			(NSDate *)date
 @return		NSString
 */
-(NSString *)stringFromDate:(NSDate *)date;
@end
