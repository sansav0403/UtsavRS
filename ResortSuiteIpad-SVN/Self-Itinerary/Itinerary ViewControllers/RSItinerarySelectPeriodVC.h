//
//  RSItinerarySelectPeriodVC.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/16/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseListViewController.h"

#import "RSItineraryReqResponseHandler.h"

@class RSMyItineraryModel;

enum TableSection {
	AllFurtherBookings,
	SelectDates,
	NoOfSections
};
@interface RSItinerarySelectPeriodVC : BaseListViewController<BaseReqResponseHandlerDelegate>
{
    NSArray                         *mainFieldArray;
    RSItineraryReqResponseHandler   *requestHandler;
}
@property (nonatomic, retain) RSMyItineraryModel *guestItinerary;

/*!
 @method		showErrorMessage
 @brief			show custom Error Message
 @details		--
 @param			(id)parserModelData
 @return        void
 */
- (void)showErrorMessage:(id)parserModelData;
@end
