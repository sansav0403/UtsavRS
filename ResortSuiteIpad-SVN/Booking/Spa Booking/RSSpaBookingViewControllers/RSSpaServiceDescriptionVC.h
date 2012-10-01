//
//  RSSpaServiceDescriptionVC.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/5/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSConfirmationBaseClass.h"
#import "RSSpaService.h"

@interface RSSpaServiceDescriptionVC : RSConfirmationBaseClass
{
    RSSpaService *selectedService;
}
@property(nonatomic, retain) RSSpaService *selectedService;

/*!
 @method		initWithSelectedService
 @brief		    init With Selected Service
 @details		....
 @param			-
 @return		id
 */ 
-(id)initWithSelectedService:(RSSpaService *)selSerivce;

/*!
 @method		UpdateSelectButton
 @brief		    Update SelectButton
 @details		....
 @param			-
 @return		void
 */
-(void)UpdateSelectButton;
@end
