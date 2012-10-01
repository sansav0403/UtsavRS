//
//  RSClassConfirmationVC.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/1/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSConfirmationBaseClass.h"
#import "RSSpaClass.h"
#import "RSSpaCustomerConflictCheck.h"  //to check conflict

#import "RSClassBookingReqResponseHandler.h"    //to book


@interface RSClassConfirmationVC : RSConfirmationBaseClass<BaseReqResponseHandlerDelegate>
{
    RSSpaClass                              *selectedClass;

    
    RSClassBookingReqResponseHandler        *classBookingHandler;
    RSSpaCustomerConflictCheck              *spaCustomerConflictCheck;

}
@property (nonatomic, retain) RSSpaClass    *selectedClass;

/*!
 @method		initWithSelectedClass
 @brief			initialize the view with spaclass 
 @details		--
 @param			(RSSpaClass *)selClass
 @return		id
 */
- (id)initWithSelectedClass:(RSSpaClass *)selClass;

/*!
 @method		getDateTimeFromString:format
 @brief			get date time for given date format
 @details		--
 @param			(NSString *)dateString, (NSString *)dateOrTime
 @return		NSString
 */
- (NSString *) getDateTimeFromString:(NSString *)dateString format:(NSString *)dateOrTime;

/*!
 @method		createClassBooking
 @brief			send request to web service to book a class
 @details		--
 @param			--
 @return		void
 */
- (void)createClassBooking;
@end
