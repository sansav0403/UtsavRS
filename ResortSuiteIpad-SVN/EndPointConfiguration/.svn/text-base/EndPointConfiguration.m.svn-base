//
//  EndPointConfiguration.m
//  ResortSuite
//
//  Created by Cybage on 2/7/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "EndPointConfiguration.h"
#import "EndPointConfigurationParser.h"
#import "RSAlertView.h"
@implementation EndPointConfiguration
@synthesize mobileConfig;
@synthesize delegate;
@synthesize connection = _connection;
@synthesize configFileParser = _configFileParser;
-(void)dealloc
{
    [mobileConfig release];
    [_connection release];
    [_configFileParser release];
    [super dealloc];
}

-(id)init
{
    self = [super init];
    if (self) {
        
        return self;
    }
    return nil;
}

-(NSString *)getEndPOintUrlForVersion:(NSString *)version
{
    return self.mobileConfig.endPointUrl;
}

-(void)setWebConfiguration  //functiont o initiate the connection and parsing
{
    _connection = [[ConnectionManager alloc]init];
    [self.connection setDelegate:self];
    [self.connection startConnectionWithUrl:EndPointConfigurationUrl];
}

#pragma mark - connectionManagerDelegate method

-(void)connectionFinishedWithData:(NSData *)data
{
    NSString *recievedData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    DLog(@"EndPointConfigurationParser recieved data = %@", recievedData);
    [recievedData release];
    
    //call the parser to parse the file.
    _configFileParser = [[EndPointConfigurationParser alloc]init];
    self.configFileParser.delegate = self;
    [self.configFileParser parse:data];
}
-(void)connectionFailedWithError:(NSError *)error
{    
    RSAlertView *rsAlertView = [[RSAlertView alloc]initWithTitle:NotConfigured_tile andMessage:NotConfigured_Message withDelegate:nil cancelButttonTitle:ALERT_OK_TITLE otherButtonTitle:nil];

    [rsAlertView release];
    //remove the splash screen even if the endpoint configuration is not done in case of error
    if (delegate) {
        [self.delegate endPointConfigurationDone];
    }
}
#pragma mark - Parser delegate method
-(void)parsingComplete:(id)parserModelData
{
    self.mobileConfig  = (RSMobile *)parserModelData;   //retain the config object
    //once the parsing is done
    //check if the status is deprecated or not
    //we can directly set the endurl in the nsuser defaults
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    if (![self.mobileConfig.status isEqualToString:DeprecatedStatus]) {        
        [prefs setObject:self.mobileConfig.endPointUrl forKey:endPointUrlKey];
        [prefs setObject:self.mobileConfig.status forKey:configStatusKey];
        if (delegate) {
            [self.delegate endPointConfigurationDone];
        }
    }
    else
    {
        [prefs setObject:self.mobileConfig.status forKey:configStatusKey];
        
        RSAlertView *rsAlertView = [[RSAlertView alloc]initWithTitle:DeprecatedVersionAlertTitle andMessage:DeprecatedVersionAlertMessage withDelegate:nil cancelButttonTitle:ALERT_OK_TITLE otherButtonTitle:nil];
        [rsAlertView release];
    }
    
    self.configFileParser = nil;
}
@end
