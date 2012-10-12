//
//  RSAccountListVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/16/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSAccountListVC.h"
#import "RSMyAccountActivity.h"
#import "RSAppDelegate.h"
#import "RSMIByDateCustomCell.h"

@implementation RSAccountListVC

@synthesize modelClubAccounts;

-(void)dealloc
{
    [mainFieldArray release];
    [modelClubAccounts release];
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
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withClubAccounts:(RSClubAccounts *)Accounts
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.modelClubAccounts = Accounts;
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
    [self setTitle:AccountList_ViewTilte];
    
    mainFieldArray = [[NSMutableArray alloc] init];
    
    for(int accountIndex=0; accountIndex< [self.modelClubAccounts.accounts count]; accountIndex++)
	{
		[mainFieldArray addObject:[NSString stringWithFormat:@"%@ %@",[[self.modelClubAccounts.accounts objectAtIndex:accountIndex] classType],kMembership_Title]];
	}
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    RSAppDelegate *appDelegate = (RSAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate showUpdatedLoginButton:YES onController:self];
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
    RSMyAccountManager *accountManager  = [RSMyAccountManager sharedInstance];
    accountManager.selectedAccountIndex = indexPath.section;
    DLog(@"Account selected");
    RSMyAccountActivity *selectedAccount = [[RSMyAccountActivity alloc]initWithNibName:@"BaseListViewController" bundle:[NSBundle mainBundle] withSelectedAccount:[self.modelClubAccounts.accounts objectAtIndex:indexPath.section]];
    [self.navigationController pushViewController:selectedAccount animated:YES];
    [selectedAccount release];
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
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [mainFieldArray count];
}
@end
