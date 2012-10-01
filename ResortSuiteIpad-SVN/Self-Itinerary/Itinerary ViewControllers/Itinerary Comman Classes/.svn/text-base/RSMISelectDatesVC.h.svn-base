//
//  RSMGSelectDatesVC.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/27/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSItineraryReqResponseHandler.h"
enum MIDatesSection {
	MIStartDateSection,
	MIEndDateSection,
	MINoOfDatesSections
};

@interface RSMISelectDatesVC : BaseViewController<BaseReqResponseHandlerDelegate>
{
    int                             currentSelectedRowIndex;
    NSMutableString                 *endDateString,*startDateString;
    RSItineraryReqResponseHandler   *requestHandler;
    
}
 
@property (nonatomic, retain) IBOutlet UITableView      *dateTable;
@property (nonatomic, retain) IBOutlet UIDatePicker     *datePicker;
@property (nonatomic, retain) IBOutlet UIButton         *doneButton;

@property (nonatomic, retain) NSDate                    *startDate;
@property (nonatomic, retain) NSDate                    *endDate;
@property (nonatomic, retain) NSIndexPath               *pathForfirstCell;
@property (nonatomic, retain) NSIndexPath               *pathForcurrentSelectedCell;
@property (nonatomic, retain) RSMyItineraryModel        *guestItinerary;

/*!
 @method		doneButtonAction
 @brief			done Button Action
 @details		--
 @param			(id)sender
 @return		
 */
- (IBAction)doneButtonAction:(id)sender;

/*!
 @method		drawDoneButton
 @brief			draw DoneButton on the view
 @details		--
 @param			--
 @return        void
 */
- (void)drawDoneButton;

/*!
 @method		showErrorMessage
 @brief			show custom Error Message
 @details		--
 @param			(id)parserModelData
 @return        void
 */
- (void)showErrorMessage:(id)parserModelData;
@end
