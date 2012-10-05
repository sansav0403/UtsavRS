//
//  RSGolfLocationVC.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/28/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSGolfLocations.h"
#import "RSBaseBookVC.h"
@interface RSGolfLocationVC : RSBaseBookVC
{

}

@property (nonatomic, retain) RSGolfLocations *golfLocationsModel;


/*!
 @method		initWithNibName:bundle:withGolfLocationModel
 @brief			intialize the view with model golflocation object
 @details		--
 @param			(RSGolfLocations *)golfLocations
 @return		id
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withGolfLocationModel:(RSGolfLocations *)golfLocations;
@end
