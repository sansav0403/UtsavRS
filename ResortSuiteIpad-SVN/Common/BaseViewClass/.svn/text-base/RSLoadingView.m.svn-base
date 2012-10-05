//
//  RSLoadingView.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/1/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSLoadingView.h"

@implementation RSLoadingView
@synthesize loadingBGImageView;
@synthesize LoadingView;
@synthesize LoadingActivityIndicator;

-(void)dealloc
{
    [LoadingView release];
    [loadingBGImageView release];
    [LoadingActivityIndicator release];
    [super dealloc];
}
-(void)startAnimating
{
    [self.LoadingActivityIndicator startAnimating];
}

-(void)stopAnimating
{
    [self.LoadingActivityIndicator stopAnimating];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [[NSBundle mainBundle] loadNibNamed:@"RSLoadingView" owner:self options:nil];
        [self addSubview:self.LoadingView];
    }
    return self;
}

//this function is not called in this case as it is not being loaded from nib buts subview are
- (void) awakeFromNib
{
    [super awakeFromNib];
    
    [[NSBundle mainBundle] loadNibNamed:@"RSLoadingView" owner:self options:nil];
    [self addSubview:self.LoadingView];
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
