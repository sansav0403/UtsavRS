//
//  RSStaticNodeVC.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/16/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseListViewController.h"
@class RSListViewNode;
@interface RSStaticNodeVC : BaseListViewController 
{

	NSString        *viewTitle;
	NSString        *headerImage;
	NSArray         *dictionaryArray;
	
    
}
@property (nonatomic,copy) NSString     *viewTitle;
@property (nonatomic,copy) NSString     *headerImage;
@property (nonatomic,retain) NSArray    *dictionaryArray;

/*!
 @method		initViewWithNode
 @brief		    Initialize title, value of thumbnail and header image.
 @details		
 @param			(RSListViewNode *)node
 @return		id
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withNode:(RSListViewNode *)node;
@end
