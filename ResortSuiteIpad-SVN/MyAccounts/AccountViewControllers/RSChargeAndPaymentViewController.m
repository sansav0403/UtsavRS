    //
//  RSChargeAndPaymentViewController.m
//  ResortSuite
//
//  Created by Cybage on 07/07/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//
#import "RSChargeObject.h"
#import "RSChargeTableCell.h"
#import "RSChargeAndPaymentViewController.h"
#import "RSMyAccountManager.h"
#import "DateManager.h"

#define TableHeaderExtraSpacing			5
#define No_lines_Cell					2
#define StatementPeriodIndex			3
#define TableCellHeight                 44
#define tableTitleLabel_y_offset        85
#define labelSize                       CGSizeMake(250.0, 40.0)



@implementation RSChargeAndPaymentViewController
@synthesize constLabels,dynamicLabels,tableObjects,viewtitle;

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
-(id)initWithTitle:(NSString *)vTitle WithConstLabelText:(NSArray *)sLabelTexts DynamicTextLabels:(NSArray *)dLabelArray
	  objectArrays:(NSArray *)objectArray
{
	self.viewtitle = vTitle;
	self.constLabels = sLabelTexts;
	self.dynamicLabels = dLabelArray;
	self.tableObjects = objectArray;
	return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self createTitleLabel];
	[self createInformationLabels];
	
	// work  for the table
	//calculate the y cord for the label above the table//85 + (i*25) is the logic set in RSconstant.h
	float tableTitleLabel_y = tableTitleLabel_y_offset + ( ([self.constLabels count] - 1) * Y_diff);
	//draw seperator line above table tiltle
	[self drawSeperatorImageAtYCord:(tableTitleLabel_y ) AndDiffFactor:2.0];
	
	tableChargeTitleTexts = [[NSArray alloc]initWithObjects:Charge_PaymentDateTitle,ChargeDescriptionTitle,Charge_PaymentAmountTitle,nil];
	tablePaymentTitleTexts = [[NSArray alloc]initWithObjects:Charge_PaymentDateTitle,PaymentTypeTitle,Charge_PaymentAmountTitle,nil];
	
	/// view if the charge page is to be displayed
	if ([self.navigationItem.title isEqualToString:Club_Charges] || [self.navigationItem.title isEqualToString:ChargeDetail_ViewTilte] )
	{
		[self createDetailsPageView:tableChargeTitleTexts PositionY:tableTitleLabel_y TotalAmoutLabel:TotalChargeText];
	}
	
//changed view for payment
	if ([self.navigationItem.title isEqualToString:Club_Payments])	//check the condition using object ll b better
	{
		[self createDetailsPageView:tablePaymentTitleTexts PositionY:tableTitleLabel_y TotalAmoutLabel:TotalPaymentText];
	}
	
}

-(void)createDetailsPageView:(NSArray *)tableTitleTexts PositionY:(CGFloat)coordinateY TotalAmoutLabel:(NSString*) totalAmountLabel
{
	[self createDetailsTitles:tableTitleTexts PositionY:coordinateY];
	
	//add the line above table
	[self drawSeperatorImageAtYCord:coordinateY AndDiffFactor:3.0];
	
	//adding the table view
	[self createDetailsTable:coordinateY];
	
	//add the line below table
	[self drawSeperatorImageAtYCord:(coordinateY+(tableHeight + tableHeightOffset)) AndDiffFactor:3.2];
	// add the totallabel
	
	[self addTotalLabelAtYcord:coordinateY WithLabel:TotalPaymentText];
}

-(void)createDetailsTitles:(NSArray *)tableTitleTexts PositionY:(CGFloat)coordinateY;
{
	for(int titleIndex = 0; titleIndex < [tableTitleTexts count]; titleIndex++)	//3 table title label added
	{// note label is shifting down by 25 units
		UILabel *label1 = nil;
		if ([self.navigationItem.title isEqualToString:Club_Payments])
		{
			label1 = [[UILabel alloc]initWithFrame:CGRectMake(Label1Cord_x+(X_diff*titleIndex), coordinateY+(Y_diff*2.0), LabelCord_width, LabelCord_height)]; //
		}
		else if ([self.navigationItem.title isEqualToString:Club_Charges] || [self.navigationItem.title isEqualToString:ChargeDetail_ViewTilte] )
		{
			if(titleIndex == firstIndex )
			{
				label1 = [[UILabel alloc]initWithFrame:CGRectMake(Label1Cord_x+(X_diff*titleIndex) - TableHeaderExtraSpacing , coordinateY+(Y_diff*2.0), LabelCord_width, LabelCord_height)]; //
			}
			else
			{
				label1 = [[UILabel alloc]initWithFrame:CGRectMake(Label1Cord_x+(X_diff*titleIndex), coordinateY+(Y_diff*2.0), LabelCord_width, LabelCord_height)]; //
			}
		}
		
		
		label1.backgroundColor = [UIColor clearColor];
		label1.opaque = YES;
		label1.textColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0];
		label1.font =[UIFont boldSystemFontOfSize:FONT_SIZE];
		
		if (titleIndex == secondIndex)
		{
			label1.textAlignment = UITextAlignmentRight;
		}
		label1.text = [tableTitleTexts objectAtIndex:titleIndex];
		[self.view addSubview:label1];
		[label1 release];
		
	}
	
}

