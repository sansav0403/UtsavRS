//
//  RSClubBillingHistoryReqResponseHnadler.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/7/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseReqResponseHandler.h"
#import "RSClubBillingHistory.h"
@interface RSClubBillingHistoryReqResponseHnadler : BaseReqResponseHandler
{
	NSMutableString *value;
	
	RSClubBillingHistory *clubBillingHistory;
	BOOL isError;
	Result *errorResult;
	
	BillingPeriod *billingPeriod;
}

@property (nonatomic, retain) RSClubBillingHistory *clubBillingHistory;
@property (nonatomic) BOOL isError;
@property (nonatomic, retain) Result *errorResult;


/*!
 @method		fetchBillingHistoryForAccountId
 @brief			fetch billing history for a given account ID
 @details		--
 @param			(NSString *)AccountID
 @return		void
 */
- (void)fetchBillingHistoryForAccountId:(NSString *)AccountID;

/*!
 @method		parse
 @brief			Parse data returned form web service
 @details		--
 @param			(NSData*)data
 @return		void
 */
- (void)parse:(NSData*)data;
@end
