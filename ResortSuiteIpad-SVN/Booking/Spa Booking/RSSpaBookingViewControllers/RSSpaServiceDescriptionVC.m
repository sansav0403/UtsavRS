//
//  RSSpaServiceDescriptionVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/5/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSSpaServiceDescriptionVC.h"
#import "RSSelectedSpaLocation.h"
#import "RSAppDelegate.h"
@implementation RSSpaServiceDescriptionVC
@synthesize selectedService;
#define IndexForSpaInstruction      4
- (void)dealloc
{
    [selectedService release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithSelectedService:(RSSpaService *)selSerivce
{
//    self = [super init];
    self = [super initWithNibName:@"RSConfirmationBaseClass" bundle:[NSBundle mainBundle]];
    if (self) {
        self.selectedService = selSerivce;
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
    valForClassOrService = instructionForSpa;       //one for spaService
    
    RSSelectedSpaLocation *location = [RSSelectedSpaLocation sharedInstance];
    
    [self setTitle:[NSString stringWithFormat:@"%@ %@",kBook_Title,location.spaLocation.locationName]];
    
    [self createTitleHeader:SpaBookingFormService yPosition:TitleHeaderYcord];
    
    [self drawSeperatorImageAtYCord:sepratorImageYcord - dot_height];
    
    //generate the array of the static label text and the dynamioc label text    
    NSMutableArray *staticLabelTexts = [[[NSMutableArray alloc]initWithObjects:DescServiceText,DescDescriptionText,DescDurationText,DescPriceText, DescClientInstruction, nil]autorelease]; // new addition @"client Instruction :"
    
    NSMutableString *descString = [NSMutableString stringWithFormat:@"%@",selectedService.itemDesc];
    
    if ([descString isEqualToString:@""])
    {
        [descString setString:DataNotAvailable];
    }
    
    NSMutableString *instructionString = [NSMutableString stringWithFormat:@"%@",selectedService.clientInstruction];
    
    
    
    NSMutableArray *DynamicLabelTexts = [[[NSMutableArray alloc]initWithObjects:
                                          selectedService.itemName,
                                          descString,
                                          [NSString stringWithFormat:@"%d", selectedService.serviceTime],
                                          [NSString stringWithFormat:@"%.02f", selectedService.price],
                                          instructionString,
                                          nil
                                          ] autorelease];
    if ([instructionString isEqualToString:@""])
    {
        [staticLabelTexts removeObjectAtIndex:IndexForSpaInstruction];
        [DynamicLabelTexts removeObjectAtIndex:IndexForSpaInstruction];
    }
    
    [self createDescriptionBody:staticLabelTexts dataArray:DynamicLabelTexts];
    
    [self UpdateSelectButton];   //update the button image for this class
}

-(void)UpdateSelectButton
{
    UIImage *disabledBtnImage = [UIImage imageNamed:kDisabled_Button_img];
    UIImage *enabledBtnImage = [UIImage imageNamed:kEnabled_Button_img];
    
    [bookButton setBackgroundImage:disabledBtnImage forState:UIControlStateDisabled];
    [bookButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    [bookButton setBackgroundImage:enabledBtnImage forState:UIControlStateNormal];
    [bookButton setTitle:kSelect_Title forState:UIControlStateNormal];
    [bookButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bookButton.titleLabel setFont:[UIFont boldSystemFontOfSize:kLabelTextFontSize]];
    [bookButton titleLabel].shadowOffset = CGSizeMake(0, 1);
    
}
-(void)bookAction:(id) sender
{
    DLog(@"take select action");
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"spaServiceSelected" object:selectedService];    //send the object as notification obj
    
    RSAppDelegate *appDelegate = (RSAppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.selectedLocBookingType == ALL) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:BOOK_SERVICE_PAGE_CONTROLLER_COUNT_FOR_ALL] animated:YES];
    }
    else if (appDelegate.selectedLocBookingType == SINGLE)
    {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:BOOK_SERVICE_PAGE_CONTROLLER_COUNT_FOR_CLASSORSERVICE] animated:YES];
    }
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
