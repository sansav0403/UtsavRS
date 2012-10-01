//
//  RSBaseSpaServiceTableVC.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/29/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSBaseSpaServiceTableVC : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{

}

@property(nonatomic, retain) IBOutlet UILabel       *serviceNameLbl;
@property(nonatomic, retain) IBOutlet UILabel       *startTimeLbl;
@property(nonatomic, retain) IBOutlet UILabel       *priceLbl;
@property(nonatomic, retain) IBOutlet UILabel       *serviceDurationLbl;
@property(nonatomic, retain) IBOutlet UILabel       *instructionLbl;
@property (nonatomic, retain) IBOutlet UILabel      *seperatorLbl;
@property(nonatomic, retain) IBOutlet UITableView   *serviceTable;
@property(nonatomic, retain) IBOutlet UIButton      *selectButton;
@end
