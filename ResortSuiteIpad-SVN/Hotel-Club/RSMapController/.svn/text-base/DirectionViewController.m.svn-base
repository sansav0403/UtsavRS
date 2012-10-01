    //
//  DirectionViewController.m
//  ResortSuite
//
//  Created by Cybage on 14/06/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "DirectionViewController.h"


@implementation DirectionViewController
@synthesize contentView,content;

-(id)initWithContent:(NSString *)htmlContent
{
	self = [super initWithNibName:@"DirectionViewController" bundle:[NSBundle mainBundle]];
	if (self) {
		self.content = htmlContent;
		
	}
	return self;
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	

	contentView  = [[UIWebView alloc]initWithFrame:CGRectMake(0, NavigationBar_Height, Screen_Width, 400)];
	[self.view addSubview:contentView];
	[contentView release];
	
	//self.navigationItem.title = @"Directions";
	
	contentView.backgroundColor= [UIColor clearColor];
    [self.view bringSubviewToFront:contentView];
	[contentView setOpaque:NO];
	
	NSString *path = [[NSBundle mainBundle] pathForResource:self.content ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [contentView loadRequest:request];
	
    UIScrollView *scrollView = [contentView.subviews objectAtIndex:0];
    scrollView.bounces = NO;
	
}

-(void)mapButtonAction:(id) sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];

}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [content release];
	[super dealloc];
}


@end
