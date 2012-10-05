//
//  RSSpaCustomerConflictCheck.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/1/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSSpaCustomerConflictReqResponseHandler.h"
#import "RSSpaCustomerConflictingBookings.h"

@interface RSSpaCustomerConflictCheck : NSObject<BaseReqResponseHandlerDelegate>
{
    RSSpaCustomerConflictReqResponseHandler     *spaCustConflictinghandler;
    RSSpaCustomerConflictingBookings            *customerconflictInfoModel;
}
@property (nonatomic, retain) RSSpaCustomerConflictingBookings *customerconflictInfoModel;

/*!
 @method		loadSpaCustomerConflictingBookingView
 @brief			load Spa Customer Conflicting BookingView if conflict is found
 @details		--
 @param			(id)parserModelData
 @return		void
 */
-(void) loadSpaCustomerConflictingBookingView:(id) parserModelData;

/*!
 @method		checkForSpaCustomerConflicts:forDateAndTime
 @brief			check conflict for user for given date and time
 @details		--
 @param			(id) spaServiceOrClass, (NSString *) dateTime
 @return		void
 */
-(void) checkForSpaCustomerConflicts:(id) spaServiceOrClass forDateAndTime:(NSString *) dateTime;
@end
