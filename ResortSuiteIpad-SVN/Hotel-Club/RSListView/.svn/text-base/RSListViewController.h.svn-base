//
//  RSListViewController.h
//  ResortSuite
//
//  Created by Cybage on 27/07/11.
//  Copyright 2011 ResortSuite. All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
based on the tree, this class gets its information from the plist file
 *and generates the view from the information extracted from the view.
 
 ================================================================================
 */
#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@class RSTableView;
@class RSListViewNode;

@interface RSListViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource> {
	NSString * viewTitle;
	NSString * headerImage;
	NSArray * dictionaryArray;
	

}
@property (nonatomic,retain) NSString * viewTitle;
@property (nonatomic,retain) NSString * headerImage;
@property (nonatomic,retain) NSArray * dictionaryArray;

/*!
 @method		initViewWithNode
 @brief		    Initialize title, value of thumbnail and header image.
 @details		
 @param			(RSListViewNode *)node
 @return		id
 */
-(id)initViewWithNode:(RSListViewNode *)node;

@end
