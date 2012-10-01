//
//  RSSpaClassCategoryVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/29/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSSpaClassCategoryVC.h"
#import "RSSpaClass.h"
#import "RSSelectedSpaLocation.h"
#import "RSClassServiceTableVC.h"
@implementation RSSpaClassCategoryVC

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    RSSelectedSpaLocation *location = [RSSelectedSpaLocation sharedInstance];
    
    self.title = [NSString stringWithFormat:@"Book %@",location.spaLocation.locationName];
    //
    NSString *titeString = [NSString stringWithFormat:@"Select the %@ category",location.spaLocation.locationName];
    
	//funtin base call in sub
    self.instructionLbl.text  = titeString;
    self.instructionLbl.backgroundColor = [UIColor whiteColor];
	self.instructionLbl.opaque = YES;
	self.instructionLbl.textColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0];
	[self.instructionLbl setFont:[UIFont boldSystemFontOfSize:FontOfSize17]];
    
    [self.selectButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)selectAction:(id)sender
{
    DLog(@"select action");
    UIButton *selectedButton = (UIButton *)sender;
    RSClassServiceTableVC *spaClassTableVC;
    
    spaClassTableVC = [[RSClassServiceTableVC alloc] initWithNibName:@"RSBaseSpaServiceTableVC" bundle:[NSBundle mainBundle] withSpaClassArray:[self.categoryDictionary objectForKey:[self.keyArray objectAtIndex:selectedButton.tag]] ];      
    
    [self.navigationController pushViewController:spaClassTableVC animated:YES];
    [spaClassTableVC release];
	
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
    [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];
	return YES;
}

@end
