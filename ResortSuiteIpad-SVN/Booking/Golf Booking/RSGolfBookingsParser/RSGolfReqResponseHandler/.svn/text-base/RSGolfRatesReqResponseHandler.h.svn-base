//
//  RSGolfRatesReqResponseHandler.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/5/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseReqResponseHandler.h"
#import "RSFolio.h"

@class RSGolfRates;
@interface RSGolfRatesReqResponseHandler : BaseReqResponseHandler
{
    
    RSGolfRates *golfRatesModel;
	
	NSMutableString *value;
	
	BOOL isError;
	Result *errorResult;
}

@property (nonatomic) BOOL isError;
@property (nonatomic, retain) Result *errorResult;	
@property (nonatomic, retain) RSGolfRates *golfRatesModel;

/*!
 @method		parse
 @brief			Parse data returned form web service
 @details		--
 @param			(NSData*)data
 @return		void
 */
- (void)parse:(NSData*)data;

/*!
 @method		fetchGolfRateForSelectedCourseID
 @brief			fetch Golf Rate For Selected CourseID
 @details		--
 @param			(NSString *)CourseID,(NSString *)date, (NSString *)time
 @return		void
 */
- (void)fetchGolfRateForSelectedCourseID:(NSString *)CourseID forDate:(NSString *)date andTime:(NSString *)time;
@end
