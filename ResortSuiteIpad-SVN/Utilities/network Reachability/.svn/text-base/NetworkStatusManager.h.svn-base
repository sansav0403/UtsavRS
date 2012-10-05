//
//  NetworkStatusManager.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/23/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
@interface NetworkStatusManager : NSObject
{
    BOOL isConnectedToInternet;
    Reachability *internetReachable;
}
@property (nonatomic, assign) BOOL isConnectedToInternet;

/*!
 @method		networkStatusManager
 @brief			Return a singleton instance of networkStatusManager object
 @details		....
 @param			....
 @return		NetworkStatusManager
 */
+(NetworkStatusManager *)networkStatusManager;

@end
