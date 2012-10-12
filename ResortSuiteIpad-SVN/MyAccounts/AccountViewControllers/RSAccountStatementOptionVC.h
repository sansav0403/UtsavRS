//
//  RSAccountStatementOptionVC.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/7/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseListViewController.h"
enum StatementOptionSection {
	SummarySection,
	ChargesSection,
	PaymentSection
};
@interface RSAccountStatementOptionVC : BaseListViewController
{
    NSMutableArray          *mainFieldArray;
	
	NSMutableArray          *dateKeyArray;
	NSArray                 *sortedDateKeyArray;
	NSMutableDictionary     *dateDictionary;
	
	NSSortDescriptor        *sortDescriptor;
	NSArray                 *sortDescriptors;
	NSArray                 *sortedGroupEventObjectArray;

}


/*!
 @method		stringFromDate
 @brief			Convert date into the string
 @details		Create a string object from a given date
 @param			(NSDate *)date;
 @return		(NSString *)
 */
-(NSString *)stringFromDate:(NSDate *)date;

/*!
 @method		stringFromDateWithoutYear
 @brief			Convert date into the string
 @details		Convert date into the string without adding year value
 @param			(NSDate *)date;
 @return		(NSString *)
 */
-(NSString *)stringFromDateWithoutYear:(NSDate *)date;

/*!
 @method		stringToDate
 @brief			Convert string into date object
 @details		Create a date object from a string with specific format
 @param			(NSString *)stringDate;
 @return		(NSDate *)
 */
-(NSDate *)stringToDate:(NSString *)stringDate;

/*!
 @method		dateRange
 @brief			Convert string into date object
 @details		Create a date object from a string with specific format
 @param			(NSString *)stringDate;
 @return		(NSDate *)
 */
-(NSString *)dateRange:(NSString *)firstDate endDate:(NSString *)lastDate;

/*!
 @method		dateSorting
 @brief			Sort array according to Chronological order of dates
 @details		-
 @param			(NSArray *) folioObject;
 @return		(void)
 */
-(void) dateSorting:(NSArray *) folioObject;


@end
