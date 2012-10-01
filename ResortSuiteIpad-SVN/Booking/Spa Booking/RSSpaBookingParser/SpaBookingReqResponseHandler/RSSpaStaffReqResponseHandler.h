//
//  RSSpaStaffReqResponseHandler.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/2/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSSpaStaff.h"
#import "RSFolio.h"
#import "BaseReqResponseHandler.h"
@interface RSSpaStaffReqResponseHandler : BaseReqResponseHandler
{
    
    NSMutableString *value;
    
    RSSpaStaff *spaStaff;
    
    Result *result;
    
    RSSpaStaffs *rsSpaStaffs;
}

@property(nonatomic, retain)  RSSpaStaffs *rsSpaStaffs;

/*!
 @method		parse
 @brief			Parse data returned form web service
 @details		--
 @param			(NSData*)data
 @return		void
 */
- (void)parse:(NSData*)data;

/*!
 @method		fetchSpaStaffsForId
 @brief			fetch spaStaff for prefered gender
 @details		--
 @param			(NSString *)spaItemId, (NSString *)gender
 @return		void
 */
- (void)fetchSpaStaffsForId:(NSString *)spaItemId forGender:(NSString *)gender;
@end
