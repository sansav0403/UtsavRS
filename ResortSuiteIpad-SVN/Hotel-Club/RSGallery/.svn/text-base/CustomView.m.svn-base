//
//  CustomView.m
//  Resort-Suite
//
//  Created by Cybage on 01/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "CustomView.h"
#import "StoreImageObj.h"
#import "RSAppDelegate.h"
@implementation CustomView

#define ImageViewWidth                      141
#define ImageViewHeight                     141
#define XDistanceBetweenImage               8
#define XDistanceBetweenImageInLand               15
#define YDistanceBetweenImage               8
#define YDistanceBetweenImageInLand               15
#define NoOfImagePerRowInPotrait            5
#define NoOfImagePerRowInLandscape          6

@synthesize imageArray,delegate,arrayOfImageView;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		arrayOfImageView = [[NSMutableArray alloc]init];
		
		for (int imageIndex = 0; imageIndex < [imageArray count] ; imageIndex++) {
			CustomImageView *imageView = [[CustomImageView alloc]initWithFrame:CGRectZero];
			
			UIImage *image = [UIImage imageNamed:[[imageArray objectAtIndex:imageIndex] imageName]];
			[imageView setImage:image];
			
			[imageView setIndex:imageIndex];
			[imageView setUserInteractionEnabled:YES];
			[imageView setDelegate:self];
			[self addSubview:imageView];
			
			[arrayOfImageView addObject:imageView];
			[imageView release];
		}
    }

    return self;
}


-(void)layoutSubviews
{
	int x ,y ,index = 0,count = [arrayOfImageView count],row = 1;
	
	for (int imageCount = 1; (index < count); imageCount++) 
	{
		UIImageView * view = [arrayOfImageView	objectAtIndex:index];
        
        RSAppDelegate *appdelegate = (RSAppDelegate *)[[UIApplication sharedApplication]delegate];
        
        if (appdelegate.currentOrientation == potrait) {
            
		
		x = (XDistanceBetweenImage*(imageCount -1) + ImageViewWidth*(imageCount -1));
		
		y =  (YDistanceBetweenImage *(row -1) + ImageViewHeight * (row -1));
		
		CGRect frame = CGRectMake(x+XDistanceBetweenImage, y+YDistanceBetweenImage, ImageViewWidth, ImageViewHeight);
		[view setFrame:frame];
		index++;
            if (imageCount==NoOfImagePerRowInPotrait) {
                
                row++;	//to set y
                imageCount=0;	//to set x
            }
        }
        if (appdelegate.currentOrientation == landscape) {
            
                
                x = (XDistanceBetweenImageInLand*(imageCount -1) + ImageViewWidth*(imageCount -1));
                
                y =  (YDistanceBetweenImageInLand *(row -1) + ImageViewHeight * (row -1));
                
                CGRect frame = CGRectMake(x+XDistanceBetweenImageInLand, y+YDistanceBetweenImageInLand, ImageViewWidth, ImageViewHeight);
                [view setFrame:frame];
                index++;
            if (imageCount==NoOfImagePerRowInLandscape) {
                row++;	//to set y
                imageCount=0;	//to set x
            }
        }
	
	}
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/
#pragma mark imageTouchedDelegate
-(void)imageTouchedAtIndex:(int)index
{
	if (delegate) {
		[delegate imageTouchedAtIndexInfo:index];
	}
}
- (void)dealloc {
    [super dealloc];
	[imageArray release];
	[arrayOfImageView release];
}


@end
