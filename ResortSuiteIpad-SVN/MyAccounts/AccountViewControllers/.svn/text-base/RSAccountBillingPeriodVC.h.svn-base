//
//  RSAccountBillingPeriodVC.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/7/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseListViewController.h"
#import "RSClubBillingHistoryReqResponseHnadler.h"
#import "RSClubStatementReqResponseHandler.h"
enum BillingPeriodSection {
	CurrentSection,
	LastSection,
	PreviousSection
};

@interface RSAccountBillingPeriodVC : BaseListViewController<BaseReqResponseHandlerDelegate>
{
    NSMutableArray      *mainFieldArray;
	NSString            *responseString;
    
	RSClubStatementReqResponseHandler       *_clubStatementreqResponseHandler;
	RSClubBillingHistoryReqResponseHnadler  *_clubBillingHistoryReqResponseHandler;
}
@property(nonatomic, retain) RSClubBillingHistoryReqResponseHnadler *clubBillingHistoryReqResponseHandler;
@property(nonatomic, retain) RSClubStatementReqResponseHandler *clubStatementreqResponseHandler;
@end
