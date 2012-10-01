    //
//  RSSummaryPage.m
//  ResortSuite
//
//  Created by Cybage on 07/07/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSSummaryPage.h"
#import "RSMyAccountManager.h"

@implementation RSSummaryPage
@synthesize dynamicLabelText,viewtitle;
@synthesize accountDetailsTags, accountSummaryTags, balanceSummaryTags;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/
-(id)initWithTitle:(NSString *)vTitle 
{
	self.viewtitle = vTitle;
	
	return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.


- (void)viewDidLoad {
    [super viewDidLoad];
	
	// to make the page scroll able add scroll view
	scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, ScrollLabel_YCord, Screen_Width, Screen_Height-ScrollLabel_YCord - 70)];
	[scrollView setBackgroundColor:[UIColor clearColor]];
	[self.view addSubview:scrollView];
	[scrollView release];
	
//	[ResortSuiteAppDelegate setContactUsIcon:NO];
	label2Y_cord = ScrollLabel_YCord;
	
	[self generateAccountDetails];
	[self createSectionHeader:AccountSummaryDetailHeader yPosition:0];
	[self createDescriptionBody:self.accountDetailsTags dataArray:self.dynamicLabelText];
	[self displaySeperatorImage:label2Y_cord + ([self.accountDetailsTags count] )*(LabelCord_TwoLinesDifference - LabelCord_height)];

	//Account Summary
	label2Y_cord += [self.accountDetailsTags count]*(LabelCord_TwoLinesDifference - LabelCord_height);
	[self createSectionHeader:AccountSummaryHeader yPosition:label2Y_cord ];
	[self generateAccountSummary];
	
	//Aged Balance Summary
	label2Y_cord += [self.accountSummaryTags count]*(LabelCord_TwoLinesDifference - LabelCord_height);
	[self createSectionHeader:AccountAgedBalanceHeader yPosition:label2Y_cord ];
	[self generateAgedBalanceSummary];
	
	[scrollView setContentSize:CGSizeMake(Screen_Width, label2Y_cord + ([self.accountDetailsTags count] + [self.accountSummaryTags count] + [self.balanceSummaryTags count] - 6)*(LabelCord_TwoLinesDifference - LabelCord_height) )];	//label2Y_cord ll noew hold the latest y cord of the last label
}


-(void) generateAccountDetails
{
    NSArray *accountDetailTagArray = [[NSArray alloc]initWithObjects:AccountNumber,
    AccountType,
    AccountQwner,
    AccountMemberShipCount,
    AccountMemberShipID,
    AccountMemberShipLevel,
    nil];
    
	self.accountDetailsTags = accountDetailTagArray;
    [accountDetailTagArray release];
	
//	ResortSuiteAppDelegate *appDelegate = (ResortSuiteAppDelegate *)[[UIApplication sharedApplication] delegate];
    RSMyAccountManager *accountmanager = [RSMyAccountManager sharedInstance];
    
    NSArray *dynamicTextArray = [[NSArray alloc]initWithObjects:
                                 [[accountmanager.modelClubAccounts.accounts objectAtIndex:accountmanager.selectedAccountIndex] accountId],
                                 [[accountmanager.modelClubAccounts.accounts objectAtIndex:accountmanager.selectedAccountIndex] classType],
                                 [[accountmanager.modelClubAccounts.accounts objectAtIndex:accountmanager.selectedAccountIndex] statementCustomerName],
                                 
                                 accountmanager.selectedAccountstatement.stmtAccount.stmtAccCustomer.customerCode,
                                 accountmanager.selectedAccountstatement.stmtAccount.stmtAccCustomer.customerId,
                                 accountmanager.selectedAccountstatement.stmtAccount.stmtAccCustomer.VIPLevel,
                                 nil];
	self.dynamicLabelText= dynamicTextArray;
    [dynamicTextArray release];
	
}


