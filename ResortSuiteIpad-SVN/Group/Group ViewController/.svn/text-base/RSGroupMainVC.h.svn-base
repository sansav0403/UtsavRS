//
//  RSGroupMainVC.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/21/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseListViewController.h"

enum GroupSections {
	ByDatesSection,
	ByCategoriesSecion,
	AllEventsSection
};

@class RSMyItineraryModel;

@interface RSGroupMainVC : BaseListViewController
{
    NSArray *mainFieldArray;
}

@property (nonatomic, retain) RSMyItineraryModel *guestItinerary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withGuestItinerary:(RSMyItineraryModel *)itineraryModel;

/*!
 @method		dictionaryOfGroupEventsWithDatesAsKeys
 @brief			create dictionary for group event with date as key
 @details		--
 @param			--
 @return		NSDictionary
 */
- (NSDictionary *)dictionaryOfGroupEventsWithDatesAsKeys;

/*!
 @method		dictionaryOfGroupEventsWithCategoriesAsKeys
 @brief			create dictionary for group event with categories as key
 @details		--
 @param			--
 @return		NSDictionary
 */
- (NSDictionary *)dictionaryOfGroupEventsWithCategoriesAsKeys;

/*!
 @method		stringFromDate
 @brief			get string from date
 @details		--
 @param			(NSDate *)date
 @return		NSString
 */
- (NSString *)stringFromDate:(NSDate *)date;

/*!
 @method		stringToDate
 @brief			get date from string
 @details		--
 @param			(NSString *)stringDate
 @return		NSDate
 */
- (NSDate *)stringToDate:(NSString *)stringDate;

@end