-(void)createTitleLabel
{
	UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabelCord_x, titleLabelCord_y, titleLabelCord_width, titleLabelCord_height)];
	titleLabel.backgroundColor = [UIColor whiteColor];
	titleLabel.opaque = YES;
	titleLabel.textColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0];
	[titleLabel setFont:[UIFont boldSystemFontOfSize:FONT_SIZE]];
	[titleLabel setText:[NSString stringWithFormat:@"    %@", self.viewtitle]];
	[self.view addSubview:titleLabel];
	[titleLabel release];
}

-(void)createInformationLabels
{
	
	for (int labelIndex = 0; labelIndex < [self.constLabels count]; labelIndex++)
	{
		UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectZero];
		UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(Label1Cord_x, LabelCord_y, LabelCord_width, LabelCord_height)]; //
				
		label1.backgroundColor = [UIColor clearColor];
		label1.opaque = YES;
		label1.textColor = [UIColor blackColor];
		[label1 setFont:[UIFont boldSystemFontOfSize:FONT_SIZE]];
		
		if ([self.constLabels objectAtIndex:labelIndex] != nil)
		{
			[label1 setText:[self.constLabels objectAtIndex:labelIndex]];
		}
		else 
		{
			[label1 setText:DataNotAvailable];
		}
		int label2FrameX = Screen_Width/2 -30;
		label2.frame = CGRectMake(label2FrameX , LabelCord_y, (Screen_Width - label2FrameX - 10) , LabelCord_height);				   
		label2.backgroundColor = [UIColor clearColor];
		label2.opaque = YES;
		label2.textColor = [UIColor blackColor];
		[label2 setFont:[UIFont systemFontOfSize:FONT_SIZE]];
		
		if (labelIndex == StatementPeriodIndex)
		{	//at 3rd postion we hav from to atatement
			label2.numberOfLines = 0;
			
			CGSize size = [[self.dynamicLabels objectAtIndex:labelIndex] sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:labelSize lineBreakMode:UILineBreakModeWordWrap];
            
			label2.frame = CGRectMake(label2FrameX, LabelCord_y, size.width+100.0 , size.height );
           
			
		}
		
		if ([self.constLabels objectAtIndex:labelIndex] != nil)
		{
			[label2 setText:[self.dynamicLabels objectAtIndex:labelIndex]];
		}
		else 
		{
			[label2 setText:DataNotAvailable];
		}
		
		[self.view addSubview:label1];
		[self.view addSubview:label2];		
		
		[label1 release];
		[label2	 release];
		
	}
	
}

#define tableheightOffset 75
-(void)createDetailsTable:(CGFloat)coordinateY
{
	if ([self.navigationItem.title isEqualToString:ChargeDetail_ViewTilte] )
	{
		tableHeightOffset = tableheightOffset;
	}
	else
	{
		tableHeightOffset = 0;
	}

	UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, coordinateY + (Y_diff * 3)+ 5, Screen_Width, (tableHeight + tableHeightOffset) ) style:UITableViewStylePlain];
	[table setDelegate:self];
	[table setDataSource:self];
	table.allowsSelection = YES;
	[table setBounces:YES];
	[table setBackgroundColor:[UIColor clearColor]];
	[table setSeparatorColor:[UIColor clearColor]];
	[self.view addSubview:table];
	[table release];
}

