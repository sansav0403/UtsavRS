//
//  RSAccountStatementOptionVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/7/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSAccountStatementOptionVC.h"
#import "RSClubStatement.h"
#import "RSMyAccountManager.h"
#import "RSChargeObject.h"
#import "RSSummaryPage.h"
#import "RSChargeAndPaymentViewController.h"
#import "DateManager.h"
@implementation RSAccountStatementOptionVC

-(void)dealloc
{
    [mainFieldArray release];
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
    [self.headerImageView setImage:[UIImage imageNamed:Club_MyAccount_HI]];
    [self setTitle:StatementOptions_ViewTilte];
    
    mainFieldArray = [[NSMutableArray alloc] initWithObjects:Club_Summary,Club_Charges,Club_Payments,nil];
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
-(void) dateSorting:(NSArray *) folioObject
{
	NSArray *folioArray = [[NSArray	alloc]initWithArray:folioObject];
	//sorting Entried by Date
	if (sortDescriptor) {
		[sortDescriptor release];
	}
	sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"ItemId" ascending:YES] ;
	
	sortDescriptors = [NSArray arrayWithObject:sortDescriptor];       //autorelease   
	sortedGroupEventObjectArray = [[NSArray alloc]initWithArray:[folioArray sortedArrayUsingDescriptors:sortDescriptors] ];
	
	//create a dictionry by date(day)
	dateKeyArray = [[NSMutableArray alloc] init];	//array of key in the dic
	
	if (dateDictionary) {
		[dateDictionary removeAllObjects];
		[dateDictionary release];
	}
	dateDictionary = [[NSMutableDictionary alloc]init];
	
	for(int eventObjectIndex=0; eventObjectIndex<[sortedGroupEventObjectArray count]; eventObjectIndex++)
	{
		FolioItem *folioItem = [sortedGroupEventObjectArray objectAtIndex:eventObjectIndex];//get the obj at index
		NSString* objectId = [NSString stringWithFormat:@"%d",[[sortedGroupEventObjectArray objectAtIndex:eventObjectIndex] ItemId] ]; 
		NSMutableArray *localEventArray = [[NSMutableArray alloc] initWithObjects:folioItem,nil];
		[dateDictionary setObject:localEventArray forKey:objectId];
		[localEventArray release];
		
		[dateKeyArray addObject:objectId];
        //		
	}
	[sortedGroupEventObjectArray release];
	
	//sorting the key by date
	sortedDateKeyArray = [[NSArray alloc]initWithArray:[dateKeyArray sortedArrayUsingSelector:@selector(compare:)]];//check
	[dateKeyArray release];
	///////
	[folioArray release];
    
}

#pragma mark date Functions
-(NSString *)stringFromDate:(NSDate *)date
{
	return [DateManager stringFromDate:date withDateFormat:MMMM_d_yyyyFormat];
}

-(NSString *)stringFromDateWithoutYear:(NSDate *)date
{
	return [DateManager stringFromDate:date withDateFormat:MMMM_dFormat];
}

-(NSDate *)stringToDate:(NSString *)stringDate 
{
    NSDate* date = [DateManager dateFromString:stringDate withDateFormat:MMMM_d_yyyyFormat];
	return date;
}

-(NSString *)dateRange:(NSString *)firstDate endDate:(NSString *)lastDate
{
	NSString* firstPart = [NSString stringWithFormat:@"From %@ to ",firstDate];
	
	
	return [NSString stringWithFormat:@"%@ %@",firstPart,lastDate];
}

