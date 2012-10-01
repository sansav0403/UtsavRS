//
//  RSItineraryMainVC.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/21/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseListViewController.h"

@class RSMyItineraryModel;

enum MISections {
	ByDateSection,
	ByCategorySection,
	AllSection
};

@interface RSItineraryMainVC : BaseListViewController
{
    NSArray     *mainFieldArray;
}

@property (nonatomic, retain) RSMyItineraryModel *guestItinerary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withGuestItinerary:(RSMyItineraryModel *)itineraryModel;

/*!
 @method		dictionaryOfFoliosWithDatesAsKeys
 @brief			create dictionary for Folios event with date as key
 @details		--
 @param			--
 @return		NSDictionary
 */
- (NSDictionary *)dictionaryOfFoliosWithDatesAsKeys;

/*!
 @method		dictionaryOfFoliosWithCategoriesAsKeys
 @brief			create dictionary for Folios event with categories as key
 @details		--
 @param			--
 @return		NSDictionary
 */
- (NSDictionary *)dictionaryOfFoliosWithCategoriesAsKeys;

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
- (NSDate *)stringToDate:(NSString *)stringDate ;
@end
