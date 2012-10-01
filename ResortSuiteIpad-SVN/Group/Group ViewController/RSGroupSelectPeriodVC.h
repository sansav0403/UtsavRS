//
//  RSGroupSelectPeriodVC.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/16/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseListViewController.h"

#import "RSItineraryReqResponseHandler.h"

@class RSMyItineraryModel;
enum MGTableSection {
    MGAllFurtherBookings,
    MGSelectDates,
    MGNoOfSections
};

@interface RSGroupSelectPeriodVC : BaseListViewController <BaseReqResponseHandlerDelegate>
{
    RSItineraryReqResponseHandler   *requestHandler;
     NSArray                        *mainFieldArray;
}
@property (nonatomic, retain) RSMyItineraryModel *guestItinerary;

/*!
 @method		showErrorMessage
 @brief			show custom ErrorMessage
 @details		--
 @param			(id)parserModelData
 @return		void
 */
- (void)showErrorMessage:(id)parserModelData;

@end
