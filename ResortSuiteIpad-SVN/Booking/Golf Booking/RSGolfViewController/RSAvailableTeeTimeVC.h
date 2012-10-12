//
//  RSAvailableTeeTimeVC.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/5/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSBaseAvailibiltyTimesVC.h"


@interface RSAvailableTeeTimeVC : RSBaseAvailibiltyTimesVC
{
    NSArray *AvailableTeeTimeArray;
    
    NSString *selectedCourseId;
    NSString *selectedNoOfPlayers;
}   
@property(nonatomic, retain)  NSArray *AvailableTeeTimeArray;
@property(nonatomic, copy)  NSString *selectedCourseId;
@property(nonatomic, copy)  NSString *selectedNoOfPlayers;
/*!
 @method		initWithTeeTimeArray:bundle:withTeeTimeArray:withSelectedCourseId:andNoOfPlayer
 @brief			init With TeeTime Array for selected course id and number of player
 @details		
 @param			(NSArray *)TeeTime, (NSString *)courseID, (NSString *)players
 @return		id
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withTeeTimeArray:(NSArray *)TeeTime withSelectedCourseId:(NSString *)courseID andNoOfPlayer:(NSString *)players;

@end
