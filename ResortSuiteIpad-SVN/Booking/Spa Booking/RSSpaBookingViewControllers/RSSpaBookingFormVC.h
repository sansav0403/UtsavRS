//
//  RSSpaBookingFormVC.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/28/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSBaseBookFormVC.h"
#import "RSSpaService.h"
#import "RSSpaStaffReqResponseHandler.h"
#import "RSSpaServiceReqResponseHandler.h"
#import "RSSpaAvailibiltyReResponseHandler.h"
#import "RSSpaAvailibility.h"
//Describes the table sections
enum MainTableSections {
	SpaServiceSection,
	DateSection,
	TimeSection,
	PrefStaffGenderSection,
	PrefStaffSection
};
@interface RSSpaBookingFormVC : RSBaseBookFormVC<BaseReqResponseHandlerDelegate>
{
    NSString                            *viewTitle;
    
    NSMutableArray                      *mainFieldArray;
	NSMutableArray                      *subFieldArray;
	
	UIDatePicker                        *datePicker;
	UIPickerView                        *prefStaffPicker;	

	UIButton                            *checkAvailButton;
	
	NSMutableArray                      *prefStaffGenders;
	NSMutableArray                      *prefStaffNames;	
    
	NSString                            *prefStaffGender;
    
	RSSpaStaffReqResponseHandler        *_spaStaffreResponseHandler;
	RSSpaStaffs                         *spaStaffs;
    
	int                                 selectedSection;
	int                                 selectedDateStartTime;
	int                                 selectedDateEndTime;
	
	NSString                            *selectedDateAndTime;
    
	bool                                isPickerJustDisable;
    
    RSSpaService                        *notifiedSpaService;    //spa service returned via notice from service table or spa descVC
    
    NSString                            *selectedGender;
    NSString                            *selectedStaff;
    
    
    RSSpaServiceReqResponseHandler      *_spaServiceReqResponseHandler;
    RSSpaServices                       *modelSpaService;       //spa service retruned fromm req response handler
    NSMutableDictionary                 *spaCategoryDictionary;
	
	RSSpaAvailibiltyReResponseHandler   *_spaAvailibilityReqResponseHandler;	
    RSSpaAvailibilties                  *modelSpaAvailibilities;
}

@property(nonatomic,copy) NSString                              *viewTitle;
@property(nonatomic, copy) NSString                             *prefStaffGender;

@property(nonatomic,copy) NSString                              *selectedGender;
@property(nonatomic, copy) NSString                             *selectedStaff;

@property(nonatomic, retain) RSSpaServiceReqResponseHandler     *spaServiceReqResponseHandler;
@property(nonatomic, retain) RSSpaServices                      *modelSpaService;
@property(nonatomic, retain) RSSpaStaffReqResponseHandler       *spaStaffreResponseHandler;
@property(nonatomic, retain) RSSpaStaffs                        *spaStaffs;

@property(nonatomic, retain) NSString                           *selectedDateAndTime;

@property(nonatomic, retain) RSSpaService                       *notifiedSpaService;

@property(nonatomic, retain) RSSpaAvailibiltyReResponseHandler  *spaAvailibilityReqResponseHandler;	
@property(nonatomic, retain) RSSpaAvailibilties                 *modelSpaAvailibilities;
@property(nonatomic) BOOL                                       isCurrentTimeUpdated;

/*!
 @method		shouldBookButtonEnabled
 @brief			check condition when the book button should be enabled
 @details		--
 @param			--
 @return		void
 */
-(void) shouldBookButtonEnabled;

/*!
 @method		fetchSpaStaffsForId:forGender
 @brief			fetch spa staff with prefred gender
 @details		--
 @param			(NSString *)spaItemId, (NSString *)gender
 @return		void
 */
- (void)fetchSpaStaffsForId:(NSString *)spaItemId forGender:(NSString *)gender;

/*!
 @method		fetchSpaServices
 @brief			fetch Spa Services
 @details		--
 @param			--
 @return		void
 */
- (void)fetchSpaServices;

/*!
 @method		loadStaffNamesinPicker
 @brief			load Staff Names in Picker
 @details		--
 @param			(id)parserModelData
 @return		void
 */
- (void)loadStaffNamesinPicker:(id)parserModelData;

/*!
 @method		createDictionaryAndReloadTable
 @brief			create dictionary of spa service.
 @details		--
 @param			--
 @return		void
 */
- (void)createDictionaryAndReloadTable;

/*!
 @method		switchApplicationToSpaServices
 @brief			take the decision if to load the category view or the spa service table
 @details		--
 @param			--
 @return		void
 */
- (void)switchApplicationToSpaServices;


/*!
 @method		doesAvailableTimeExitsInAvailibilityArray
 @brief			take the decision if to load the book confirmation view or the alternate time available
 @details		--
 @param			--
 @return		BOOL
 */
- (BOOL)doesAvailableTimeExitsInAvailibilityArray;
@end
