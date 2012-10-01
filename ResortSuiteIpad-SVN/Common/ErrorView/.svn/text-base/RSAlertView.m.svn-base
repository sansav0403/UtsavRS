//
//  RSAlertView.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 4/18/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSAlertView.h"

@implementation RSAlertView

- (void)dealloc
{
    [super dealloc];
}
- (id)initWithTitle:(NSString *)title andMessage:(NSString *)message withDelegate:(id)delegate cancelButttonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle
{
    self = [super init];
    if (self) {
        alertView = [[UIAlertView alloc]
                                   initWithTitle:title
                                   message:message
                                   delegate:delegate
                                   cancelButtonTitle:cancelButtonTitle
                                   otherButtonTitles:otherButtonTitle,nil];
        [alertView show];
        [alertView release];

    }
    return self;
}


@end
