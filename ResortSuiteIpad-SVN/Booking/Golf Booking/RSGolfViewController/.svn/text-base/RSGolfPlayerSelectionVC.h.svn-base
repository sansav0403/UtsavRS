//
//  RSGolfPlayerSelectionVC.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/5/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSGolfPlayerSelectionVC : BaseViewController<UITableViewDelegate, UITableViewDataSource,UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSMutableArray          *mainFieldArray, *subFieldArray;
    
    NSArray                 *NoPlayersArray;
}

@property (nonatomic, retain) IBOutlet UIButton     *selectButton;
@property (nonatomic, retain) IBOutlet UILabel      *instructionLbl;
@property (nonatomic, retain) IBOutlet UIPickerView *playerPicker;
@property (nonatomic, retain) IBOutlet UITableView  *playerTable;

/*!
 @method		selectButtonAction
 @brief			select ButtonAction
 @details		--
 @param			(id)sender
 @return		
 */
- (IBAction)selectButtonAction:(id)sender;

/*!
 @method		updateSubViews
 @brief			update SubViews of the main view
 @details		--
 @param			(id)sender
 @return		
 */
- (void)updateSubViews;
@end
