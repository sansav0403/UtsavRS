//
//  RSDateTimeSelectionVC.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/29/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>


//Describes the picker type either Date or Time picker
enum PickerType {
	DatePicker = 1,
	TimePicker,	
};

//Describes the Golf picker type either Date or Time picker
enum golfPickerType
{
    golfDatePicker,
    golfTimePicker,
};

@interface RSDateTimeSelectionVC : BaseViewController
{
    NSMutableArray                  *mainFieldArray, *subFieldArray;
	
	int                             selectedDateStartTime;
	int                             selectedDateEndTime;
	
	int                             pickerType;		//decides which picker to load
	NSString                        *dateString;
	NSString                        *timeString;
	BOOL                            isGolf;
    NSMutableArray                  *dayTimes;    //array to store the end and start time for the 
    //selected date and pass the info to the spabooking form as nottice
}

@property(nonatomic)         int pickerType;
@property(nonatomic, retain) NSString *dateString;
@property(nonatomic, retain) NSString *timeString;

@property(nonatomic, assign) BOOL isGolf;

@property (nonatomic, retain) IBOutlet UITableView *dateTable;
@property (nonatomic, retain) IBOutlet UIButton *searchButton;
@property (nonatomic, retain) IBOutlet UILabel *instructionLbl;
@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withSection:(int) section dateString:(NSString *) dateStr;

/*!
 @method		initWithNibName:bundle:withSection:dateString:timeString
 @brief			initialize with date and time string
 @details		--
 @param			(NSString *)nibNameOrNil, (NSBundle *)nibBundleOrNil, (int) section,                    
                (NSString *)dateStr, (NSString *) timeStr
 @return		
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withSection:(int) section dateString:(NSString *) dateStr timeString:(NSString *) timeStr;

/*!
 @method		setControllers
 @brief			add and set required view
 @details		--
 @param			(id)sender
 @return		
 */
-(void) setControllers;
/*!
 @method		createSelectedDateTime
 @brief		    Create a start time and end time for day of the week from the given strings
 @details		....
 @param			(NSString *)startTimeOfDay, (NSString *)endTimeOfDay ;
 @return		void
 */
-(void) createSelectedDateTime:(NSString *)startTimeOfDay withEndTime:(NSString *)endTimeOfDay; 

/*!
 @method		dateFromString
 @brief		    Create a date format using the string parameter
 @details		....
 @param			NSString stringDate
 @return		NSDate
 */
-(NSDate *)dateFromString:(NSString *)stringDate;

/*!
 @method		convertTimeIn24Hour
 @brief		    Method converts the Time in 24 hr clock
 @details		....
 @param			int time
 @return		int
 */
-(int) convertTimeIn24Hour: (int) time;

/*!
 @method		setMinimumAndMaximumTimeForTheSelectedDate
 @brief		    Method which sets the min/max time for selected date
 @details		....
 @param			Date
 @return		void
 */
-(void)setMinimumAndMaximumTimeForTheSelectedDate:(NSDate *)selectedDate;
/*!
 @method		createStartAndEndTimeForGolfWithWeekday
 @brief			create Start And End Time For Golf for given Weekday
 @details		
 @param			
 @return		void
 */
-(void)createStartAndEndTimeForGolfWithWeekday:(NSInteger )weekday;
/*!
 @method		createStartAndEndTimeForSpaWithWeekday
 @brief			create Start And End Time For spa for given Weekday
 @details		
 @param			
 @return		void
 */
-(void)createStartAndEndTimeForSpaWithWeekday:(NSInteger )weekday;
@end
