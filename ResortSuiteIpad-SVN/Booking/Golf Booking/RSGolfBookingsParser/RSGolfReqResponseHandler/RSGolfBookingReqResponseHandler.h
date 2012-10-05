//
//  RSGolfBookingReqResponseHandler.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/5/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseReqResponseHandler.h"

@interface RSGolfBookingReqResponseHandler : BaseReqResponseHandler
{
    BOOL isError;
	Result *golfBookingResult;
	NSString *golfBookingId;
	
	NSMutableString *value;
}

@property(nonatomic) BOOL isError;
@property (nonatomic, retain) Result *golfBookingResult;
@property (nonatomic, retain) NSString *golfBookingId;

/*!
 @method		parse
 @brief			Parse data returned form web service
 @details		--
 @param			(NSData*)data
 @return		void
 */
- (void)parse:(NSData*)data;

/*!
 @method		BookGolfServiceForBookingTime
 @brief			book golf
 @details		--
 @param			--
 @return		void
 */
-(void)BookGolfServiceForBookingTime:(NSString *)BookingTime forSelectedCourseID:(NSString *)selectedCourseID forNumberOfPlayers:(NSString *)players withGolfItemID:(NSString *)golfRateItemID andPlayingCost:(NSString *)price;
@end