-(void)addTotalLabelAtYcord:(CGFloat)Ycord WithLabel:(NSString *)labelText		//tableTitleLabel_y
{
	UILabel *totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(Label1Cord_x, Ycord + (Y_diff * 3.5) + (tableHeight + tableHeightOffset), LabelCord_width, LabelCord_height)]; //
	
	totalLabel.backgroundColor = [UIColor clearColor];
	totalLabel.opaque = YES;
	totalLabel.textColor = [UIColor blackColor];
	[totalLabel setFont:[UIFont boldSystemFontOfSize:FONT_SIZE]];
	[totalLabel setText:labelText];
	
	[self.view addSubview:totalLabel];
	[totalLabel release];
	
	//calculate the toal cost
	float totalcost = 0.0;
	for (int objectIndex = 0; objectIndex < [tableObjects count]; objectIndex++)
	{	
		//tableobject are array of the rschargeObject
		totalcost  =totalcost + [[[[[tableObjects objectAtIndex:objectIndex] objectLabels] objectAtIndex:2] stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue];	//as at the third postion is the number;
	}
	
	UILabel *totalCostLabel = [[UILabel alloc]initWithFrame:CGRectMake(Label1Cord_x+(X_diff*2), Ycord + (Y_diff * 3.5) + (tableHeight + tableHeightOffset), LabelCord_width, LabelCord_height)]; //
	
	totalCostLabel.backgroundColor = [UIColor clearColor];
	totalCostLabel.opaque = YES;
	totalCostLabel.textColor = [UIColor blackColor];
	[totalCostLabel setFont:[UIFont boldSystemFontOfSize:FONT_SIZE]];
	[totalCostLabel setTextAlignment:UITextAlignmentRight];
	[totalCostLabel setText:[NSString stringWithFormat:@"$ %.02f",totalcost]];
	
	[self.view addSubview:totalCostLabel];
	[totalCostLabel release];
	
}
#pragma mark date Functions

-(NSString *)stringFromDateWithoutYear:(NSDate *)date
{
    return [DateManager stringFromDate:date withDateFormat:MMMM_dFormat];
}

-(NSDate *)stringToDate:(NSString *)stringDate 
{
    NSDate* date = [DateManager dateFromString:stringDate withDateFormat:MMMM_d_yyyyFormat];
	return date;
}

-(void)drawSeperatorImageAtYCord:(float)ycord AndDiffFactor:(float)diff
{
	UIImageView *seperatorImage = [[UIImageView alloc]initWithFrame:CGRectMake((Screen_Width - dot_width)/2,  ycord+(Y_diff*diff), dot_width, dot_height)];
	[seperatorImage setImage:[UIImage imageNamed:SeparatorImage]];
	[self.view addSubview:seperatorImage];
	[seperatorImage release];
}

