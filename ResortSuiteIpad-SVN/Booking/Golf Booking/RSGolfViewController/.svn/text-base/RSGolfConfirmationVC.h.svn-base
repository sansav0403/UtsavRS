//
//  RSGolfConfirmationVC.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/5/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSConfirmationBaseClass.h"
#import "RSSpaLocation.h"

#import "RSGolfRatesReqResponseHandler.h"
#import "RSGolfBookingReqResponseHandler.h"

@class RSGolfRates;
@interface RSGolfConfirmationVC : RSConfirmationBaseClass<BaseReqResponseHandlerDelegate>
{
    RSGolfRatesReqResponseHandler       *_golfRateReqResponseHandler;
    RSGolfBookingReqResponseHandler     *_golfBookingReqhandler;
    
    RSGolfRates                         *golfRate;
    
    NSString                            *TimeOfBooking;
    NSString                            *selectedCourseId;
    NSString                            *selectedPlayers;
    
    NSString                            *timeString;
    NSString                            *dateString;
}

@property(nonatomic, copy) NSString         *TimeOfBooking;
@property(nonatomic, copy) NSString         *selectedCourseId;
@property(nonatomic, copy) NSString         *selectedPlayers;

@property(nonatomic, copy) NSString         *timeString;
@property(nonatomic, copy) NSString         *dateString;

@property(nonatomic, retain) RSGolfRatesReqResponseHandler      *golfRateReqResponseHandler;
@property(nonatomic, retain) RSGolfRates                        *golfRate;

@property(nonatomic, retain) RSGolfBookingReqResponseHandler    *golfBookingReqhandler;


/*!
 @method		initWithSelectedTime
 @brief			init With Selected Time for selected course ID and number of players
 @details		
 @param			NSString
 @return		id
 */
- (id)initWithSelectedTime:(NSString *)dateTime andSelectedCourseID:(NSString *)courseId andSelectedPlayer:(NSString *)player;

/*!
 @method		createMainBodyLabelArray
 @brief			create Main Body Label Array
 @details		
 @param			--
 @return		void
 */
- (void)createMainBodyLabelArray;

/*!
 @method		createGolfBooking
 @brief			create GolfBooking request
 @details		
 @param			--
 @return		void
 */
- (void)createGolfBooking;
@end
