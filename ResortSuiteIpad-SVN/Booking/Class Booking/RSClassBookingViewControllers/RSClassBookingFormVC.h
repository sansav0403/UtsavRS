//
//  RSClassBookingFormVC.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/28/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSBaseBookFormVC.h"
#import "RSSpaClass.h"
#import "RSDailySpaClassReqResponseHandler.h"
#import "RSSpaClass.h"

enum ClassTableSections {
    ClassDateSection,
	ClassServiceSection	
};
@interface RSClassBookingFormVC : RSBaseBookFormVC<BaseReqResponseHandlerDelegate>
{
    NSMutableArray                          *mainFieldArray;
	NSMutableArray                          *subFieldArray;    
    NSString                                *viewTitle;
    UILabel                                 *instructionLabel;    
    int                                     selectedSection;
    
    RSDailySpaClassReqResponseHandler       *dailySpaCLassReqResHandler;
    RSDailySpaClasses                       *dailySpaClassesModel;
    //to manage the dictiopnary creation
    NSMutableDictionary                     *classCategoryDictionary;
    RSSpaClass                              *selectedSpaClass;

}

@property(nonatomic, copy) NSString                 *viewTitle;
@property (nonatomic, retain) RSDailySpaClasses     *dailySpaClassesModel;
@property (nonatomic, retain) RSSpaClass            *selectedSpaClass;     //to store the obj from notification

/*!
 @method		shouldBookButtonEnabled
 @brief			check condition when teh book buton should be enabled
 @details		--
 @param			--
 @return		void
 */
-(void)shouldBookButtonEnabled;

/*!
 @method		fetchSpaClasses
 @brief			fetch Spa Classes from the web service
 @details		--
 @param			--
 @return		void
 */
-(void)fetchSpaClasses;

/*!
 @method		createDictionaryAndReloadTable
 @brief			create dictionary of the spa classes and load the table view
 @details		--
 @param			--
 @return		void
 */
-(void)createDictionaryAndReloadTable;
@end
