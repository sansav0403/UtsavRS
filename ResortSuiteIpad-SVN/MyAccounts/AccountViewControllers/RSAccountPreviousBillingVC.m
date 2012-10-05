//
//  RSAccountPreviousBillingVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/9/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSAccountPreviousBillingVC.h"
#import "ErrorPopup.h"
#import "RSMyAccountManager.h"
#import "RSMIByDateCustomCell.h"
#import "RSAccountStatementOptionVC.h"
#import "DateManager.h"
@implementation RSAccountPreviousBillingVC

@synthesize clubStatementreqResponseHandler = _clubStatementreqResponseHandler;

-(void)dealloc
{
    [_clubStatementreqResponseHandler release];
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
    [self setTitle:PreviousBilling_ViewTilte];
    
    if (mainFieldArray) {
		[mainFieldArray removeAllObjects];
		[mainFieldArray release];
	}
	mainFieldArray = [[NSMutableArray alloc] init];
    
    RSMyAccountManager *accountManager = [RSMyAccountManager sharedInstance];
    DLog(@"previous bill count = %d",[accountManager.selectedAccountBillinghistory.billingPeriods count]);
    
    for(int billingPeriodIndex=0; billingPeriodIndex < [accountManager.selectedAccountBillinghistory.billingPeriods count]; billingPeriodIndex++)
	{
		[mainFieldArray addObject:[[accountManager.selectedAccountBillinghistory.billingPeriods objectAtIndex:billingPeriodIndex] billDate] ];
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
/*

 */
#pragma mark - TableView Delegate Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    RSMyAccountManager *accountManager = [RSMyAccountManager sharedInstance];
    [self startLoadingAnimation];
    
    //-----converted date due to Date Format changes------------------//
    NSString *billDateStr = [[accountManager.selectedAccountBillinghistory.billingPeriods objectAtIndex:indexPath.section] billDate];
    
    DLog(@"billDateStr =%@",billDateStr);
    NSString *convertedBillDate = [DateManager convertIntoResponseStringFromSpecificFormatString:billDateStr dateFormatStyle:MMMM_dd_yyyyFormat withTime:NO];    
    //------------------------------------------------------------------//
    
    _clubStatementreqResponseHandler = [[RSClubStatementReqResponseHandler alloc]init];
    [_clubStatementreqResponseHandler setDelegate:self];
    [_clubStatementreqResponseHandler fetchClubstatementForAccountId:[[accountManager.modelClubAccounts.accounts objectAtIndex:accountManager.selectedAccountIndex] accountId] andBillingDate:convertedBillDate];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RSMIByDateCustomCell *cell = (RSMIByDateCustomCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        NSArray *customCellArray = [[NSBundle mainBundle]loadNibNamed:@"RSMIByDateCustomCell" owner:nil options:nil];
        
        for (id currerntObject in customCellArray) {
            if ([currerntObject isKindOfClass:[RSMIByDateCustomCell class]]) {
                cell = (RSMIByDateCustomCell *)currerntObject;
                break;
            }
        }
        //cell.backgroundColor = [UIColor clearColor];
    }
    cell.cellDateText.text = [mainFieldArray objectAtIndex:indexPath.section];
    
    //Create a image thumbnail which will come under each cell    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [mainFieldArray count];
}


#pragma mark RSParseBase delegate
-(void)parsingComplete:(id)parserModelData
{	
    [self stopLoadingAnimation];
    RSMyAccountManager *accountManager = [RSMyAccountManager sharedInstance];
	if ([parserModelData isKindOfClass:[Result class]]) {
        Result *result = (Result *)parserModelData;
			NSString *errorMessage = [NSString stringWithFormat:@"%@", result.resultText];
			
			ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
			[errorPopup initWithTitle:errorMessage];

		
	}
	else if ([parserModelData isKindOfClass:[RSClubStatement class]]) {
		
		accountManager.selectedAccountstatement = (RSClubStatement *) parserModelData;
		self.clubStatementreqResponseHandler = nil;
		RSAccountStatementOptionVC *mRSStatementOptionViewController = [[RSAccountStatementOptionVC alloc] initWithNibName:@"BaseListViewController" bundle:[NSBundle mainBundle]];
		[self.navigationController pushViewController:mRSStatementOptionViewController animated:YES];
		[mRSStatementOptionViewController release];	
		
	}
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
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	//[dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
	[dateFormatter setDateFormat:yyyy_MM_ddFormat];  
	NSDate* date = (NSDate*)[dateFormatter dateFromString:firstDate];
    
	[dateFormatter setDateFormat:MMMM_dFormat];
	
	NSString* firstPart = [NSString stringWithFormat:@"From %@ to ",[dateFormatter stringFromDate:date]];
	
	[dateFormatter release];
	
	return [NSString stringWithFormat:@"%@ %@",firstPart,[self stringFromDate:[self stringToDate:lastDate]]];
}

@end
