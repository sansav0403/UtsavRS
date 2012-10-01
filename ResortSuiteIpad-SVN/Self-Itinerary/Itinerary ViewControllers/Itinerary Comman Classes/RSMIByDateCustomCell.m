//
//  RSMIByDateCustomCell.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/23/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSMIByDateCustomCell.h"

@implementation RSMIByDateCustomCell
@synthesize cellDateText;

-(void) dealloc
{
    [cellDateText release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)awakeFromNib
{
    UIImageView *cellBackgroundImageView = [[UIImageView alloc]initWithFrame:self.frame];
    cellBackgroundImageView.image = [UIImage imageNamed:ListCellUnSelectedBG];
    self.backgroundView = cellBackgroundImageView;
    [cellBackgroundImageView release];
    
    UIImageView *viewSelected = [[UIImageView alloc] initWithFrame:self.frame];
    viewSelected.image = [UIImage imageNamed:ListCellSelectedBG];
    self.selectedBackgroundView = viewSelected;
    [viewSelected release];
    
    //Insert custom Accessory View
    self.accessoryType = UITableViewCellAccessoryNone;
    UIImageView* cellAccessoryImageView = [[UIImageView alloc] initWithFrame:CellAccessoryImageRect];
    cellAccessoryImageView.image = [UIImage imageNamed:CellAccessoryImage];
    cellAccessoryImageView.backgroundColor = [UIColor clearColor];
    self.accessoryView = cellAccessoryImageView;
    [cellAccessoryImageView release];
    
}

@end
