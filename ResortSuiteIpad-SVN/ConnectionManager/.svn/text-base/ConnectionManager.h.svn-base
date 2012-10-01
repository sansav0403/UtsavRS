//
//  ConnectionManager.h
//  ResortSuite
//
//  Created by Cybage on 2/7/12.
//  Copyright (c) 2012 Cybage. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ConnectionManagerDelegate <NSObject>
@required
-(void)connectionFinishedWithData:(NSData *)data;

@optional

-(void)connectionFailedWithError:(NSError *)error;
@end

@interface ConnectionManager : NSObject
{
    id <ConnectionManagerDelegate>  delegate;
    NSMutableData                   *_webData;
    NSURLConnection                 *_connection;   
    
    
}

@property (nonatomic, assign) id <ConnectionManagerDelegate> delegate;


/*!
 @method		isNetworkConnectionAvailable
 @brief			Check if network connection is available
 @details		--
 @param			--
 @return		BOOL
 */
- (BOOL)isNetworkConnectionAvailable;

/*!
 @method		startConnectionWithUrl
 @brief			start Connection With Given Url
 @details		--
 @param			(NSString *)urlString
 @return		void
 */
- (void)startConnectionWithUrl:(NSString *)urlString;

/*!
 @method		startConnectionWithSoapStringMessage
 @brief			start Connection With Given Soap String
 @details		--
 @param			(NSString *)SoapMessage
 @return		void
 */
- (void)startConnectionWithSoapStringMessage:(NSString *)SoapMessage;

/*!
 @method		stopConnection
 @brief			stop Connection
 @details		Stop connection process and release all resources
 @param			--
 @return		void
 */
- (void)stopConnection;

/*!
 @method		startConnectionWithRequest
 @brief			start Connection With Request object
 @details		Stop connection process and release all resources
 @param			(NSURLRequest *)request
 @return		void
 */
- (void)startConnectionWithRequest:(NSURLRequest *)request;  //this to be used for new structure.
@end
