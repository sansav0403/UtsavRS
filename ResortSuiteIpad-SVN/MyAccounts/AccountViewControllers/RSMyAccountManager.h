//
//  RSMyAccountManager.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/6/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSMyAccountsReqResponseHandler.h"
#import "RSClubAccounts.h"
#import "RSMyAccountActivity.h"
#import "RSClubBillingHistory.h"
#import "RSClubStatement.h"

@protocol AccountManagerProtcol <NSObject>

-(void)errorInFetchingUsersAccountInfo;
-(void)updateTheAccountViewControllerWithController:(UIViewController *)accountController;

@end


@interface RSMyAccountManager : NSObject<BaseReqResponseHandlerDelegate>
{
    id<AccountManagerProtcol>           delegate;
    RSMyAccountsReqResponseHandler      *_myAccountsreqResponseHandler;
    RSClubAccounts                      *modelClubAccounts;
    
    int                                 selectedAccountIndex;
    
    RSClubBillingHistory                *selectedAccountBillinghistory;    //to hold the information of the selected account
    RSClubStatement                     *selectedAccountstatement;
}

@property(nonatomic, assign) id<AccountManagerProtcol>          delegate;
@property(nonatomic, retain) RSMyAccountsReqResponseHandler     *myAccountsreqResponseHandler;
@property(nonatomic, retain) RSClubAccounts                     *modelClubAccounts;
@property(nonatomic, retain) RSClubBillingHistory               *selectedAccountBillinghistory;
@property(nonatomic, retain) RSClubStatement                    *selectedAccountstatement;
@property (nonatomic) int                                       selectedAccountIndex;

/*!
 @method		club Accounts Data Received
 @brief			Perform action when data is recieved
 @details		--
 @param			(id)modelData
 @return		(void)
 */
-(void)clubAccountsDataReceived:(id)modelData;

/*!
 @method		showErrorMessage
 @brief			show custom Error Message
 @details		--
 @param			(id)modelData
 @return        void
 */
-(void)showErrorMessage:(id)modelData;

/*!
 @method		fetchUsersAccountsListAndDetails
 @brief			fetch Users Accounts List And Details
 @details		--
 @param			(id)modelData
 @return        void
 */
-(void)fetchUsersAccountsListAndDetails;

/*!
 @method		sharedInstance
 @brief			to return a sigleton object of account manager
 @details		--
 @param			--
 @return        RSMyAccountManager
 */
+(RSMyAccountManager *)sharedInstance;

@end
