//
//  EndPointConfiguration.h
//  ResortSuite
//
//  Created by Cybage on 2/7/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConnectionManager.h"
#import "RSParseBase.h"
#import "RSMobile.h"
@class EndPointConfigurationParser;
//create a delegate method to inform the appdelegate object that endpointconfiguration is done and remove the splash screen
@protocol endPointConfigurationDelegate <NSObject>

-(void)endPointConfigurationDone;

@end
@interface EndPointConfiguration : NSObject<ConnectionManagerDelegate,RSParserHandlerDelegate>
{
    id<endPointConfigurationDelegate>       delegate;
    RSMobile                                *mobileConfig;
    ConnectionManager                       *_connection;
    EndPointConfigurationParser             *_configFileParser;
}

@property (nonatomic, retain) RSMobile                              *mobileConfig;
@property (nonatomic, assign) id<endPointConfigurationDelegate>     delegate;
@property (nonatomic, retain) ConnectionManager                     *connection;
@property (nonatomic, retain) EndPointConfigurationParser           *configFileParser;


/*!
 @method		setWebConfiguration
 @brief			set Web Configuration
 @details		--
 @param			--
 @return		void
 */
-(void)setWebConfiguration;

@end
