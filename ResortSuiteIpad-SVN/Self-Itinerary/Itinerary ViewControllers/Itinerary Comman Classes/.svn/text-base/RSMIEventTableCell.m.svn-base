//
//  RSMIEventTableCell.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/24/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSMIEventTableCell.h"

@implementation RSMIEventTableCell

@synthesize startTimeLabel;
@synthesize endTimeLabel;
@synthesize DotLineLabel;
@synthesize FolioDetailLabel;
@synthesize customAccessoryButton;
-(void)dealloc
{
    [startTimeLabel release];
    [endTimeLabel release];
    [DotLineLabel release];
    [FolioDetailLabel release];
    [customAccessoryButton release];
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
    [self.DotLineLabel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:SeparatorImage]]];
}
@end