#pragma mark tableViewDelegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	return [tableObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    RSChargeTableCell *cell = (RSChargeTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[RSChargeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];

		if ([self.navigationItem.title isEqualToString:Club_Charges])
		{
			[cell.fieldLabel1 setFrame:CGRectMake((Label1Cord_x+(X_diff*0)), tableCellLabel_y, LabelCord_width, LabelCord_height * No_lines_Cell)];
			[cell.fieldLabel2 setFrame:CGRectMake((Label1Cord_x+(X_diff*1)) - TableHeaderExtraSpacing, tableCellLabel_y, LabelCord_width+30 , LabelCord_height * No_lines_Cell)];
            
			[cell.fieldLabel3 setFrame:CGRectMake((Label1Cord_x+(X_diff*2)), tableCellLabel_y, LabelCord_width, LabelCord_height * No_lines_Cell)];
			[cell.fieldLabel2 setNumberOfLines:2];
			
		}
		else if ([self.navigationItem.title isEqualToString:ChargeDetail_ViewTilte] )
		{
			[cell.fieldLabel1 setFrame:CGRectMake((Label1Cord_x+(X_diff*0)), tableCellLabel_y, LabelCord_width, LabelCord_height * No_lines_Cell)];
			[cell.fieldLabel2 setFrame:CGRectMake((Label1Cord_x+(X_diff*1)) - TableHeaderExtraSpacing, tableCellLabel_y, LabelCord_width+30 , LabelCord_height * No_lines_Cell)];
			[cell.fieldLabel3 setFrame:CGRectMake((Label1Cord_x+(X_diff*2)), tableCellLabel_y, LabelCord_width, LabelCord_height * No_lines_Cell)];
			[cell.fieldLabel2 setNumberOfLines:2];
		}
		else if ([self.navigationItem.title isEqualToString:Club_Payments])
		{
			[cell.fieldLabel1 setFrame:CGRectMake((Label1Cord_x+(X_diff*0)), tableCellLabel_y, LabelCord_width, LabelCord_height * No_lines_Cell)];
			[cell.fieldLabel2 setFrame:CGRectMake((Label1Cord_x+(X_diff*1)), tableCellLabel_y, LabelCord_width , LabelCord_height * No_lines_Cell)];
			[cell.fieldLabel3 setFrame:CGRectMake((Label1Cord_x+(X_diff*2)), tableCellLabel_y, LabelCord_width, LabelCord_height * No_lines_Cell)];
		}
	}

	if ([self.navigationItem.title isEqualToString:Club_Charges])
	{
//		ResortSuiteAppDelegate *appDelegate = (ResortSuiteAppDelegate *)[[UIApplication sharedApplication] delegate];
        RSMyAccountManager *accountManager = [RSMyAccountManager sharedInstance];
		NSArray *postingItems = [[accountManager.selectedAccountstatement.stmtAccount.folioItems objectAtIndex:indexPath.row] postingItems];
		
		if([postingItems count]>0)
		{
			[cell EditAccessoryView];
		}
		else
		{
			cell.accessoryType = UITableViewCellAccessoryNone;
			cell.accessoryView = NULL;
		}

		
	}	

	[cell.fieldLabel1 setText:[[[tableObjects objectAtIndex:indexPath.row] objectLabels] objectAtIndex:0]];	//  will give string
	[cell.fieldLabel2 setText:[[[tableObjects objectAtIndex:indexPath.row] objectLabels] objectAtIndex:1]];
	[cell.fieldLabel3 setText:[NSString stringWithFormat:@"$ %@",[[[tableObjects objectAtIndex:indexPath.row] objectLabels] objectAtIndex:2]]];

	return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return TableCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	if ([self.navigationItem.title isEqualToString:Club_Charges])
	{

         RSMyAccountManager *accountManager = [RSMyAccountManager sharedInstance];
		NSArray *postingItems = [[accountManager.selectedAccountstatement.stmtAccount.folioItems objectAtIndex:indexPath.row] postingItems];
		
		if([postingItems count]>0)
		{
			NSString *viewTitle = [NSString stringWithFormat:@"Items in Folio: %d",[[postingItems objectAtIndex:0] ItemId]];      //on view title the view ll change for charge or payment
			NSMutableArray *objectArray = [[NSMutableArray alloc]init];  //to store the array of charege/payment objects
			
			
			for (int postingItemsIndex = 0; postingItemsIndex < [postingItems count]; postingItemsIndex++) 
			{
				for (int itemsIndex = 0; itemsIndex < [[[postingItems objectAtIndex:postingItemsIndex] items] count]; itemsIndex++) 
				{
					NSString * chargeDate = [[[[postingItems objectAtIndex:postingItemsIndex] items] objectAtIndex:itemsIndex] itemDate];
					
					NSString * objectLabel1 = [self stringFromDateWithoutYear:[self stringToDate:chargeDate]];
					NSString * objectLabel2 = [[[[postingItems objectAtIndex:postingItemsIndex] items] objectAtIndex:itemsIndex] name];
					NSString * objectLabel3 = [[[[postingItems objectAtIndex:postingItemsIndex] items] objectAtIndex:itemsIndex] amount];
					NSArray *objectLabels = [[NSArray alloc]initWithObjects:objectLabel1,objectLabel2,objectLabel3,nil];
					NSString *ObjectDescription = [NSString stringWithFormat:@"your expences are"];
					RSChargeObject *mRSChargeObject = [[RSChargeObject alloc]initWtihObjectLabels:objectLabels withChargeDescription:ObjectDescription];
					
					[objectArray addObject:mRSChargeObject];
					
					[objectLabels release];
					[mRSChargeObject release];
				}
			}
			
			RSChargeAndPaymentViewController *mRSChargeViewController = [[RSChargeAndPaymentViewController alloc] initWithTitle:viewTitle
																											 WithConstLabelText:nil
																											  DynamicTextLabels:nil
																												   objectArrays:objectArray];
			mRSChargeViewController.navigationItem.title = ChargeDetail_ViewTilte;
			[self.navigationController pushViewController:mRSChargeViewController animated:YES];
			[objectArray release];
			[mRSChargeViewController release];
		}
	}
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
    self.viewtitle = nil;
    self.constLabels = nil;
    self.dynamicLabels = nil;
    self.tableObjects = nil;
	[tableChargeTitleTexts release];
	[tablePaymentTitleTexts release];
	
	[super dealloc];
}


@end
