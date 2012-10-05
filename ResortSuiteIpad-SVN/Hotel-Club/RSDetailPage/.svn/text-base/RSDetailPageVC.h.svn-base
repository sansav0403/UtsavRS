//
//  RSDetailPageVC.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/21/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSDetailPageVC : BaseViewController<UIWebViewDelegate>
{

	NSString    *viewTitle;
	NSString    *headerImage;
}
@property (nonatomic,copy) NSString                 *viewTitle;
@property (nonatomic,copy) NSString                 *headerImage;

@property (nonatomic, retain) IBOutlet UIImageView  *headerImageView;
@property (nonatomic, retain) IBOutlet UIImageView  *headerOverlayImageView;
@property (nonatomic, retain)IBOutlet UIWebView     *contentView;
@property (nonatomic, copy) NSString                *content;

- (id)initWithNibName:(NSString *)nibNameOrNil 
			   bundle:(NSBundle *)nibBundleOrNil 
			viewTitle:(NSString *) viewtitle 
			viewImage:(NSString *) viewimage 
			  content:(NSString *) contentString;
@end
