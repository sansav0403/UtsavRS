//
//  RSSpaLocReqResponseHandler.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/28/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSSpaAvailibility.h"
#import "RSSpaLocation.h"
#import "RSSpaService.h"
#import "RSFolio.h"
#import "RSParseBase.h"
#import "BaseReqResponseHandler.h"

@interface RSSpaLocReqResponseHandler : BaseReqResponseHandler
{
    NSMutableString *value;
    
    RSSpaLocation *spaLocation;
    
    Result *result;
    
    RSSpaLocations *rsSpaLocations;
}
@property(nonatomic, retain) RSSpaLocations *rsSpaLocations;


/*!
 @method		fetchSpaLocationsRequest
 @brief			fetch spa location from the web service
 @details		--
 @param			(NSData*)data
 @return		void
 */
-(void) fetchSpaLocationsRequest;

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
-(NSDate *)stringToDate:(NSString *)stringDate withTime:(BOOL)flag;

/*!
 @method		timeStringFromResponsedDateString
 @brief			get time from server responded date string
 @details		extract time from server responded date string
 @param			(NSString *)sreverRespondedString
 @return		NSString - time string (with am/pm)
 */
- (NSString *)timeStringFromResponsedDateString:(NSString *)sreverRespondedString;

@end