#pragma mark - TableView Delegate Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Adding selected mask image to the selected row.
    BaseListTableViewCell *cell = (BaseListTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.cellOverlayImageView.image = [UIImage imageNamed:SelectedTableCellBackgroudImage];
    
    RSMyAccountManager *accountManager = [RSMyAccountManager sharedInstance];
	if(indexPath.section == SummarySection) //Summary
	{
		RSSummaryPage *mRSSummaryPage= [[RSSummaryPage alloc] initWithTitle:Club_Summary];
		[self.navigationController pushViewController:mRSSummaryPage animated:YES];
		mRSSummaryPage.navigationItem.title = Club_Summary;
		[mRSSummaryPage release];
		
	}
	else if(indexPath.section == ChargesSection)
	{

		NSString *viewTitle = [NSString stringWithFormat:AccOption_Chargesection_Title];      //on view title the view ll change for charge or payment
		NSArray *sLabelArray =[[NSArray alloc]initWithObjects:AccOption_Accountnum,
                               AccOption_AccountType,
                               AccOption_AccountOwner,
                               AccOption_StatementPeriod,
                               nil];
		
        NSString *statementStartDate = accountManager.selectedAccountstatement.stmtAccount.stmtBillingPeriod.periodStartDate;
        NSString *statementBillDate = accountManager.selectedAccountstatement.stmtAccount.stmtBillingPeriod.billDate;
        
        
		NSString *statementPeriod = [NSString stringWithFormat:@"%@ - %@", statementStartDate,statementBillDate];
		
        statementPeriod = (statementStartDate || statementBillDate)? statementPeriod : @""; 
				
		NSArray *dLabelArray = [[NSArray alloc]initWithObjects:
								[[accountManager.modelClubAccounts.accounts objectAtIndex:accountManager.selectedAccountIndex] accountId],
								[[accountManager.modelClubAccounts.accounts objectAtIndex:accountManager.selectedAccountIndex] classType],
								[[accountManager.modelClubAccounts.accounts objectAtIndex:accountManager.selectedAccountIndex] statementCustomerName],
								
								statementPeriod,
								nil];
		NSMutableArray *objectArray = [[NSMutableArray alloc]init];  //to store the array of charege/payment objects
		
		[self dateSorting:accountManager.selectedAccountstatement.stmtAccount.folioItems];
		
		for (int dateKeyIndex = 0; dateKeyIndex < [sortedDateKeyArray count]; dateKeyIndex++) {
			NSString * chargeDate = [[[dateDictionary objectForKey:[sortedDateKeyArray objectAtIndex:dateKeyIndex]] objectAtIndex:0] folioDate];
			
			NSString * objectLabel1 = [self stringFromDateWithoutYear:[self stringToDate:chargeDate]];
            
			NSString * objectLabel2 = [[[dateDictionary objectForKey:[sortedDateKeyArray objectAtIndex:dateKeyIndex]] objectAtIndex:0] name];
            
			NSString * objectLabel3 = [[[dateDictionary objectForKey:[sortedDateKeyArray objectAtIndex:dateKeyIndex]] objectAtIndex:0] totalPrice];
            
			NSArray *objectLabels = [[NSArray alloc]initWithObjects:objectLabel1,objectLabel2,objectLabel3,nil];
            
			NSString *ObjectDescription = [NSString stringWithFormat:@"your expences are"];
            
			RSChargeObject *mRSChargeObject = [[RSChargeObject alloc]initWtihObjectLabels:objectLabels withChargeDescription:ObjectDescription];
            
			[objectArray addObject:mRSChargeObject];
            
			[objectLabels release];
			[mRSChargeObject release];
		}
		
		RSChargeAndPaymentViewController *mRSChargeViewController = [[RSChargeAndPaymentViewController alloc]
                                                                     initWithTitle:viewTitle
                                                                     WithConstLabelText:sLabelArray
                                                                     DynamicTextLabels:dLabelArray
                                                                     objectArrays:objectArray];
		mRSChargeViewController.navigationItem.title = Club_Charges;
		[self.navigationController pushViewController:mRSChargeViewController animated:YES];
		
		[sLabelArray release];
		[dLabelArray release];
		[objectArray release];
		[mRSChargeViewController release];
		
	}
	else if(indexPath.section == PaymentSection)
	{
		
        // eg for payment
		NSString *viewTitle = [NSString stringWithFormat:AccOption_Paymentsection_Title];    //depend on view title,the view ll change for charge or payment
		
		NSArray *sLabelArray =[[NSArray alloc]initWithObjects:AccOption_Accountnum,
							   AccOption_AccountType,
							   AccOption_AccountOwner,
							   AccOption_StatementPeriod,
							   nil];
		
        NSString *statementStartDate = accountManager.selectedAccountstatement.stmtAccount.stmtBillingPeriod.periodStartDate;
        NSString *statementBillDate = accountManager.selectedAccountstatement.stmtAccount.stmtBillingPeriod.billDate;
        
        
		NSString *statementPeriod = [NSString stringWithFormat:@"%@ - %@", statementStartDate,statementBillDate];
		
        statementPeriod = (statementStartDate || statementBillDate)? statementPeriod : @""; 
		
		NSArray *dLabelArray = [[NSArray alloc]initWithObjects:
								[[accountManager.modelClubAccounts.accounts objectAtIndex:accountManager.selectedAccountIndex] accountId],
								[[accountManager.modelClubAccounts.accounts objectAtIndex:accountManager.selectedAccountIndex] classType],
								[[accountManager.modelClubAccounts.accounts objectAtIndex:accountManager.selectedAccountIndex] statementCustomerName],
								
								statementPeriod,
								nil];
		
		NSMutableArray *objectArray = [[NSMutableArray alloc]init];  //to store the array of charege/payment objects
        
		[self dateSorting:accountManager.selectedAccountstatement.stmtAccount.folioPayments];
        
		for (int dateKeyIndex = 0; dateKeyIndex < [sortedDateKeyArray count]; dateKeyIndex++)
		{
			NSString * objectLabel1 = [self stringFromDateWithoutYear:[self stringToDate:[[[dateDictionary objectForKey:[sortedDateKeyArray objectAtIndex:dateKeyIndex]] objectAtIndex:0] folioDate]]];
			NSString * objectLabel2 = [[[dateDictionary objectForKey:[sortedDateKeyArray objectAtIndex:dateKeyIndex]] objectAtIndex:0] label];			
			NSString * objectLabel3 = [[[dateDictionary objectForKey:[sortedDateKeyArray objectAtIndex:dateKeyIndex]] objectAtIndex:0] amount];
            
			NSArray *objectLabels = [[NSArray alloc]initWithObjects:objectLabel1,objectLabel2,objectLabel3,nil];
			NSString *ObjectDescription = [NSString stringWithFormat:@"your expences are"];
			RSChargeObject *mRSChargeObject = [[RSChargeObject alloc]initWtihObjectLabels:objectLabels withChargeDescription:ObjectDescription];
			
			[objectArray addObject:mRSChargeObject];
			
			[objectLabels release];
			[mRSChargeObject release];
		}  
        
		RSChargeAndPaymentViewController *mRSChargeViewController = [[RSChargeAndPaymentViewController alloc] initWithTitle:viewTitle
                                WithConstLabelText:sLabelArray
                                DynamicTextLabels:dLabelArray
                                objectArrays:objectArray];
		mRSChargeViewController.navigationItem.title = Club_Payments;
        [self.navigationController pushViewController:mRSChargeViewController animated:YES];
        
		[sLabelArray release];
		[dLabelArray release];
		[objectArray release];
		[mRSChargeViewController release];
        /////////////////
	}
	
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseListTableViewCell *cell = (BaseListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        NSArray *customCellArray = [[NSBundle mainBundle]loadNibNamed:@"BaseListTableViewCell" owner:nil options:nil];
        
        for (id currerntObject in customCellArray) {
            if ([currerntObject isKindOfClass:[BaseListTableViewCell class]]) {
                cell = (BaseListTableViewCell *)currerntObject;
                break;
            }
        }
        //cell.backgroundColor = [UIColor clearColor];
    }
    cell.cellText.text = [mainFieldArray objectAtIndex:indexPath.section];
    
    //Create a image thumbnail which will come under each cell
	switch (indexPath.section)
	{
		case SummarySection:
			cell.cellImageView.image = [UIImage imageNamed:Club_Summery_Icon];
			break;
		case ChargesSection:
			cell.cellImageView.image = [UIImage imageNamed:Club_Charges_Icon];
			break;
		case PaymentSection:
			cell.cellImageView.image = [UIImage imageNamed:Club_Payments_Icon];
			break;
		default:
			break;
	}
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [mainFieldArray count];
}
@end
