//
//  RSMyAccountActivity.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/6/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseListViewController.h"
#import "RSClubAccounts.h"

enum ActivitySection {
	ProfileSection,
	StatementSection
};

@interface RSMyAccountActivity : BaseListViewController
{
    NSMutableArray  *mainFieldArray;
    Account         *modelSelectedAccount;
}
@property(nonatomic, retain) Account *modelSelectedAccount;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withSelectedAccount:(Account *)selectedAccount;
@end
