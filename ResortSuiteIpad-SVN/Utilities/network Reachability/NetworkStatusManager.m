//
//  NetworkStatusManager.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/23/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "NetworkStatusManager.h"

static NetworkStatusManager *networkStatusManager=nil;

@implementation NetworkStatusManager
@synthesize isConnectedToInternet;

+(NetworkStatusManager *)networkStatusManager
{
    @synchronized(self)
	{
		if(networkStatusManager==nil)
		{
			networkStatusManager=[[NetworkStatusManager alloc]init];
        }
	}
    
	return networkStatusManager;
}

-(id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(checkNetworkStatus:) 
                                                     name:kReachabilityChangedNotification 
                                                   object:nil];
        
        internetReachable = [[Reachability reachabilityForInternetConnection] retain];
        [internetReachable startNotifier];
        
        NetworkStatus status = [internetReachable currentReachabilityStatus];
        
        if(status == NotReachable) {
            self.isConnectedToInternet = NO;
        } else {
            self.isConnectedToInternet = YES;
        }

    }
    return self;
}

#pragma mark Internet Reachability
- (void) checkNetworkStatus:(NSNotification *)notice
{
    // called after network status changes
    
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    switch (internetStatus)
    
    {
        case NotReachable:
        {
            DLog(@"The internet is down.");
            self.isConnectedToInternet = NO;
            break;
            
        }
        case ReachableViaWiFi:
        {
            DLog(@"The internet is working via WIFI.");
            self.isConnectedToInternet = YES;
            break;
            
        }
        case ReachableViaWWAN:
        {
            DLog(@"The internet is working via WWAN.");
            self.isConnectedToInternet = YES;
            break;
            
        }
    }
}

@end
