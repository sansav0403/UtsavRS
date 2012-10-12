//
//  CreateCustomerReqResponseHandler.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/15/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseReqResponseHandler.h"
@interface CreateCustomerReqResponseHandler : BaseReqResponseHandler
{
    BOOL                isError;
	Result              *createCustomerResult;
	int                 customerID;
	NSMutableString     *value;
}
@property(nonatomic) BOOL               isError;
@property (nonatomic, retain) Result    *createCustomerResult;
@property (nonatomic) int               customerID;

/*!
 @method		parse
 @brief			parse Recieved XML document
 @details		....
 @param			....
 @return		void
 */
- (void)parse:(NSData*)data;

/*!
 @method		callConectionManagerForRequestBody
 @brief			start ConectionManager ForRequestBody
 @details		....
 @param			(NSString *)requestBody
 @return		void
 */
- (void)callConectionManagerForRequestBody:(NSString *)requestBody;
@end
