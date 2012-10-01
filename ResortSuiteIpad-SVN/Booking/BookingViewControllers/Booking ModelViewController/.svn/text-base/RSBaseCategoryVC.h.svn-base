//
//  RSBaseCategoryVC.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/29/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSBaseCategoryVC : BaseViewController<UIPickerViewDelegate, UIPickerViewDataSource>
{
                // target to be added in the base calss
    NSDictionary            *_categoryDictionary;
    NSArray                 *_keyArray;                 //to hold the key form the dictionary.
}

@property(nonatomic, retain) NSDictionary *categoryDictionary;       //should also contain key for "All"-complete array
@property(nonatomic, retain) NSArray      *keyArray;                 //to hold the key form the dictionary.

@property (nonatomic, retain) IBOutlet UIPickerView            *pickerView;

@property (nonatomic, retain) IBOutlet UIButton                *selectButton; 

@property (nonatomic, retain) IBOutlet UILabel                 *instructionLbl;


/*!
 @method		AddSelectButtonWithTag
 @brief			update nad update Select Button With selected row information
 @details		--
 @param			(id)sender
 @return		
 */
-(void)AddSelectButtonWithTag:(int)rowinfo;

/*!
 @method		initWithNibName:bundle:withDictionary
 @brief			initialize with category dictionary
 @details		--
 @param			(NSString *)nibNameOrNil, (NSBundle *)nibBundleOrNil, (NSDictionary *)dictionary
 @return		
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withDictionary:(NSDictionary *)dictionary;
@end
