//
//  RSMGEventDescVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/24/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSMGEventDescVC.h"

@implementation RSMGEventDescVC

@synthesize event;

@synthesize EventNameLbl;
@synthesize EventLocationLbl;
@synthesize EventDateLbl;
@synthesize EventTimeLbl;
@synthesize EventDescLbl;
@synthesize dotLine;
-(void)dealloc
{
    [event release];
    [EventDescLbl release];
    [EventDateLbl release];
    [EventTimeLbl release];
    [EventLocationLbl release];
    [EventNameLbl release];
    [dotLine release];
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
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil WithGroupEvent:(GroupEvent *)eventObject
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.event = eventObject;
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
    [self setTitle:[NSString stringWithFormat:@" %@",event.eventName]];
    // Do any additional setup after loading the view from its nib.
 ///------event date and time label settings---------------   
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
	NSDate *detailedDate = [event formatedStartTime];
	[dateFormat setDateFormat:hh_mm_aFormat];
	NSString* startTime = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:detailedDate]];
    
    detailedDate = [event formatedEndTime];
    
    EventTimeLbl.text = [NSString stringWithFormat:@" %@ - %@",startTime,[dateFormat stringFromDate:detailedDate]];
   

    detailedDate = [event formatedStartTime];
	[dateFormat setDateFormat:EEEE_MMMM_d_yyyyFormat];
	startTime = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:detailedDate]];
	EventDateLbl.text = [NSString stringWithFormat:@" %@",startTime];
	 
    [dateFormat release];
	

    
    // event name and locations and desc---
    EventNameLbl.text = [NSString stringWithFormat:@" %@",event.eventName];
    
    if (event.location == NULL) {
		EventLocationLbl.text =	[NSString stringWithFormat:@" "];
	}
	else {
		EventLocationLbl.text = [NSString stringWithFormat:@" %@",event.location];
	}

    EventDescLbl.text = [NSString stringWithFormat:@"%@",event.eventDesc];	
    
    dotLine.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:SeparatorImage]];
	dotLine.opaque = YES;
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
