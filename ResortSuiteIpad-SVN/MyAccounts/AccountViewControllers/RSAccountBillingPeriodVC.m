//
//  RSAccountBillingPeriodVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/7/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSAccountBillingPeriodVC.h"
#import "RSMyAccountManager.h"
#import "RSAccountStatementOptionVC.h"
#import "RSAccountpreviousBillingVC.h"
#import "ErrorPopup.h"
@implementation RSAccountBillingPeriodVC

@synthesize clubBillingHistoryReqResponseHandler = _clubBillingHistoryReqResponseHandler;
@synthesize clubStatementreqResponseHandler = _clubStatementreqResponseHandler;

-(void)dealloc
{
    [_clubBillingHistoryReqResponseHandler release];
    [_clubStatementreqResponseHandler release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _clubBillingHistoryReqResponseHandler = nil;
        _clubStatementreqResponseHandler = nil;
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
    self.title = BillingPeriod_ViewTilte;
    
    if (mainFieldArray) {
		[mainFieldArray removeAllObjects];
		[mainFieldArray release];
	}
	mainFieldArray = [[NSMutableArray alloc] initWithObjects:BillingPeriod_Current,BillingPeriod_Last,BillingPeriod_Previous,nil];

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


#pragma mark - TableView Delegate Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Adding selected mask image to the selected row.
    BaseListTableViewCell *cell = (BaseListTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.cellOverlayImageView.image = [UIImage imageNamed:SelectedTableCellBackgroudImage];
    
    RSMyAccountManager *accountManager  = [RSMyAccountManager sharedInstance];
    
    if(indexPath.section == PreviousSection)
	{
        [self startLoadingAnimation];
        _clubBillingHistoryReqResponseHandler = [[RSClubBillingHistoryReqResponseHnadler alloc]init];
        [_clubBillingHistoryReqResponseHandler setDelegate:self];
        [_clubBillingHistoryReqResponseHandler fetchBillingHistoryForAccountId:[[accountManager.modelClubAccounts.accounts objectAtIndex:accountManager.selectedAccountIndex] accountId]];
    }
    else {
		[self startLoadingAnimation];
		NSString *billDate =@"";
		
		if(indexPath.section == CurrentSection)
		{
			billDate = @"current";
		}
		else if(indexPath.section == LastSection)
		{
			billDate = @"last";
		}
        _clubStatementreqResponseHandler = [[RSClubStatementReqResponseHandler alloc]init];
        [_clubStatementreqResponseHandler setDelegate:self];
        [_clubStatementreqResponseHandler fetchClubstatementForAccountId:[[accountManager.modelClubAccounts.accounts objectAtIndex:accountManager.selectedAccountIndex] accountId] andBillingDate:billDate];
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
		case CurrentSection:
			cell.cellImageView.image = [UIImage imageNamed:Club_Current_Icon];
			break;
		case LastSection:
			cell.cellImageView.image = [UIImage imageNamed:Club_Last_Icon];
			break;
		case PreviousSection:
			cell.cellImageView.image = [UIImage imageNamed:Club_Previous_Icon];
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

#pragma mark RSParseBase delegate
-(void)parsingComplete:(id)parserModelData
{	[self stopLoadingAnimation];
    RSMyAccountManager *accountmanager = [RSMyAccountManager sharedInstance];
	if ([parserModelData isKindOfClass:[Result class]]) {
        
        Result *result = (Result *)parserModelData;
        NSString *errorMessage = [NSString stringWithFormat:@"%@", result.resultText];
        
        ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
        [errorPopup initWithTitle:errorMessage];
		
	}
	else if ([parserModelData isKindOfClass:[RSClubStatement class]]) {
		
        accountmanager.selectedAccountstatement = (RSClubStatement *) parserModelData;
        
		RSAccountStatementOptionVC *mRSStatementOptionViewController = [[RSAccountStatementOptionVC alloc] initWithNibName:@"BaseListViewController" bundle:[NSBundle mainBundle]];
		[self.navigationController pushViewController:mRSStatementOptionViewController animated:YES];
		[mRSStatementOptionViewController release];	
        
        self.clubStatementreqResponseHandler = nil;
		
	}
	else if ([parserModelData isKindOfClass:[RSClubBillingHistory class]]) {
        accountmanager.selectedAccountBillinghistory = (RSClubBillingHistory *) parserModelData;
		
		RSAccountPreviousBillingVC
        *mRSPreviousBillingPeriodsViewController = [[RSAccountPreviousBillingVC alloc] initWithNibName:@"BaseListViewController" bundle:[NSBundle mainBundle]];
		[self.navigationController pushViewController:mRSPreviousBillingPeriodsViewController animated:YES];
		[mRSPreviousBillingPeriodsViewController release];	
        self.clubBillingHistoryReqResponseHandler = nil;
		
	}
}
@end
