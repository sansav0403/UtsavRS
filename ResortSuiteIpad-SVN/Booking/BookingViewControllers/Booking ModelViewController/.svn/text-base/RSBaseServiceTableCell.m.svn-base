//
//  RSBaseServiceTableCell.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/29/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSBaseServiceTableCell.h"

@implementation RSBaseServiceTableCell
@synthesize serviceNameLbl;
@synthesize startTimeLbl;
@synthesize priceLbl;
@synthesize serviceDurationLbl;
@synthesize customAccessoryButton;

-(void)dealloc
{
    [serviceNameLbl release];
    [startTimeLbl release];
    [priceLbl release];
    [serviceDurationLbl release];
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

-(void)awakeFromNib
{
    serviceNameLbl.highlightedTextColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0] ;
    startTimeLbl.highlightedTextColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0] ;
    priceLbl.highlightedTextColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0] ;
    serviceDurationLbl.highlightedTextColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0] ;
    
    self.selectedBackgroundView.backgroundColor = [UIColor clearColor];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
