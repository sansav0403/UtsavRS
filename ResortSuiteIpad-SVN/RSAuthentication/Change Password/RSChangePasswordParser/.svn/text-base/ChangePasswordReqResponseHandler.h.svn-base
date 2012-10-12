//
//  ChangePasswordReqResponseHandler.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/16/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseReqResponseHandler.h"
@interface ChangePasswordReqResponseHandler : BaseReqResponseHandler{
    
    BOOL                    isError;
	Result                  *changePasswordResult;
	
	NSMutableString         *value;
}

@property(nonatomic) BOOL               isError;
@property (nonatomic, retain) Result    *changePasswordResult;

/*!
 @method		parse
 @brief			parse Recieved XML document
 @details		....
 @param			....
 @return		void
 */
- (void) parse:(NSData*)data;

/*!
 @method		callConectionManagerForRequestBody
 @brief			call ConectionManager For given RequestBody
 @details		....
 @param			(NSString *)requestBody
 @return		void
 */
- (void)callConectionManagerForRequestBody:(NSString *)requestBody;
@end