-(void) generateAccountSummary
{
	
//	ResortSuiteAppDelegate *appDelegate = (ResortSuiteAppDelegate *)[[UIApplication sharedApplication] delegate];
     RSMyAccountManager *accountmanager = [RSMyAccountManager sharedInstance];
	NSArray *accountSummaryTagArray = [[NSArray alloc]initWithObjects:
                                       AccountStatementperiod,
                                       AccountpreviousBalance,
                                       AccountPayments,
                                       AccountNewCharges,
                                       AccountBalance,
                                       nil];
    self.accountSummaryTags = accountSummaryTagArray;
    [accountSummaryTagArray release];
	
	label2Y_cord += ([self.accountDetailsTags count] + 1)*(LabelCord_TwoLinesDifference - LabelCord_height)-60;//sub -60 edit
	
	NSString *statementPeriod;
	if (accountmanager.selectedAccountstatement.stmtAccount.stmtBillingPeriod.billDate!=nil) {
		statementPeriod = [NSString stringWithFormat:@"%@ - %@             ", accountmanager.selectedAccountstatement.stmtAccount.stmtBillingPeriod.periodStartDate,
						   accountmanager.selectedAccountstatement.stmtAccount.stmtBillingPeriod.billDate];
	}
	else
	{	
		statementPeriod = nil;
	}
	
	NSArray* membershipValue = [[NSArray alloc]initWithObjects:
								 statementPeriod,
								 accountmanager.selectedAccountstatement.stmtAccount.stmtBillingPeriod.previousBalance,								
								 accountmanager.selectedAccountstatement.stmtAccount.stmtBillingPeriod.payments,
								 accountmanager.selectedAccountstatement.stmtAccount.stmtBillingPeriod.charges,
								 accountmanager.selectedAccountstatement.stmtAccount.stmtBillingPeriod.accountBalance,
								nil];

	[self createDescriptionBody:self.accountSummaryTags dataArray:membershipValue];
	
	
	if (statementPeriod != nil) {
		[self displaySeperatorImage:label2Y_cord + ([membershipValue count] )*(LabelCord_TwoLinesDifference - LabelCord_height)];
	}
	else {
		[self displaySeperatorImage:label2Y_cord + ([membershipValue count] )*(LabelCord_TwoLinesDifference - LabelCord_height)+30];
	}
    
	[membershipValue release];
	
}

-(void) generateAgedBalanceSummary
{
//	ResortSuiteAppDelegate *appDelegate = (ResortSuiteAppDelegate *)[[UIApplication sharedApplication] delegate];
      RSMyAccountManager *accountmanager = [RSMyAccountManager sharedInstance];
	NSArray *balanceSummaryArray = [[NSArray alloc]initWithObjects:
									AccountCurrentBalance,
									AccountCurrent30dayBalance,
									AccountCurrent60dayBalance,
									AccountCurrent90dayBalance,
									nil];
    self.balanceSummaryTags = balanceSummaryArray;
    [balanceSummaryArray release];
	
	label2Y_cord += [self.accountSummaryTags count]*(LabelCord_TwoLinesDifference - LabelCord_height) + 15-50;//sub -50 edit
	
	NSArray* accountCustomerValue = [[NSArray alloc]initWithObjects:
									 accountmanager.selectedAccountstatement.stmtAccount.stmtBillingPeriod.currentBalance,
									 accountmanager.selectedAccountstatement.stmtAccount.stmtBillingPeriod.thirtyDayBalance,
									 accountmanager.selectedAccountstatement.stmtAccount.stmtBillingPeriod.sixtyDayBalance,
									 accountmanager.selectedAccountstatement.stmtAccount.stmtBillingPeriod.ninetyDayBalance,
									 nil];
	
	[self createDescriptionBody:self.balanceSummaryTags dataArray:accountCustomerValue];
	[accountCustomerValue release];
	[self displaySeperatorImage:label2Y_cord + ([self.accountSummaryTags count] )*(LabelCord_TwoLinesDifference - LabelCord_height)];
}

-(void) createDescriptionBody:(NSArray*)tagsTitle dataArray:(NSArray*)tagsValue;

