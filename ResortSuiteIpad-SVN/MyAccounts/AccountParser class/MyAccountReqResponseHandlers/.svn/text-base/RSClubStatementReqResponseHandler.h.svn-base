//
//  RSClubStatementReqResponseHandler.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/7/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseReqResponseHandler.h"
#import "RSClubStatement.h"


@class FolioItem;
@interface RSClubStatementReqResponseHandler : BaseReqResponseHandler
{
    
	RSClubStatement *clubStatement;
	
	NSMutableString *value;
	
	BOOL isError;
	Result *errorResult;
	
	FolioItem *folioItem;
	FolioPayment *folioPayment;
	PostingItem *postingItem;
	Item *item;
	
	BOOL isFolioItem;
	BOOL isFolioPayment;
	BOOL isItem;
}

@property (nonatomic, retain) RSClubStatement *clubStatement;
@property (nonatomic) BOOL isError;
@property (nonatomic, retain) Result *errorResult;


/*!
 @method		fetchClubstatementForAccountId:andBillingDate
 @brief			fetch club statment for a particular Account ID and date
 @details		--
 @param			(NSString *)AccountID, (NSString *)billingDate
 @return		void
 */
-(void)fetchClubstatementForAccountId:(NSString *)AccountID andBillingDate:(NSString *)billingDate;

/*!
 @method		parse
 @brief			Parse data returned form web service
 @details		--
 @param			(NSData*)data
 @return		void
 */
- (void)parse:(NSData*)data;
/*!
 @method		stringToDate
 @brief			Convert string into date object
 @details		Create a date object from a string with specific format
 @param			(NSString *)stringDate;
 @return		(NSDate *)
 */
-(NSDate *)stringToDate:(NSString *)stringDate;


@end
