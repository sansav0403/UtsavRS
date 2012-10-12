//
//  RSGolfCourseReqResponseHandler.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/28/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSFolio.h"
#import "BaseReqResponseHandler.h"

@class RSGolfCourses;
@class RSGolfCourse;
@interface RSGolfCourseReqResponseHandler : BaseReqResponseHandler
{
	RSGolfCourses *golfCoursesModel;
	
	NSMutableString *value;
	
	BOOL isError;
	Result *errorResult;
	
	RSGolfCourse *golfCourse;
}

@property (nonatomic) BOOL isError;
@property (nonatomic, retain) Result *errorResult;	
@property (nonatomic, retain) RSGolfCourses *golfCoursesModel;

/*!
 @method		fetchGolfCoursesForLocationId
 @brief			hit web service to get golf cource for given golf location
 @details		--
 @param			(int)golfLocationID
 @return		void
 */
-(void)fetchGolfCoursesForLocationId:(int)golfLocationID;

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
@end
