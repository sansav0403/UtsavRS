//
//  RSConfirmationBaseClass.m
//  ResortSuite
//
//  Created by Cybage on 9/20/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//

#import "RSConfirmationBaseClass.h"
#import "DateManager.h"
#define CharWidth 7
//confirmationBaseClass macros

#define RSCBCTiltleYcord_new                                5
#define RSCBCTiltleLabelFont_new                            17

#define RSCBCMessageXcord_new                               15
#define RSCBCMessageYcord_new                               47
#define RSCBCMessageLabelWidth_new                          300

#define RSCBCMessageLabelFont_new                           16//13
#define RSCBCMessageLabelhieght_new                         20

#define RSCBDynamicLabelXcord_new                           220
#define RSCBDynamicLabelWidth_new                           (Screen_Width - RSCBDynamicLabelXcord_new - 10)
#define RSCBDynamicLabelFont_new                            16//14

#define TitleHeaderYcord_new                                45
#define sepratorImageYcord_new                              80
#define scrollViewHeight_new                                455

#define actionButtonYcord_new                               459//(scrollViewHeight + 90)

#define actionButtonXcord_new                               241
#define actionButtonWidth_new                               296
#define actionButtonHeight_new                              45

//Profile label cords
#define titleLabelCord_x_new                                0
#define titleLabelCord_y_new                                45
#define titleLabelCord_width_new                            320
#define titleLabelCord_height_new                           35

#define Y_diff_new                                          20
#define X_diff_new                                          80
#define Label1Cord_x_new									35//15
#define LabelCord_y_new                                     85 + (labelIndex*Y_diff_new)
#define LabelCord_width_new                                 130
#define LabelCord_height_new                                20
#define LabelCord_TwoLinesDifference_new                    46


#define Label2Cord_x_new                                    160
#define ScrollLabel_YCord_new								44
#define ScrollLabel_Width_new								(Screen_Width - Label2Cord_x_new - 10)
#define label2ycord                                          5

#define SeperatorImageWidth   700
#define SeperatorImageHeight  1

#define Label2YcordValueForSetScrolling  200
#define Label2YcordOffsetValueForSetScrolling  50

#define seperatorlabelXOffset   40
@implementation RSConfirmationBaseClass

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
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
    
//    [ResortSuiteAppDelegate setCurrentScreenImageWithWhiteOverlay:Application_BackgroundScreen controller:self];
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, sepratorImageYcord, Screen_Width, scrollViewHeight_new)];
    [scrollView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:scrollView];
    [scrollView release];
    
    label2Y_cord = label2ycord;      //releative to new scroll view
    valForClassOrService = DefaultValue; // DEFAULT VALUE
    
    //Add Book Now button
	bookButton = [[UIButton alloc] initWithFrame:CGRectMake(actionButtonXcord_new, actionButtonYcord_new, actionButtonWidth_new, actionButtonHeight_new)];
	[bookButton setBackgroundColor:[UIColor clearColor]];	
    UIImage *disabledBtnImage = [UIImage imageNamed:Disabled_Book_button];
    UIImage *enabledBtnImage = [UIImage imageNamed:Enabled_Book_button];
    
    [bookButton setBackgroundImage:disabledBtnImage forState:UIControlStateDisabled];
    [bookButton setBackgroundImage:enabledBtnImage forState:UIControlStateNormal];
	
    [bookButton addTarget:self action:@selector(bookAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bookButton];	
    [bookButton release];

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
    return [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];

}


#pragma mark - label cofigaration functions

-(CGFloat) calculateWidthForlabel:(NSString *)comments forFontSize:(float)fontsize
{
    int stringlenght = [comments length];
    float ReqCGWidth = stringlenght * CharWidth;         //pixel width of each char for 

    
    CGSize sizetest = [comments sizeWithFont:[UIFont systemFontOfSize:fontsize] forWidth:ReqCGWidth lineBreakMode:UILineBreakModeCharacterWrap];
    
    return sizetest.width;
}

-(int)calculateNoOfLinesForLineWidth:(CGFloat)lineWidth forLabelWidth:(float)labelWidth
{
	//assuming the label width to be 130
    int numLines = 1;
	if(lineWidth/RSCBDynamicLabelWidth_new > numLines) 
	{
        numLines = ceilf(lineWidth/RSCBDynamicLabelWidth_new);
	}
    return numLines;
}

-(CGFloat)calculateNextY_CordFromPreviousY_cord:(float)y_cord andNumOfLine:(int)noOfLine
{
	return y_cord + ((noOfLine) * LabelCord_height_new);
}

