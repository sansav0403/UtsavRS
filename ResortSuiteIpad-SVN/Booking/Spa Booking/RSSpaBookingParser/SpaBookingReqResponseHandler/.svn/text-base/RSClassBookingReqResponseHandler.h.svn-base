//
//  RSClassBookingReqResponseHandler.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/1/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseReqResponseHandler.h"
#import "RSClassBooking.h"
#import "RSFolio.h"

@interface RSClassBookingReqResponseHandler : BaseReqResponseHandler
{
    NSMutableString *value;
    
    RSClassBooking *classBooking;       
    
    RSSpaFolioItem *spaFolioItemTemp;
    
    Result *result;
}
@property(nonatomic, retain) RSClassBooking *classBooking;

/*!
 @method		parse
 @brief			Parse data returned form web service
 @details		--
 @param			(NSData*)data
 @return		void
 */
- (void)parse:(NSData*)data;
/*
 @method        stringToDate
 @brief			convert date string to date object
 @details		
 @param			(NSString *) stringDate, (BOOL)flag
 @return        (NSDate *)
 */
-( NSDate *)stringToDate:(NSString *)stringDate withTime:(BOOL)flag;

/*!
 @method		createClassBookingForSelectedClassID
 @brief			book spa class for selected spa class ID
 @details		--
 @param			(NSData*)data
 @return		void
 */
- (void)createClassBookingForSelectedClassID:(NSString *)SelectedClassID;
@end
