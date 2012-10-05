//
//  RSGolfBookingFormVC.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/5/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSBaseBookFormVC.h"
#import "RSSpaLocation.h"
#import "RSGolfTeeTimeReqResponseHandler.h"
#import "RSGolfTeeTimes.h"
enum MainTableSections {
	GolfDateSection,
	TeeTimeSection,
    PlayersCountSection
};

@interface RSGolfBookingFormVC : RSBaseBookFormVC<BaseReqResponseHandlerDelegate>
{
    NSString                            *selectedCourseID;
    
    NSMutableArray                      *mainFieldArray;
	NSMutableArray                      *subFieldArray;
    
    int                                 selectedSection;        //to store which section was selected
    
    bool                                isPickerJustDisable;
    
    RSGolfTeeTimeReqResponseHandler     *_teeTimeReqResponseHandler;
    RSGolfTeeTimes                      *teeTimesModel;
}

@property(nonatomic, copy) NSString *selectedCourseID;
@property (nonatomic, retain) RSGolfTeeTimeReqResponseHandler *teeTimeReqResponseHandler;
@property (nonatomic, retain) RSGolfTeeTimes *teeTimesModel;

/*!
 @method		initWithCourseId
 @brief			init With CourseId   
 @details		
 @param			id
 @return		void
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withCourseId:(NSString *)CourseID;
/*!
 @method		shouldBookButtonEnabled
 @brief			put condition when the select button should be enabled   
 @details		
 @param			
 @return		void
 */
- (void)shouldBookButtonEnabled;
/*!
 @method		dateFromString
 @brief			get date object fron date string  
 @details		
 @param			NSString
 @return		NSDate
 */
- (NSDate *)dateFromString:(NSString *)stringDate;

/*!
 @method		fetchTeeTime
 @brief			fetch Tee Time from we service 
 @details		
 @param			id
 @return		void
 */
- (void)fetchTeeTime;


@end