-(void) createDescriptionBody:(NSArray*)tagsTitle dataArray:(NSArray*)tagsValue
{
	for (int titleIndex = 0; titleIndex < [tagsTitle count]; titleIndex++)
	{
		UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectZero]; //
		UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectZero];
		
		label1.backgroundColor = [UIColor clearColor];
		label1.opaque = YES;
		label1.textColor = [UIColor blackColor];
        
		[label1 setFont:[UIFont boldSystemFontOfSize:FontOfSize16]];
		
		if ([tagsTitle objectAtIndex:titleIndex] != nil)
		{
			[label1 setText:[tagsTitle objectAtIndex:titleIndex]];
			
			if (titleIndex == IndexForFirstTitle) {
                //Label1Cord_y dont need to use it as now we are addin them to scrool view
				label1.frame = CGRectMake(Label1Cord_x_new, label2Y_cord, ScrollLabel_Width_new, LabelCord_height_new);	
			}
			else {
				label1.frame = CGRectMake(Label1Cord_x_new, label2Y_cord + titleIndex* (LabelCord_TwoLinesDifference_new - LabelCord_height_new), ScrollLabel_Width_new, LabelCord_height_new);
                ///-----
                if (valForClassOrService == instructionForSpa) {        //for spa Service   valForClassOrService = 0 by default
                    if (titleIndex == instructionIndexForSpa) {
                        label1.textColor = [UIColor redColor];
                        
                        label1.numberOfLines = 1;
                        label1.frame = CGRectMake(Label1Cord_x_new, label2Y_cord + titleIndex* (LabelCord_TwoLinesDifference_new - LabelCord_height_new), ScrollLabel_Width_new, LabelCord_height_new);
                    }
                }
                else if(valForClassOrService == instructionForClass) {    //for class
                    if (titleIndex == instructionIndexForClass) {
                        label1.textColor = [UIColor redColor];
                        
                        label1.numberOfLines = 1;
                        label1.frame = CGRectMake(Label1Cord_x_new, label2Y_cord + titleIndex* (LabelCord_TwoLinesDifference_new - LabelCord_height_new), ScrollLabel_Width_new, LabelCord_height_new);
                    }
                }
                ///-----
			}
			
		}
		else 
		{
			[label1 setText:DataNotAvailable];
			if (titleIndex == IndexForFirstTitle) {
				label1.frame = CGRectMake(Label1Cord_x_new, label2Y_cord, ScrollLabel_Width_new, LabelCord_height_new);
			}
			else {
				label1.frame = CGRectMake(Label1Cord_x_new, label2Y_cord + titleIndex*(LabelCord_TwoLinesDifference_new - LabelCord_height_new), ScrollLabel_Width_new, LabelCord_height_new);
			}
			
		}
		// work for dynamic label--- label2
		label2.backgroundColor = [UIColor clearColor];
		label2.opaque = YES;
		label2.textColor = [UIColor blackColor];
        ///-----
        if (valForClassOrService == instructionForSpa) {        //for spa Service
            if (titleIndex == instructionIndexForSpa) {
                label2.textColor = [UIColor redColor];
            }
        }
        else if(valForClassOrService == instructionForClass) {    //for class
            if (titleIndex == instructionIndexForClass) {
                label2.textColor = [UIColor redColor];                
            }
        }
        ///-----
		[label2 setFont:[UIFont systemFontOfSize:FontOfSize16]];
		
		if (titleIndex < [tagsValue count] && [tagsValue objectAtIndex:titleIndex] != nil)
		{

            int numOfLine = [self calculateNoOfLinesForLineWidth:[self calculateWidthForlabel:[tagsValue objectAtIndex:titleIndex]forFontSize:RSCBDynamicLabelFont_new] forLabelWidth:RSCBDynamicLabelWidth_new];
			
            label2.lineBreakMode = UILineBreakModeWordWrap;
            label2.numberOfLines = 0;

			if (titleIndex == IndexForFirstTitle) {
				label2.frame = CGRectMake(RSCBDynamicLabelXcord_new, label2Y_cord, RSCBDynamicLabelWidth_new, LabelCord_height_new*numOfLine);
				
			}
			else {
				label2.frame = CGRectMake(RSCBDynamicLabelXcord_new, label2Y_cord + titleIndex*(LabelCord_TwoLinesDifference_new - LabelCord_height_new), RSCBDynamicLabelWidth_new, LabelCord_height_new*numOfLine);
                
			}
			
            [label2 setText:[tagsValue objectAtIndex:titleIndex]];
            
            //set the next y cord
            label2Y_cord = [self calculateNextY_CordFromPreviousY_cord:label2Y_cord andNumOfLine:numOfLine];
		}
		else 
		{
            
            int numOfLine = [self calculateNoOfLinesForLineWidth:[self calculateWidthForlabel:DataNotAvailable forFontSize:RSCBDynamicLabelFont_new] forLabelWidth:RSCBDynamicLabelWidth_new];
            
			if (titleIndex == IndexForFirstTitle) {
				label2.frame = CGRectMake(RSCBDynamicLabelXcord_new, label2Y_cord, RSCBDynamicLabelWidth_new, LabelCord_height_new*numOfLine);
				
			}
			else {
				label2.frame = CGRectMake(RSCBDynamicLabelXcord_new, label2Y_cord + titleIndex*(LabelCord_TwoLinesDifference_new - LabelCord_height_new), RSCBDynamicLabelWidth_new, LabelCord_height_new*numOfLine);
                
			}
            [label2 setText:DataNotAvailable];
            //set the next y cord
            label2Y_cord = [self calculateNextY_CordFromPreviousY_cord:label2Y_cord andNumOfLine:numOfLine];
			
		}
		
		[scrollView addSubview:label1];
		[scrollView addSubview:label2];		
        
        if (label2Y_cord > Label2YcordValueForSetScrolling) {       //new set up to enable scrolling
            [scrollView setContentSize:CGSizeMake(Screen_Width, label2Y_cord+Label2YcordOffsetValueForSetScrolling)];
        }
		
		[label1 release];
		[label2	 release];
		
	}
}


