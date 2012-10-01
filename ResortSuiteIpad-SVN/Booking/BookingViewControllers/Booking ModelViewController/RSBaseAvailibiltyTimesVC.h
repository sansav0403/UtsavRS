//
//  RSBaseAvailibiltyTimesVC.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/2/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSBaseBookTableCell.h"
@interface RSBaseAvailibiltyTimesVC : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    
}
@property (nonatomic, retain) IBOutlet UILabel      *instructionLbl;
@property (nonatomic, retain) IBOutlet UITableView  *availableTimetable;
@end
