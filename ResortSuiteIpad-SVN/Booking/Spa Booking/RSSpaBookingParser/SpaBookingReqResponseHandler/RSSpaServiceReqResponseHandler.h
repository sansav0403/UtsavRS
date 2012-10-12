//
//  RSSpaServiceReqResponseHandler.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/2/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseReqResponseHandler.h"
#import "RSSpaService.h"
#import "RSFolio.h"


@interface RSSpaServiceReqResponseHandler : BaseReqResponseHandler
{
    NSMutableString *value;
    
    RSSpaService *spaService;
    
    
    
    Result *result;
    
    RSSpaServices *rsSpaServices;
}

@property(nonatomic, retain) RSSpaServices *rsSpaServices;

/*!
 @method		parse
 @brief			Parse data returned form web service
 @details		--
 @param			(NSData*)data
 @return		void
 */
- (void)parse:(NSData*)data;

/*!
 @method		fetchSpaServices
 @brief			fetchSpaServices
 @details		--
 @param			--
 @return		void
 */
- (void)fetchSpaServices;
@end
