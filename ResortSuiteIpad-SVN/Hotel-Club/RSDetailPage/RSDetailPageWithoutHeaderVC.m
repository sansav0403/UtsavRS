//
//  RSDetailPageWithoutHeaderVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 4/19/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSDetailPageWithoutHeaderVC.h"
#import "RSAlertView.h"
#import "URLCaching.h"
#import "NetworkStatusManager.h"
@implementation RSDetailPageWithoutHeaderVC
@synthesize contentView;
@synthesize content;
@synthesize viewTitle;

//OceanSuiteHeader.jpg
- (void)dealloc
{
    contentView.delegate = nil;
    [contentView release];
    [content release];
    [viewTitle release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil 
			   bundle:(NSBundle *)nibBundleOrNil 
			viewTitle:(NSString *) viewtitle 
			  content:(NSString *) contentString {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
        // Custom initialization.
		self.viewTitle = viewtitle;

		self.content = contentString;
	}
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.title = self.viewTitle;
    
    [self.contentView setOpaque:NO];
    UIScrollView *scrollView = [contentView.subviews objectAtIndex:0];
    scrollView.bounces = NO;    //set the bouncing of the webView
    
    NSString *path = [[NSBundle mainBundle] pathForResource:self.content ofType:nil];
	
	if (path !=nil) //It will display static content
	{
		NSURL *url = [NSURL fileURLWithPath:path];
		NSURLRequest *request = [NSURLRequest requestWithURL:url];
		[contentView loadRequest:request];
	}
	else  //It will display Web page
	{
		URLCaching *urlCache = [URLCaching instance];
		
		NSString *fileString = [[[NSString alloc] init] autorelease];
		NetworkStatusManager *networkmanager = [NetworkStatusManager networkStatusManager];
		if (networkmanager.isConnectedToInternet) {
			NSURL *url = [NSURL URLWithString:self.content];
			NSURLRequest *request = [NSURLRequest requestWithURL:url];
			[contentView loadRequest:request];
			
			BOOL isFileCached = [urlCache addRemoteFileToCache:self.content withString:fileString];
			if(isFileCached)
			{
				DLog(@"File Cached");
			}
		}
		else {			
			if ([urlCache isRemoteFileCached:self.content]) {
				fileString = [urlCache getCachedRemoteFile:self.content];
				[contentView loadHTMLString:fileString baseURL:nil];
			}
//			else {//always display message incase netowrk is not available
				UIAlertView *errorAlert = [[UIAlertView alloc]
										   initWithTitle:POPUP_Error
										   message:POPUP_No_Network
										   delegate:nil
										   cancelButtonTitle:POPUP_Button_Ok
										   otherButtonTitles:nil];
				[errorAlert show];
				[errorAlert release];
//			}	
		}
	}
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    contentView.delegate = nil;
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}
#pragma mark Web view delegates

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
	
	//CAPTURE USER LINK-CLICK.
	if (navigationType == UIWebViewNavigationTypeLinkClicked) {
		NSURL *URL = [request URL];   
		if ([[URL scheme] isEqualToString:@"http"] || [[URL scheme] isEqualToString:@"https"] || [[URL scheme] isEqualToString:@"mailto"]) {
			[[UIApplication sharedApplication] openURL:URL];
			return NO;
		}
	}        
	return YES;  
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
	DLog(@"webViewDidStartLoad");
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    
//	self.navigationController.navigationBar.userInteractionEnabled = NO;
    [self startLoadingAnimation];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	DLog(@"webViewDidFinishLoad");
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
	
	self.navigationController.navigationBar.userInteractionEnabled = YES;
    [self stopLoadingAnimation];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self stopLoadingAnimation];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	self.navigationController.navigationBar.userInteractionEnabled = YES;
    //show error message if loading failed
    RSAlertView *rsAlertView = [[RSAlertView alloc]initWithTitle:POPUP_Error andMessage:POPUP_No_Network withDelegate:nil cancelButttonTitle:POPUP_Button_Ok otherButtonTitle:nil];
    [rsAlertView release];
    
}

@end
