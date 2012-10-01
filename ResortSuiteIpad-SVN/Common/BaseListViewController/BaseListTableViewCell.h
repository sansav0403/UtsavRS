//
//  BaseListTableViewCell.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/17/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseListTableViewCell : UITableViewCell
{
    
}
@property (nonatomic, retain) IBOutlet UILabel *cellText;
@property (nonatomic, retain) IBOutlet UIImageView *cellOverlayImageView;
@property (nonatomic, retain) IBOutlet UIImageView *cellImageView;

/*!
 @method		EditAccessoryView
 @brief			Edit Accessory View of the Table Cell
 @details		--
 @param			--
 @return		void
 */
-(void) EditAccessoryView;
@end
