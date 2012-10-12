//
//  RSSpaClassDescriptionVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/5/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSSpaClassDescriptionVC.h"
#import "RSSelectedSpaLocation.h"
#import "RSAppDelegate.h"

@implementation RSSpaClassDescriptionVC
#define instructionLblIndex 6
@synthesize selectedClass;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithSelectedClass:(RSSpaClass *)selClass
{
//    self = [super init];
    self = [super initWithNibName:@"RSConfirmationBaseClass" bundle:[NSBundle mainBundle]];
    if (self) {
        self.selectedClass = selClass;
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
    valForClassOrService = instructionForClass;       //one for spaService
    
     RSSelectedSpaLocation *location = [RSSelectedSpaLocation sharedInstance];
    [self setTitle:[NSString stringWithFormat:@"%@ %@",kBook_Title,location.spaLocation.locationName]];
    
    [self createTitleHeader:ClassActivityCellText yPosition:TitleHeaderYcord];  
    
    [self drawSeperatorImageAtYCord:sepratorImageYcord - dot_height];
    
    //generate the array of the static label text and the dynamic label text
    
    NSMutableArray *staticLabelTexts = [[[NSMutableArray alloc]initWithObjects:DescClass_activityText,DescDescriptionText, DescNoOfClassText,DescStartTimeText, DescDurationText,DescPriceText,DescClientInstruction, nil]autorelease];
    
    NSMutableString *descString = [NSMutableString stringWithFormat:@"%@",selectedClass.itemDescription]; //autoreleased
	if ([descString isEqualToString:@""])
    {
        [descString setString:DataNotAvailable];
    }
    
    NSMutableString *instructionString = [NSMutableString stringWithFormat:@"%@",selectedClass.clientInstruction];  //autoreleased
    
	
    NSMutableArray *DynamicLabelTexts = [[[NSMutableArray alloc]initWithObjects:
                                          selectedClass.spaItemName,
                                          descString,//selectedClass.itemDescription
                                          [NSString stringWithFormat:@"%d", selectedClass.numClasses],
                                          [self getDateTimeFromString:selectedClass.startTime format:@"Time"],
                                          
                                          [NSString stringWithFormat:@"%.0f", selectedClass.serviceTime],
                                          [NSString stringWithFormat:@"%.02f", selectedClass.price],
                                          instructionString,
                                          nil
                                          ] autorelease];
   	if ([instructionString isEqualToString:@""])
    {
        [staticLabelTexts removeObjectAtIndex:instructionLblIndex];
        [DynamicLabelTexts removeObjectAtIndex:instructionLblIndex];
    }
    [self createDescriptionBody:staticLabelTexts dataArray:DynamicLabelTexts];

    [self updateActionButton];
}

-(void)updateActionButton
{
    [bookButton setBackgroundColor:[UIColor clearColor]];	
    
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

    RSAppDelegate *appDelegate = (RSAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"spaClassSelected" object:self.selectedClass];
	//Navigate to the Date selection view
    
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


#pragma mark Date formatting
-(NSString *) getDateTimeFromString:(NSString *) dateString format:(NSString *) dateOrTime
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
	[dateFormatter setDateFormat:MMMM_dd_yyyy_hh_mm_aFormat];	
	
	NSDate *startTime = nil;
	
	if([dateOrTime isEqualToString:@"Time"])
	{
		startTime = (NSDate *) [dateFormatter dateFromString:dateString];
		[dateFormatter setDateFormat:hh_mm_aFormat];
	}
	else if([dateOrTime isEqualToString:@"Date"])
	{
		startTime = (NSDate *) [dateFormatter dateFromString:dateString];
		[dateFormatter setDateFormat:MMMM_dd_yyyyFormat];
	}			 
	
	NSString *startDateOrTime = [dateFormatter stringFromDate:startTime];
	[dateFormatter release];
	
	return startDateOrTime;
}
@end