#pragma mark - draw header level

-(void) createTitleHeader:(NSString*)headerTitle yPosition:(float)yCoordinate
{
    
	UILabel *tLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabelCord_x_new, yCoordinate, titleLabelCord_width_new, titleLabelCord_height_new)];
	tLabel.backgroundColor = [UIColor whiteColor];
	tLabel.opaque = YES;
	tLabel.textColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0];
	[tLabel setFont:[UIFont boldSystemFontOfSize:FontOfSize17]];
	[tLabel setText:[NSString stringWithFormat:@"           %@", headerTitle]];
	[self.view addSubview:tLabel];
	[tLabel release];
	
}


-(void)drawSeperatorImageAtYCord:(float)ycord 
{

    UILabel *seperatorLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabelCord_x_new+seperatorlabelXOffset,  ycord, SeperatorImageWidth, SeperatorImageHeight)];
    [seperatorLabel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:SeparatorImage]]];
    [self.view addSubview:seperatorLabel];
    [seperatorLabel release];
}

-(void) createMessage:(NSString *)messageString yPostion:(float)yCoordinate
{
    
    int numOfLine = [self calculateNoOfLinesForLineWidth:[self calculateWidthForlabel:messageString forFontSize:RSCBCMessageLabelFont_new]forLabelWidth:RSCBCMessageLabelWidth_new];
    
    UILabel *mLabel = [[UILabel alloc]initWithFrame:CGRectMake(RSCBCMessageXcord_new, yCoordinate, RSCBCMessageLabelWidth_new, RSCBCMessageLabelhieght_new * numOfLine)];
    
	mLabel.backgroundColor = [UIColor clearColor];
	mLabel.opaque = YES;
	mLabel.textColor = [UIColor blackColor];
    mLabel.lineBreakMode = UILineBreakModeWordWrap;
    mLabel.numberOfLines = 0;
	[mLabel setFont:[UIFont boldSystemFontOfSize:FontOfSize16]];
	[mLabel setText:[NSString stringWithFormat:@"%@", messageString]];
	[scrollView addSubview:mLabel];
	[mLabel release];
    
    label2Y_cord = [self calculateNextY_CordFromPreviousY_cord:yCoordinate andNumOfLine:numOfLine];
}

#pragma mark - date functions
-(NSString *)stringFromDate:(NSDate *)date                  //date without time value
{
        NSString * dateStr = [DateManager stringFromDate:date withDateFormat:MMMM_d_YYYYFormat];
    return dateStr;
}

-(NSString *)timeStringFromDate:(NSDate *)date                  //date without time value
{
    NSString * dateStr = [DateManager stringFromDate:date withDateFormat:hh_mm_aFormat];
    return dateStr;
}
@end
