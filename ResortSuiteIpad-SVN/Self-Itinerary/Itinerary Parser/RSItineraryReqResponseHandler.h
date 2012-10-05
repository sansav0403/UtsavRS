//
//  RSItineraryReqResponseHandler.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/23/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseReqResponseHandler.h"
#import "AuthCustomer.h"

@class RSMyItineraryModel;
@class RSFolio;
@class HotelFolio;
@class SpaFolio;
@class GroupEvent;

@class Result;
@interface RSItineraryReqResponseHandler : BaseReqResponseHandler
{
    RSMyItineraryModel *guestItinerary;
	RSFolio *folio;
	HotelFolio *hotelFolio;
	SpaFolio *spaFolio;
	
	GroupEvent *groupEvent;
	
	NSMutableString *value;
	
	NSMutableString *currentAppType;
	
	BOOL isGroupEvent;
	BOOL isError;
	
	Result *errorResult;
	
	//Club specific
	BOOL isAuthCustomer;
	AuthCustomer *authCustomer;
}
@property (nonatomic, retain) RSMyItineraryModel *guestItinerary;
@property (nonatomic) BOOL isError;
@property (nonatomic, retain) Result *errorResult;
@property (nonatomic) BOOL isAuthCustomer;
@property (nonatomic, retain) AuthCustomer *authCustomer;


/*!
 @method		stringToDate
 @brief			This method converts the string to date
 @details		Depending on the flag value, date formatting takes place with Time and without time
 @param			NSString stringDate, BOOL flag
 @return		NSDate obj
 */
-(NSDate *)stringToDate:(NSString *)stringDate withTime:(BOOL)flag;
-(void) authenticateCustomerRequestWithEmail:(NSString *) EmailAddress Password:(NSString *) Password;

-(void) fetchGuestItineraryForHotelWithStartDate: (NSString *) startdate EndDate:(NSString *) enddate;

-(void) fetchGroupItineraryForHotelWithStartDate: (NSString *) startdate EndDate:(NSString *) enddate;

- (void) parse:(NSData*)data;

@end
