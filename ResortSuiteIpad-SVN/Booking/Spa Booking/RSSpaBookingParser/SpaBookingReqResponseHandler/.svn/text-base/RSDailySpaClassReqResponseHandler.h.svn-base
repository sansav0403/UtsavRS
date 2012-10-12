//
//  RSDailySpaClassReqResponseHandler.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/29/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseReqResponseHandler.h"
#import "RSSpaClass.h"
#import "RSFolio.h"

@interface RSDailySpaClassReqResponseHandler : BaseReqResponseHandler
{
    
    NSMutableString *value;
    
    RSSpaClass *spaClass;
    
    Result *result;
    
    RSDailySpaClasses *rsDailySpaClasses;
}

@property(nonatomic, retain)  RSDailySpaClasses *rsDailySpaClasses; 

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
 @method		fetchDailySpaClassesForSelectedDate
 @brief			fetch spa clas for selected date and location
 @details		--
 @param			(NSData*)data
 @return		void
 */
- (void)fetchDailySpaClassesForSelectedDate:(NSString *)selectedDate withSpaLocationId:(NSString *)locationID;
@end
