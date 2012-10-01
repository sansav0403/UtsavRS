//
//  ResetPasswordReqResponseHandler.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/16/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseReqResponseHandler.h"
@class Result;
@interface ResetPasswordReqResponseHandler : BaseReqResponseHandler
{
    BOOL                isError;
	Result              *resetPasswordResult;
	
	NSMutableString     *value;
}
@property(nonatomic) BOOL               isError;
@property (nonatomic, retain) Result    *resetPasswordResult;

/*!
 @method		callConectionManagerForRequestBody
 @brief			call ConectionManager For given RequestBody
 @details		....
 @param			(NSString *)requestBody
 @return		void
 */
- (void)callConectionManagerForRequestBody:(NSString *)requestBody;

/*!
 @method		parse
 @brief			parse Recieved XML document
 @details		....
 @param			....
 @return		void
 */
- (void) parse:(NSData*)data;
@end
