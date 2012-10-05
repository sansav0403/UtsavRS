//
//  RSGolfLocationReqResponseHandler.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/28/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "RSParseBase.h"
#import "RSFolio.h"
#import "BaseReqResponseHandler.h"

@class RSGolfLocations;
@class RSGolfLocation;
@interface RSGolfLocationReqResponseHandler : BaseReqResponseHandler
{	RSGolfLocations *golfLocationsModel;
	
	NSMutableString *value;
	
	BOOL isError;
	Result *errorResult;
	
	RSGolfLocation *golfLocation;
}

@property (nonatomic, retain) RSGolfLocations *golfLocationsModel;

@property (nonatomic) BOOL isError;
@property (nonatomic, retain) Result *errorResult;

/*!
 @method		fetchGolfLocationsRequest
 @brief			Create fetch GolfLocationsRequest
 @details		--
 @param			--
 @return		void
 */
-(void) fetchGolfLocationsRequest;

/*!
 @method		parse
 @brief			Parse data returned form web service
 @details		--
 @param			(NSData*)data
 @return		void
 */
- (void) parse:(NSData*)data;

/*!
 @method		stringToDate:withTime
 @brief			get date object with or without time from string
 @details		--
 @param			(NSString *)stringDate, (BOOL)flag
 @return		NSDate
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
