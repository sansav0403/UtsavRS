//
//  RequestResponseHandlerClass.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/22/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConnectionManager.h"
#import "RSParseBase.h"
//----parser classes------------
#import "RSMyItineraryParser.h"

//------------------------------
@protocol RequesetResponseHandlerDelegate <NSObject>

-(void)responseHandledWithObject:(id)dataObject;

@end

@interface RequestResponseHandlerClass : NSObject <ConnectionManagerDelegate,RSParserHandlerDelegate>
{
    id<RequesetResponseHandlerDelegate> delegate;
    
    RSMyItineraryParser                 *parserItineraryObj;

    
    ConnectionManager                   *connection;
}
@property (nonatomic, assign) id<RequesetResponseHandlerDelegate> delegate;
/*!
 @method		authenticateCustomer
 @brief			authenticate Customer with given Email Address and password
 @details		....
 @param			(NSString *) EmailAddress, (NSString *) Password
 @return		void
 */
- (void)authenticateCustomer:(NSString *)EmailAddress Password:(NSString *)Password;
/*!
 @method		fetchGuestItineraryForHotelWithStartDate
 @brief			fetch Guest Itinerary For Hotel With StartDate
 @details		....
 @param			(NSString *) startdate,(NSString *) enddate
 @return		void
 */
- (void)fetchGuestItineraryForHotelWithStartDate:(NSString *)startdate EndDate:(NSString *)enddate;
/*!
 @method		fetchGroupItineraryForHotelWithStartDate
 @brief			fetch Group Itinerary For Hotel With StartDate
 @details		....
 @param			(NSString *) startdate,(NSString *) enddate
 @return		void
 */
- (void)fetchGroupItineraryForHotelWithStartDate:(NSString *)startdate EndDate:(NSString *)enddate;
/*!
 @method		fetchDataForRequestWithBody
 @brief			fetch Data For Request Body
 @details		....
 @param			(NSString *)bodyString
 @return		void
 */
- (void)fetchDataForRequestWithBody:(NSString *)bodyString;
@end
