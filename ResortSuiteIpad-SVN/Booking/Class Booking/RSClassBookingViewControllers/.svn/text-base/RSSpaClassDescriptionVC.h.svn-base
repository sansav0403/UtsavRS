//
//  RSSpaClassDescriptionVC.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/5/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSConfirmationBaseClass.h"
#import "RSSpaClass.h"

@interface RSSpaClassDescriptionVC : RSConfirmationBaseClass
{
    RSSpaClass  *selectedClass;
}

@property (nonatomic, retain) RSSpaClass *selectedClass;
/*
 @method        initWithSelectedClass
 @brief			initialize object With Selected spa Class
 @details		
 @param			(RSSpaClass *)selClass
 @return        (id)
 */
- (id)initWithSelectedClass:(RSSpaClass *)selClass;

/*
 @method        getDateTimeFromString
 @brief			get date or time from date string based on the requiured format
 @details		
 @param			(NSString *) dateString
 @return        (NSString *)
 */
- (NSString *) getDateTimeFromString:(NSString *)dateString format:(NSString *)dateOrTime;

/*
 @method        updateActionButton
 @brief			update Action Button
 @details		
 @param			--
 @return        void
 */
- (void)updateActionButton;


@end
