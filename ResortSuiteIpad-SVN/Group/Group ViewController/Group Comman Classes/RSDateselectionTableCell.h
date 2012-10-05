//
//  RSDateselectionTableCell.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/27/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSDateselectionTableCell : UITableViewCell
{

}

@property (nonatomic, retain) IBOutlet UILabel *cellText;
@property (nonatomic, retain) IBOutlet UILabel *detailText;

/*!
 @method		setBgForSelectedCell
 @brief			Sets the bg image for the selected cell of the table
 @details		....
 @param			UITableView tableView, NSIndexPath indexPath
 @return		void
 */
-(void) setBgForSelectedCell:(UITableView *) tableView forIndex:(NSIndexPath *) indexPath;

/*!
 @method		setAccessoryViewImage
 @brief			Sets the accessory image for the cell
 @details		....
 @param			BOOL
 @return		void
 */
-(void) setAccessoryViewImage:(BOOL) isAccessoryImage;

@end
