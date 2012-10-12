//
//  RSSpaStaffSeletionVC.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/1/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
enum StaffPickerType {
	PrefStaffGenderPicker = 3,
	PrefStaffPicker
};
@interface RSSpaStaffSeletionVC : BaseViewController<UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource>
{
    UIPickerView                *prefStaffPicker;
	NSMutableArray              *mainFieldArray, *subFieldArray, *prefStaffGenders;
	NSArray                     *prefStaffNames;
	int                         pickerType;
	UIButton                    *selectButton;
}
@property (nonatomic, retain) NSArray                       *prefStaffNames;

@property(nonatomic, retain) IBOutlet UIPickerView          *prefStaffPicker;
@property(nonatomic, retain) IBOutlet UIButton              *selectButton;
@property(nonatomic, retain) IBOutlet UILabel               *instructioLbl;
@property(nonatomic, retain) IBOutlet UITableView           *mainTableView;

/*!
 @method		initWithSection
 @brief			Initialization for type of picker like Gender or Names picker
 @details		....
 @param			int section, array of pref staff genders or names
 @return		RSSpaStaffSeletionVC class object
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withSection:(int) section prefStaffs:(NSArray *) prefstaffs;
/*!
 @method		addControlsToView
 @brief			Add UI controls to the view
 @details		....
 @param			nil
 @return		void
 */
-(void) addControlsToView;
@end
