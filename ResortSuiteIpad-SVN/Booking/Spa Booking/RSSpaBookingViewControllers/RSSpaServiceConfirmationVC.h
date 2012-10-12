//
//  RSSpaServiceConfirmationVC.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/2/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSConfirmationBaseClass.h"
#import "RSSpaService.h"
#import "ErrorPopup.h"
#import "RSSpaServiceBookingReqResponseHandler.h"
#import "RSSpaCustomerConflictCheck.h"  //to check conflict

@interface RSSpaServiceConfirmationVC : RSConfirmationBaseClass<BaseReqResponseHandlerDelegate>
{
    NSString                        *selectedDateAndTime;
    RSSpaService                    *bookedService;
    NSArray                         *spaAvailibilities;
    
    NSString                        *prefGender;
    NSString                        *prefStaffName;
	NSString                        *bookingTime;
    
    RSSpaServiceBookingReqResponseHandler   *_spaServiceBookingReqResponseHandler;
    RSSpaCustomerConflictCheck              *spaCustomerConflictCheck;
}

@property(nonatomic, retain) NSString       *selectedDateAndTime;
@property(nonatomic, retain) RSSpaService   *bookedService;

@property(nonatomic, retain) NSArray        *spaAvailibilities;

@property(nonatomic, copy) NSString         *prefGender;

@property(nonatomic, copy) NSString         *prefStaffName;

@property(nonatomic, retain)  RSSpaServiceBookingReqResponseHandler *spaServiceBookingReqResponseHandler;


/*!
 @method		displayBookingConfirmation
 @brief			display Booking Confirmation message
 @details		--
 @param			(NSString *)dateString
 @return		NSString
 */
-(void)displayBookingConfirmation;

/*!
 @method		dateFromString
 @brief			get date for date string
 @details		--
 @param			(NSString *)stringDate
 @return		NSDate
 */
-(NSDate *)dateFromString:(NSString *)stringDate ;

/*!
 @method		createSpaBooking
 @brief			create Spa Booking request
 @details		--
 @param			--
 @return		void
 */
-(void)createSpaBooking;


/*!
 @method		updateBookingTime
 @brief			update BookingTime
 @details		--
 @param			--
 @return		void
 */
-(void) updateBookingTime;

/*!
 @method		initWithSpaAvailibilityArray:forSelectedSpaService:WithSelectedStaff:andGender
 @brief			initialize view with Availibilites
 @details		--
 @param			(NSArray *)Availibilites, (NSString *)selectedStaffgender
 @return		id
 */
-(id)initWithSpaAvailibilityArray:(NSArray *)Availibilites forSelectedSpaService:(RSSpaService *)spaService WithSelectedStaff:(NSString *)staffName andGender:(NSString *)selectedStaffgender;

/*!
 @method		initWithSpaAvailibilityArray:forSelectedSpaService
 @brief			initialize view with 

 @details		--
 @param			(NSArray *)Availibilites, (NSString *)selectedStaffgender
 @return		id
 */
-(id)initWithSpaAvailibilityArray:(NSArray *)Availibilites forSelectedSpaService:(RSSpaService *)spaService ;
@end
