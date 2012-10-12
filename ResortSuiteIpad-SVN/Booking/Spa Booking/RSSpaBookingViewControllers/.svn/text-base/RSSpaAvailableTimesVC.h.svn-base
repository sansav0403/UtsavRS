//
//  RSSpaAvailableTimesVC.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/2/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSBaseAvailibiltyTimesVC.h"
@class RSSpaService;

@interface RSSpaAvailableTimesVC : RSBaseAvailibiltyTimesVC
{
    NSArray             *availableTimes;
	RSSpaService        *spaServiceSelected;
	NSString            *selectedStaffName;
	NSString            *selectedStaffGender;
}
@property(nonatomic, retain)  NSArray           *availableTimes;
@property(nonatomic, retain)  RSSpaService      *spaServiceSelected;
@property(nonatomic, retain)  NSString          *selectedStaffName;
@property(nonatomic, retain)  NSString          *selectedStaffGender;


/*!
 @method		initWithAvailableTimes
 @brief		    init thev iewcontroller 
 @details		....
 @param			....
 @return		void
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withAvailableTimes:(NSArray *)times forSelectedSpaService:(RSSpaService *)spaService
    WithSelectedStaff:(NSString *)staffName andGender:(NSString *)staffGender;

@end
