//
//  RSBaseServiceTableCell.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/29/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSBaseServiceTableCell : UITableViewCell
{

}
@property(nonatomic, retain) IBOutlet UILabel       *serviceNameLbl;
@property(nonatomic, retain) IBOutlet UILabel       *startTimeLbl;
@property(nonatomic, retain) IBOutlet UILabel       *priceLbl;
@property(nonatomic, retain) IBOutlet UILabel       *serviceDurationLbl;

@property (nonatomic, retain) IBOutlet UIButton     *customAccessoryButton;

@end
