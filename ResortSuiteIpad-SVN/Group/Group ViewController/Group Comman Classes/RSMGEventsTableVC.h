//
//  RSMIEventsTableVC.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/24/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RSMIEventTableCell;
@interface RSMGEventsTableVC : BaseViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray     *dateKeySortedArray;
}
@property (nonatomic, retain) NSDictionary          *folioDateDictionary;
@property (nonatomic, retain) IBOutlet UITableView  *FolioTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withDateDictionary:(NSDictionary *)dateDictionary;

/*!
 @method		setCellDataForCell
 @brief			set cell data for the newly create table cell
 @details		--
 @param			(RSMIEventTableCell *)cell, (NSIndexPath *)indexPath
 @return		void
 */
- (void)setCellDataForCell:(RSMIEventTableCell *)cell ForIndexPath:(NSIndexPath *)indexPath;
/*!
 @method		resetDataIn
 @brief			resetDataIn table cell on cell reload
 @details		--
 @param			(RSMIEventTableCell *)cell
 @return		void
 */
- (void)resetDataIn:(RSMIEventTableCell *)cell;

@end
