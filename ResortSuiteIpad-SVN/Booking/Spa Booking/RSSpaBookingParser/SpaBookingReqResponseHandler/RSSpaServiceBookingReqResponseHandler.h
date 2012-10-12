//
//  RSSpaServiceBookingReqResponseHandler.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/2/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseReqResponseHandler.h"
#import "RSSpaServiceBooking.h"
#import "RSFolio.h"
@interface RSSpaServiceBookingReqResponseHandler : BaseReqResponseHandler
{
    
    NSMutableString *value;
    
    RSSpaServiceBooking *serviceBooking;       
    Result *result;
}

@property(nonatomic, retain)  RSSpaServiceBooking *serviceBooking;

/*!
 @method		parse
 @brief			Parse data returned form web service
 @details		--
 @param			(NSData*)data
 @return		void
 */
- (void)parse:(NSData*)data;

/*!
 @method		createSpaBookingForSpaItemId
 @brief			create booking request nad call teh serviuce for selected date time
 @details		--
 @param			(NSString *)spaItemID, (NSString *)startTime, (NSString *)spaStaffID
 @return		void
 */
-(void)createSpaBookingForSpaItemId:(NSString *)spaItemID withStartDateTime:(NSString *)startTime andSpaStaffId:(NSString *)spaStaffID;
@end
