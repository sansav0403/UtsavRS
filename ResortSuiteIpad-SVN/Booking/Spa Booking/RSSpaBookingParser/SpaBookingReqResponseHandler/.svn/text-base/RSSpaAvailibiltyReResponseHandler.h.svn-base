//
//  RSSpaAvailibiltyReResponseHandler.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/2/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseReqResponseHandler.h"
#import "RSFolio.h"


@class RSSpaAvailibilties;
@class RSSpaAvailibility;
@interface RSSpaAvailibiltyReResponseHandler : BaseReqResponseHandler
{

    NSMutableString *value;
    
    RSSpaAvailibility * spaAvailibility;
    
    Result *result;
    
    RSSpaAvailibilties *rsSpaAvailibilties;
}

@property(nonatomic, retain) RSSpaAvailibilties * rsSpaAvailibilties;

/*
 @method        stringToDate
 @brief			convert date string to date object
 @details		
 @param			(NSString *) stringDate, (BOOL)flag
 @return        (NSDate *)
 */
-(NSDate *)stringToDate:(NSString *)stringDate withTime:(BOOL)flag;

/*!
 @method		parse
 @brief			Parse data returned form web service
 @details		--
 @param			(NSData*)data
 @return		void
 */
- (void)parse:(NSData*)data;

/*!
 @method		checkAvailabilityForSpaBookingForSpaItemId
 @brief			check Availability For SpaBooking For selected SpaItemId and date time
 @details		--
 @param			(NSString *)spaItemID, (NSString *)selectedDateTime, (NSString *)LocationID
 @return		void
 */
-(void) checkAvailabilityForSpaBookingForSpaItemId:(NSString *)spaItemID forDateTime:(NSString *)selectedDateTime andSpaLocationID:(NSString *)LocationID;

@end
