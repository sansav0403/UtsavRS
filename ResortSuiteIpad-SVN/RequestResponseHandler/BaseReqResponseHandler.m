//
//  BaseReqResponseHandler.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/23/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "BaseReqResponseHandler.h"
#import "ConnectionManager.h"
#import "SoapRequests.h"
#import "RSAlertView.h"
#import "DateManager.h"

@implementation BaseReqResponseHandler
@synthesize connectionManager = _connectionManager;
@synthesize resultError = _resultError;
@synthesize resultArray = _resultArray;

@synthesize delegate;

-(void)dealloc
{
    delegate = nil;
    [_resultError release];
    [_resultArray release];
    [_connectionManager release];
    [super dealloc];
}

-(id)init
{
    self = [super init];
    if (self) {
        
        _resultError = [[NSError alloc]init];
        _resultArray = [[NSMutableArray alloc]init];
        _connectionManager = [[ConnectionManager alloc]init];
        [_connectionManager setDelegate:self];
    }
    return self;
}

-(NSMutableURLRequest *)RequestWithSoapMessageBody:(NSString *) bodyString
{
	SoapRequests *soapRequest = [[SoapRequests alloc] init];
	NSString *soapMessage = [soapRequest createSoapRequestForBody:bodyString];
	[soapRequest release];
	
    
    NSString *wsdlPath = nil;
    NSMutableURLRequest *request = nil;
    //get endpoint url from the prefs every time webservice is hit
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if (![[prefs stringForKey:configStatusKey] isEqualToString:DeprecatedStatus]) {
        wsdlPath = [prefs stringForKey:endPointUrlKey];
        wsdlPath = [wsdlPath stringByReplacingOccurrencesOfString:@" " withString:@""];     //removing the space character
        wsdlPath = [wsdlPath stringByReplacingOccurrencesOfString:@"\n" withString:@""];    //removing the new line character
        
        ///-----------------------------
        NSURL *url = [NSURL URLWithString:wsdlPath];
        
        request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                      timeoutInterval:10.0];
        NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
        
        [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
        
        [request addValue:@"text/xml; charset=utf-8"  forHTTPHeaderField:@"Content-Type"];	//soap 1.2 change
        
        [request setHTTPMethod:@"POST"];
        
        [request setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    }
    return request; //request is nil if the status is deprecated;   //handle this inthe connection manager;
}

#pragma mark - ConnectionManager delegate Methods
-(void)connectionFinishedWithData:(NSData *)data    //handled in child classes
{
    
}
//---------new delegate methods---------
-(void)connectionFailedWithError:(NSError *)error
{
    DLog(@"error in connection = %@",error.description);


    
    RSAlertView *rsAlertView = [[RSAlertView alloc]initWithTitle:POPUP_ConnectionError andMessage:POPUP_ConnectionError_text withDelegate:nil cancelButttonTitle:ALERT_OK_TITLE otherButtonTitle:nil];
    
    [rsAlertView release];
}

@end
