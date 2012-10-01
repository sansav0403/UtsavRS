//
//  RSGolfCoursesVC.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/28/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSGolfCourseReqResponseHandler.h"
#import "RSBaseBookVC.h"

@interface RSGolfCoursesVC : RSBaseBookVC<BaseReqResponseHandlerDelegate>
{

    RSGolfCourseReqResponseHandler *golfCourseReqResponseHandler;
    int golfLocationID;
    
    NSMutableArray *TableDataArray;
    NSMutableArray *golfCourseArray;

}

@property(nonatomic,assign) int golfLocationID;


/*!
 @method		initWithNibName:bundle:withGolfLocationID
 @brief			intialize the view with golflocation ID
 @details		--
 @param			(int)locationID
 @return		id
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withGolfLocationID:(int)locationID;
@end