{
	for (int titleIndex = 0; titleIndex < [tagsTitle count]; titleIndex++)
	{
		
		//CGRectMake(Label1Cord_x, label2Y_cord, LabelCord_width, LabelCord_height)
		UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectZero]; //
		UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectZero];
		
		label1.backgroundColor = [UIColor clearColor];
		label1.opaque = YES;
		label1.textColor = [UIColor blackColor];
		[label1 setFont:[UIFont boldSystemFontOfSize:FontOfSize14]];
		
		if ([tagsTitle objectAtIndex:titleIndex] != nil)
		{
			[label1 setText:[tagsTitle objectAtIndex:titleIndex]];
			
			if (titleIndex == 0) {
				label1.frame = CGRectMake(Label1Cord_x, label2Y_cord, ScrollLabel_Width, LabelCord_height);	//Label1Cord_y dont need to use it as now we are addin them to scrool view
			}
			else {
				label1.frame = CGRectMake(Label1Cord_x, label2Y_cord + titleIndex* (LabelCord_TwoLinesDifference - LabelCord_height), ScrollLabel_Width, LabelCord_height);
			}
			
		}
		else 
		{
			[label1 setText:DataNotAvailable];
			if (titleIndex == 0) {
				label1.frame = CGRectMake(Label1Cord_x, label2Y_cord, ScrollLabel_Width, LabelCord_height);
			}
			else {
				label1.frame = CGRectMake(Label1Cord_x, label2Y_cord + titleIndex*(LabelCord_TwoLinesDifference - LabelCord_height), ScrollLabel_Width, LabelCord_height);
			}
			
		}
		// work for dynamic label--- label2
		label2.backgroundColor = [UIColor clearColor];
		label2.opaque = YES;
		label2.textColor = [UIColor blackColor];
		[label2 setFont:[UIFont systemFontOfSize:FontOfSize14]];
        label2.lineBreakMode = UILineBreakModeWordWrap; 
        label2.numberOfLines = 0;
		if (titleIndex < [tagsValue count] && [tagsValue objectAtIndex:titleIndex] != nil)
		{
			
			int numOfLine = [self calculateNoOfLinesForLineWidth:[self calculateWidthForlabel:[tagsValue objectAtIndex:titleIndex]]];
			
			if (titleIndex == 0) {

				label2.frame = CGRectMake(Label2Cord_x, label2Y_cord, ScrollLabel_Width, LabelCord_height*numOfLine);
				[label2 setText:[tagsValue objectAtIndex:titleIndex]];
				//set the next y cord
				label2Y_cord = [self calculateNextY_CordFromPreviousY_cord:label2Y_cord andNumOfLine:numOfLine];
				
			}
			else {

				label2.frame = CGRectMake(Label2Cord_x, label2Y_cord + titleIndex*(LabelCord_TwoLinesDifference - LabelCord_height), ScrollLabel_Width, LabelCord_height*numOfLine);
				[label2 setText:[tagsValue objectAtIndex:titleIndex]];
				//set the next y cord
				label2Y_cord = [self calculateNextY_CordFromPreviousY_cord:label2Y_cord andNumOfLine:numOfLine];
			}
			
		}
		else 
		{
			int numOfLine = [self calculateNoOfLinesForLineWidth:[self calculateWidthForlabel:DataNotAvailable]];
			if (titleIndex == 0) {

				label2.frame = CGRectMake(Label2Cord_x, label2Y_cord, ScrollLabel_Width, LabelCord_height*numOfLine);
				[label2 setText:DataNotAvailable];
				//set the next y cord
				label2Y_cord = [self calculateNextY_CordFromPreviousY_cord:label2Y_cord andNumOfLine:numOfLine];
				
			}
			else {
				label2.frame = CGRectMake(Label2Cord_x, label2Y_cord + titleIndex*(LabelCord_TwoLinesDifference - LabelCord_height), ScrollLabel_Width, LabelCord_height*numOfLine);
				[label2 setText:DataNotAvailable];
				//set the next y cord
				label2Y_cord = [self calculateNextY_CordFromPreviousY_cord:label2Y_cord andNumOfLine:numOfLine];
			}
			
		}
		
		[scrollView addSubview:label1];
		[scrollView addSubview:label2];		
		
		[label1 release];
		[label2	 release];
		
	}
}

-(void) displaySeperatorImage:(float)yCoordinate;
{
	UIImageView* seperatorImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, yCoordinate + 3, Screen_Width, dot_height)];
	[seperatorImage setImage:[UIImage imageNamed:SeparatorImage]];
	[scrollView addSubview:seperatorImage];
	[seperatorImage release];
}

-(void) createSectionHeader:(NSString*)headerTitle yPosition:(float)yCoordinate
{
	UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabelCord_x, yCoordinate + 5, titleLabelCord_width, titleLabelCord_height)];
	titleLabel.backgroundColor = [UIColor whiteColor];
	titleLabel.opaque = YES;
	titleLabel.textColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0];
	[titleLabel setFont:[UIFont boldSystemFontOfSize:FontOfSize14]];
	[titleLabel setText:[NSString stringWithFormat:@"    %@", headerTitle]];
	[scrollView addSubview:titleLabel];
	[titleLabel release];
	
}

-(CGFloat) calculateWidthForlabel:(NSString *)comments
{
	CGSize size = [comments sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(800,160) lineBreakMode:UILineBreakModeWordWrap];
	
	return size.width + 10;
}

-(int)calculateNoOfLinesForLineWidth:(CGFloat)lineWidth
{
	//assuming the label width to be 130

	if(lineWidth/100 > 1) 
	{
		return floor(lineWidth/100);
	}
	else {
		return 1;
	}

}
-(CGFloat)calculateNextY_CordFromPreviousY_cord:(float)y_cord andNumOfLine:(int)noOfLine
{
	return y_cord + ((noOfLine) * LabelCord_height);
}
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.

    if(interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown )
    {
        scrollView.frame = CGRectMake(0, ScrollLabel_YCord, Screen_Width, Screen_Height-ScrollLabel_YCord - 70);
    }
    if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        scrollView.frame = CGRectMake(0, ScrollLabel_YCord, Screen_Width, Screen_Width-ScrollLabel_YCord - 70);
    }

    [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
//     Release any retained subviews of the main view.
//     e.g. self.myOutlet = nil;
}


- (void)dealloc {

	[accountDetailsTags release];
	[accountSummaryTags release];
	[balanceSummaryTags release];
	
	[dynamicLabelText release];
	[viewtitle release];
    [super dealloc];
}


@end
