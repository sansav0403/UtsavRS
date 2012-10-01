//
//  RSGolfTeeTimeReqResponseHandler.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/5/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseReqResponseHandler.h"
#import "RSFolio.h"

@class RSGolfTeeTime;
@class RSGolfTeeTimes;
@interface RSGolfTeeTimeReqResponseHandler : BaseReqResponseHandler
{
    RSGolfTeeTimes *golfTeeTimeModel;
	
	NSMutableString *value;
	
	BOOL isError;
	Result *errorResult;
	
	RSGolfTeeTime *golfTeeTime;
}

@property (nonatomic) BOOL isError;
@property (nonatomic, retain) Result *errorResult;	
@property (nonatomic, retain) RSGolfTeeTimes *golfTeeTimeModel;

@property (nonatomic, retain) RSGolfTeeTime *golfTeeTime;

/*!
 @method		parse
 @brief			Parse data returned form web service
 @details		--
 @param			(NSData*)data
 @return		void
 */
- (void) parse:(NSData*)data;

/*!
 @method		fetchGolfTeeTimesForCourseID
 @brief			fetch Golf Tee Times For CourseID
 @details		--
 @param			(NSString *)selectedCourseID,(NSString *)Players, (NSString *)startDate (NSString *)endDate
 @return		void
 */
-(void)fetchGolfTeeTimesForCourseID:(NSString *)selectedCourseID numberOfPlayer:(NSString *)Players onStartDate:(NSString *)startDate onEndDate:(NSString *)endDate;
@end
