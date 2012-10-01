//
//  RSMyAccountsReqResponseHandler.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/6/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSClubAccounts.h"
#import "BaseReqResponseHandler.h"
@interface RSMyAccountsReqResponseHandler : BaseReqResponseHandler
{
    NSMutableString *value;
	
	RSClubAccounts *clubAccounts;
	Account *account;				
    
	BOOL isError;
	Result *errorResult;
	
	BOOL isCustomer;
	BOOL isMember;
	BOOL isMembership;
	
	Member *member;
	MemberShip *memberShip;
}

@property (nonatomic, retain) RSClubAccounts *clubAccounts;
@property (nonatomic) BOOL isError;
@property (nonatomic, retain) Result *errorResult;


/*!
 @method		parse
 @brief			Parse data returned form web service
 @details		--
 @param			(NSData*)data
 @return		void
 */
- (void)parse:(NSData*)data;

/*!
 @method		fetchClubAccounts
 @brief			create request body and fetch Club account information
 @details		--
 @param			--
 @return		void
 */
- (void)fetchClubAccounts;
@end
