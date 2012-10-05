//
//  BaseReqResponseHandler.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/23/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConnectionManager.h"

@protocol BaseReqResponseHandlerDelegate <NSObject>

-(void)parsingComplete:(id)ModelData; //to get present implementation consistensy

@end

@interface BaseReqResponseHandler : NSObject <ConnectionManagerDelegate,NSXMLParserDelegate>
{
    id<BaseReqResponseHandlerDelegate> delegate;
    NSError *_resultError;
    NSMutableArray *_resultArray;
    ConnectionManager *_connectionManager;
}

@property (nonatomic, retain) NSError *resultError;
@property (nonatomic, retain) NSMutableArray *resultArray;
@property (nonatomic, retain) ConnectionManager *connectionManager;

@property (nonatomic, assign) id<BaseReqResponseHandlerDelegate> delegate;

/*!
 @method		RequestWithSoapMessageBody
 @brief			Create Request Obkect With Soap MessageBody
 @details		....
 @param			(NSString *)bodyString
 @return		NSMutableURLRequest
 */
- (NSMutableURLRequest *)RequestWithSoapMessageBody:(NSString *)bodyString;
@end
