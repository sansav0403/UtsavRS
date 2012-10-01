//
//  RSAccountPreviousBillingVC.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/9/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseListViewController.h"
#import "RSClubStatementReqResponseHandler.h"

@interface RSAccountPreviousBillingVC : BaseListViewController <BaseReqResponseHandlerDelegate>
{
    NSMutableArray                          *mainFieldArray;
	
	RSClubStatementReqResponseHandler       *_clubStatementreqResponseHandler;

}
@property(nonatomic,retain) RSClubStatementReqResponseHandler *clubStatementreqResponseHandler;
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
 @details		Create a string object from a given date
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


@end
