//
//  BaseView.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/14/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView
@synthesize view = _view;
@synthesize baseBGImageView;
@synthesize baseBGOverlayImageView;

-(void)dealloc
{
    [baseBGImageView release];
    [baseBGOverlayImageView release];
    [_view release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray * bundle = [[NSBundle mainBundle] loadNibNamed:@"View" owner:self options:nil];
        
        
        for (id object in bundle) {
            if ([object isKindOfClass:[UIView class]])
                self.view = (UIView *)object;
        } 
        
        [self addSubview:self.view];
        //set conditionaly the BG image for hotel or club
        
#if defined (HOTEL_VERSION)
        [self.baseBGImageView setImage:[UIImage imageNamed:Hotel_BGImage]];
#endif
#if defined (CLUB_VERSION)//FrontSplashRS_Club
         [self.baseBGImageView setImage:[UIImage imageNamed:Club_BGImage]];
#endif
        [self.baseBGOverlayImageView setImage:[UIImage imageNamed:ScreenWhiteOverLay]];
    }
    return self;
}

- (void) awakeFromNib
{
    [super awakeFromNib];
    
    [[NSBundle mainBundle] loadNibNamed:@"View" owner:self options:nil];
    [self addSubview:self.view];
}
-(void)layoutSubviews
{
    [self autoresizesSubviews];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
