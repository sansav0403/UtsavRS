//
//  RSBookMenuVC.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/28/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSBaseBookVC.h"
#import "RSGolfLocationReqResponseHandler.h"
#import "RSSpaLocReqResponseHandler.h"
#import "RSGolfLocations.h"
#import "RSSpaLocation.h"
#import "RSLoadingView.h"

@interface RSBookMenuVC : RSBaseBookVC<BaseReqResponseHandlerDelegate>
{
    RSGolfLocationReqResponseHandler    *golfLocationReqResponseHandler;
    RSSpaLocReqResponseHandler          *spaLocationReqResponseHandler;
    NSMutableArray                      *mainFieldArray;
    
    BOOL                                isGolfLocation;		//Set to YES when there are Golf locations > 0
    
    
}

@property (nonatomic, retain) RSGolfLocations       *golfLocationsModel;
@property (nonatomic, retain) RSSpaLocations        *spaLocationsModel;
@property (nonatomic) BOOL                          isGolfLocation;

/*!
 @method		fetchGolfLocation
 @brief			fetch Golf Location from web server
 @details		--
 @param			
 @return		void
 */
-(void)fetchGolfLocation;

/*!
 @method		fetchSpaLocations
 @brief			fetch Spa Location from web server
 @details		--
 @param			
 @return		void
 */
-(void)fetchSpaLocations;

/*!
 @method		showErrorMessage
 @brief			show custom Error Message
 @details		--
 @param			(id)parserModelData
 @return		void
 */
-(void) showErrorMessage:(id)parserModelData;

/*!
 @method		golfBookingsDataReceived
 @brief			Update the location array and hit the Spa location service
 @details		--
 @param			(id)parserModelData
 @return		void
 */
-(void) golfBookingsDataReceived:(id) parserModelData;

/*!
 @method		spaBookingsDataReceived
 @brief			Update the location array and reload the location table
 @details		--
 @param			(id)parserModelData
 @return		void
 */
-(void) spaBookingsDataReceived:(id) parserModelData;
@end
