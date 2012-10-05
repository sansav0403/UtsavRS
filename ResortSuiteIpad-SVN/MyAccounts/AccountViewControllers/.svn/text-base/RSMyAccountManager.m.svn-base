//
//  RSMyAccountManager.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/6/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//
/*
 This is class is created to manage the user accounts, will return list of account
 in case the user has more than one account else will display the details of the only
 account the user has.
 */
#import "RSMyAccountManager.h"
#import "RSAccountListVC.h"
#import "RSMyAccountActivity.h"

@implementation RSMyAccountManager

@synthesize delegate;
@synthesize myAccountsreqResponseHandler = _myAccountsreqResponseHandler;
@synthesize modelClubAccounts;
@synthesize selectedAccountIndex;
@synthesize selectedAccountBillinghistory;
@synthesize selectedAccountstatement;


static RSMyAccountManager *accountManager = nil;
+(RSMyAccountManager *)sharedInstance
{
    @synchronized(self)
	{
		if(accountManager==nil)
		{
			accountManager=[[RSMyAccountManager alloc]init];
        }
	}
	return accountManager;

}

-(void)dealloc
{
    [_myAccountsreqResponseHandler release];
    [modelClubAccounts release];
    
    [selectedAccountBillinghistory release];
    [selectedAccountstatement release];
    delegate = nil;
    [super dealloc];
}

-(id)init
{
    self = [super init];
    if (self) {
        _myAccountsreqResponseHandler = [[RSMyAccountsReqResponseHandler alloc]init];
        [_myAccountsreqResponseHandler setDelegate:self];
        modelClubAccounts = nil;
    }
    return self;
}

-(void)fetchUsersAccountsListAndDetails
{
    [self.myAccountsreqResponseHandler fetchClubAccounts];
}

#pragma mark Base Req Response delegate
-(void)parsingComplete:(id)parserModelData
{
 	if ([parserModelData isKindOfClass:[Result class]]) {
		[self showErrorMessage:parserModelData];
	}
    
    else if ([parserModelData isKindOfClass:[RSClubAccounts class]]){
		[self clubAccountsDataReceived:parserModelData];
	}	
}

-(void)clubAccountsDataReceived:(id)modelData
{
    self.modelClubAccounts = (RSClubAccounts *)modelData;


        
        UIViewController *accountController = nil;
        if ( [self.modelClubAccounts.accounts count] > oneAccount) {
            accountController = [[RSAccountListVC alloc]initWithNibName:@"BaseListViewController" bundle:[NSBundle mainBundle] withClubAccounts:self.modelClubAccounts];

            //released as the are add to the tabcontrollers array
        }
        else if([self.modelClubAccounts.accounts count] == oneAccount)
        {
            accountController = [[RSMyAccountActivity alloc]initWithNibName:@"BaseListViewController" bundle:[NSBundle mainBundle] withSelectedAccount:[self.modelClubAccounts.accounts objectAtIndex:0]];

        }
        else if([self.modelClubAccounts.accounts count] == zeroAccount)
        {
            accountController = [[RSMyAccountActivity alloc]initWithNibName:@"BaseListViewController" bundle:[NSBundle mainBundle]];

        }
    if (delegate) {
        [delegate updateTheAccountViewControllerWithController:accountController];
    }

}
-(void)showErrorMessage:(id)modelData
{
    if (delegate) {
        [delegate errorInFetchingUsersAccountInfo];
    }

}


@end
