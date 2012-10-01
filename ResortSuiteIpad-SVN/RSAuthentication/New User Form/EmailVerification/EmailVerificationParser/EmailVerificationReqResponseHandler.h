//
//  EmailVerificationReqResponseHandler.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/15/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseReqResponseHandler.h"
@interface EmailVerificationReqResponseHandler : BaseReqResponseHandler
{
    
    BOOL                isError;
	Result              *verificationResult;
	NSMutableString     *value;
}
@property(nonatomic) BOOL               isError;
@property (nonatomic, retain) Result    *verificationResult;

/*!
 @method		parse
 @brief			parse Recieved XML document
 @details		....
 @param			....
 @return		void
 */
- (void)parse:(NSData*)data;

/*!
 @method		createEmailVerificationRequestWithEmailAddress
 @brief			create Email Verification Request With given Email Address
 @details		....
 @param			(NSString *)emailAddress
 @return		void
 */
-(void)createEmailVerificationRequestWithEmailAddress:(NSString *)emailAddress;
@end
