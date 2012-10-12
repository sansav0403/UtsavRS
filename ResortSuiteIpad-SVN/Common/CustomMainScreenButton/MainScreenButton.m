//
//  MainScreenButton.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/14/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "MainScreenButton.h"

@implementation MainScreenButton

#define buttonTitleFontSize 14
- (void)dealloc {
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.

		self.backgroundColor = [UIColor clearColor];
		self.opaque = NO;
    }
    return self;
}
-(void)layoutSubviews
{   //----------------
    if (layoutImageView) {
        [layoutImageView removeFromSuperview];
        layoutImageView = nil;
    }
    if (mainScreenButtonImage) {
        [mainScreenButtonImage removeFromSuperview];
        mainScreenButtonImage = nil;
    }
    
    if (buttonTitleLabel) {
        [buttonTitleLabel removeFromSuperview];
        buttonTitleLabel = nil;
    }
    
    CGSize layoutImageSize = [[UIImage imageNamed:MyMenuLeftButtonOverlay]size];
    layoutImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y ,layoutImageSize.width, layoutImageSize.height)];
    

    
    CGSize MainImageSize = [[UIImage imageNamed:RefrenceImageForSize]size];
        mainScreenButtonImage = [[UIImageView alloc]initWithFrame:CGRectMake(26, self.bounds.origin.y +33, MainImageSize.width*2+6, MainImageSize.height*2)];
    

    
    buttonTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(26, 100, ((self.bounds.size.width)*8/10), (self.bounds.size.height-100))];
    [buttonTitleLabel setTextAlignment:UITextAlignmentCenter];
    [buttonTitleLabel setFont:[UIFont boldSystemFontOfSize:buttonTitleFontSize]];
    [buttonTitleLabel setBackgroundColor:[UIColor clearColor]];
    
    
    [self addSubview:mainScreenButtonImage];
    [self addSubview:layoutImageView];
    [self addSubview:buttonTitleLabel];
    
    [mainScreenButtonImage release];
    [layoutImageView release];
    [buttonTitleLabel release];
    ///-----------
    switch (self.tag) {
        case first:
#if defined HOTEL_VERSION

            [layoutImageView setImage:[UIImage imageNamed:MyMenuLeftButtonOverlay]]; //set images instead
            [mainScreenButtonImage setImage:[UIImage imageNamed:Hotel_MyHotel_Icon]];
            [buttonTitleLabel setText:RSMyHotelTabTitle];
#endif
#if defined CLUB_VERSION
            [layoutImageView setImage:[UIImage imageNamed:MyMenuLeftButtonOverlay]]; //set images instead
            [mainScreenButtonImage setImage:[UIImage imageNamed:Club_MyClub_Icon]];
            [buttonTitleLabel setText:RSMyClubTabTitle];
#endif           
            break;
        case second:
            #if defined ALL_VERSION_SECONDSTATIC_MYACCOUNT
            [layoutImageView setImage:[UIImage imageNamed:MyMenuMidButtonOverlay]]; //set images instead
            [mainScreenButtonImage setImage:[UIImage imageNamed:Club_MyItinerary_Icon]];
            [buttonTitleLabel setText:RSStaticTabTitle];
            #else
             #if !defined HOTEL_VERSION_TWO_BUTTON
            [layoutImageView setImage:[UIImage imageNamed:MyMenuMidButtonOverlay]]; //set images instead
            [mainScreenButtonImage setImage:[UIImage imageNamed:Hotel_MyItinerary_Icon]];
            [buttonTitleLabel setText:MyItitnerary_ViewTite];
            #else
            [layoutImageView setImage:[UIImage imageNamed:MyMenuRightButtonOverlay]]; //set images instead
            [mainScreenButtonImage setImage:[UIImage imageNamed:Club_MyItinerary_Icon]];
            [buttonTitleLabel setText:MyItitnerary_ViewTite];
            #endif
            #endif
            
            break;
        case third:
#if defined HOTEL_VERSION
    #if defined All_VERSION_SECOND_STATIC
            [layoutImageView setImage:[UIImage imageNamed:MyMenuRightButtonOverlay]]; //set images instead
            [mainScreenButtonImage setImage:[UIImage imageNamed:Hotel_MyGroup_Icon]];
            [buttonTitleLabel setText:RSStaticTabTitle];
            break;
    #else   
            [layoutImageView setImage:[UIImage imageNamed:MyMenuRightButtonOverlay]]; //set images instead
            [mainScreenButtonImage setImage:[UIImage imageNamed:Hotel_MyGroup_Icon]];
            [buttonTitleLabel setText:MyGroup_ViewTilte];
            break;
    #endif
#endif
#if defined CLUB_VERSION
            [layoutImageView setImage:[UIImage imageNamed:MyMenuRightButtonOverlay]]; //set images instead
            [mainScreenButtonImage setImage:[UIImage imageNamed:Club_MyAccount_Icon]];
            [buttonTitleLabel setText:MyAccount_ViewTilte];
            break;
#endif
    
        default:
            break;
    }

}

-(void)setUpbutton
{
    
}
@end

