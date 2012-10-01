//
//  BaseListViewController.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/15/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseListTableViewCell.h"
@interface BaseListViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
   
}

@property (nonatomic, retain) IBOutlet UIImageView *headerImageView;
@property (nonatomic, retain) IBOutlet UIImageView *headerOverlayImageView;
@property (nonatomic, retain) IBOutlet UITableView *listTableView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *serviceActivity;
@end
