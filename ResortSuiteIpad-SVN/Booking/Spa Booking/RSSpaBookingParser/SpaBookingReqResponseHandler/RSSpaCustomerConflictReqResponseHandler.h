//
//  RSSpaCustomerConflictReqResponseHandler.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/1/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseReqResponseHandler.h"

@class RSSpaCustomerConflictingBookings;
@class RSSpaBooking;
@interface RSSpaCustomerConflictReqResponseHandler : BaseReqResponseHandler
{
    RSSpaCustomerConflictingBookings *spaCustConflictBookingsModel;
	
	NSMutableString *value;
	
	BOOL isError;
	Result *errorResult;
	
	RSSpaBooking *spaBooking;
}

@property (nonatomic) BOOL isError;
@property (nonatomic, retain) Result *errorResult;	
@property (nonatomic, retain) RSSpaCustomerConflictingBookings *spaCustConflictBookingsModel;


/*!
 @method		parse
 @brief			Parse data returned form web service
 @details		--
 @param			(NSData*)data
 @return		void
 */
- (void) parse:(NSData*)data;

/*!
 @method		checkForSpaCustomerConflicts
 @brief			check for spa class conflict for selected date and time
 @details		--
 @param			(NSData*)data
 @return		void
 */
-(void) checkForSpaCustomerConflicts:(id) spaServiceOrClass forDateAndTime:(NSString *) dateTime;
@end
