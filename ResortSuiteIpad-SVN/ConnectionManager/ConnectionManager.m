//
//  ConnectionManager.m
//  ResortSuite
//
//  Created by Cybage on 2/7/12.
//  Copyright (c) 2012 Cybage. All rights reserved.
//

#import "ConnectionManager.h"
#import "RSAppDelegate.h"
#import "NetworkStatusManager.h"
#import "RSAlertView.h"
@implementation ConnectionManager

@synthesize delegate;

-(void)dealloc
{
    [self stopConnection];
    [super dealloc];
}
-(id)init
{
    self = [super init];
    if (self) {
        _connection = nil;  //initialize with nil, incase stop connection is called without initializing connection object
        _webData = nil;
        return self;
    }
    return nil;
}

-(BOOL)isNetworkConnectionAvailable
{

    
    NetworkStatusManager *networkStatusManager = [NetworkStatusManager networkStatusManager];

    if (networkStatusManager.isConnectedToInternet) {
        return YES;
    }
    else
    {
        
        RSAlertView *rsAlertView = [[RSAlertView alloc]initWithTitle:POPUP_Offline_Mode andMessage:POPUP_Offline_Content_Unavailable withDelegate:nil cancelButttonTitle:POPUP_Button_Cancel otherButtonTitle:POPUP_Button_Ok];
        [rsAlertView release];
    }
    return NO;

}

-(void)startConnectionWithUrl:(NSString *)urlString
{
    if ([self isNetworkConnectionAvailable]) {
        [self stopConnection]; //stop any connection activity currently going on
        
        NSURL *url = [NSURL URLWithString:urlString];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

        
        _connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
        if (_connection) {
            _webData = [[NSMutableData data]retain];
        }
    }
    else
    {
        //create a error result and infor the delegate object
        NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
        [errorDetail setValue:POPUP_ConnectionError_text forKey:NSLocalizedDescriptionKey];
        NSError *networkError = [NSError errorWithDomain:kNetwokError code:100 userInfo:errorDetail];
        [self stopConnection]; //stop any connection activity currently going on
        if (delegate) {
            [delegate connectionFailedWithError:networkError];
        }
    }

    
}

-(void)startConnectionWithSoapStringMessage:(NSString *)soapMessage
{
    if ([self isNetworkConnectionAvailable]) {
    
        [self stopConnection]; //stop any connection activity currently going on
    
        NSString *wsdlPath;
        //get endpoint url from the prefs every time webservice is hit
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        if (![[prefs stringForKey:configStatusKey] isEqualToString:DeprecatedStatus]) {
            wsdlPath = [prefs stringForKey:endPointUrlKey];
            wsdlPath = [wsdlPath stringByReplacingOccurrencesOfString:@" " withString:@""];     //removing the space character
            wsdlPath = [wsdlPath stringByReplacingOccurrencesOfString:@"\n" withString:@""];    //removing the new line character
        
        ///-----------------------------
            NSURL *url = [NSURL URLWithString:wsdlPath];
	
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
            NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
	
            [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
	
            [request addValue:@"text/xml; charset=utf-8"  forHTTPHeaderField:@"Content-Type"];	//soap 1.2 change
	
            [request setHTTPMethod:@"POST"];
	
            [request setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
	
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
            _connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
            if (_connection) {
                _webData = [[NSMutableData data]retain];
            }
        }
        else
        {
            RSAlertView *rsAlertView = [[RSAlertView alloc]initWithTitle:DeprecatedVersionAlertTitle andMessage:DeprecatedVersionAlertMessage withDelegate:nil cancelButttonTitle:ALERT_OK_TITLE otherButtonTitle:nil];
            [rsAlertView release];
            
        }
    }
    else
    {
        //create a error result and infor the delegate object
        NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
        [errorDetail setValue:POPUP_ConnectionError_text forKey:NSLocalizedDescriptionKey];
        NSError *networkError = [NSError errorWithDomain:kNetwokError code:100 userInfo:errorDetail];
        [self stopConnection]; //stop any connection activity currently going on
        if (delegate) {
            [delegate connectionFailedWithError:networkError];
        }
    }
}

-(void)startConnectionWithRequest:(NSURLRequest *)request
{
    if ([self isNetworkConnectionAvailable]) {  //check if the network is available
        if (request != nil) {   //request is nil when the end point config status is deprecated
            [self stopConnection]; //stop any connection activity currently going on
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
            _connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
            if (_connection) {
                _webData = [[NSMutableData data]retain];
            }
        }
        
    }
    else
    {
        //create a error result and infor the delegate object
        NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
        [errorDetail setValue:POPUP_ConnectionError_text forKey:NSLocalizedDescriptionKey];
        NSError *networkError = [NSError errorWithDomain:kNetwokError code:100 userInfo:errorDetail];
        [self stopConnection]; //stop any connection activity currently going on
        if (delegate) {
            [delegate connectionFailedWithError:networkError];
        }
    }
}

-(void)stopConnection
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible  = NO;
    if (_connection) {
        [_connection cancel];
        [_connection release];
        _connection = nil;
    }
    if (_webData) {
        [_webData release];
        _webData = nil;
    }
    
}
#pragma mark - NSUrlConnection delegate method

- (void)connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *)response
{
    [_webData setLength:0];
}

- (void)connection:(NSURLConnection *) connection didReceiveData:(NSData *)data
{
    [_webData appendData:data];
}

- (void)connection:(NSURLConnection *) connection didFailWithError:(NSError *)error
{
    [self stopConnection];
    if (delegate) {
        [delegate connectionFailedWithError:error];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{

    if (delegate) {
        [self.delegate connectionFinishedWithData:_webData];  
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible  = NO;
    [self stopConnection];
}
#pragma mark Deal with self-signed certificates

//Sent to determine whether the delegate is able to respond to a protection space’s form of authentication.
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
	return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

//Sent when a connection must authenticate a challenge in order to download its request.
/*called when the connetion recieves a challenge from the server*/
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
		[challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
	
	[challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}


@end
