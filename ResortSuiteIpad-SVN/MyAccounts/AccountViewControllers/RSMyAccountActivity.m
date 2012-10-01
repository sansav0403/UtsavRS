//
//  RSMyAccountActivity.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/6/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSMyAccountActivity.h"
#import "RSAppDelegate.h"
#import "RSProfile.h"
#import "RSAccountBillingPeriodVC.h"
#import "RSAlertView.h"
@implementation RSMyAccountActivity

@synthesize modelSelectedAccount;

-(void)dealloc
{
    [mainFieldArray release];
    [modelSelectedAccount release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        modelSelectedAccount = nil;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withSelectedAccount:(Account *)selectedAccount
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.modelSelectedAccount = selectedAccount;
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
    [self setTitle:Club_MyActivity];
    
    mainFieldArray = [[NSMutableArray alloc] initWithObjects:Club_ViewProfile,Club_ViewStatement,nil];
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
    //Adding selected mask image to the selected row.
    BaseListTableViewCell *cell = (BaseListTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.cellOverlayImageView.image = [UIImage imageNamed:SelectedTableCellBackgroudImage];
    
    DLog(@"table row selected");
    if (self.modelSelectedAccount != nil) {
        if(indexPath.section == ProfileSection) //Profile
        {
            RSProfile *mRSProfile = [[RSProfile alloc] initWithSelectedAccount:self.modelSelectedAccount];
            [self.navigationController pushViewController:mRSProfile animated:YES];
            mRSProfile.navigationItem.title = Club_Profile;
            [mRSProfile release];                
            
        }
        else if(indexPath.section == StatementSection)
        {
            RSAccountBillingPeriodVC *mRSStatementBillingPeriodViewController = [[RSAccountBillingPeriodVC alloc] initWithNibName:@"BaseListViewController" bundle:[NSBundle mainBundle]];
            [self.navigationController pushViewController:mRSStatementBillingPeriodViewController animated:YES];
            [mRSStatementBillingPeriodViewController release];
        }
    }
    else
    {
        RSAlertView *rsAlertView = [[RSAlertView alloc]initWithTitle:@"" andMessage:POPUP_No_MemberShip withDelegate:self cancelButttonTitle:POPUP_Button_Ok otherButtonTitle:nil];
        [rsAlertView release];
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
		case ProfileSection:
			cell.cellImageView.image = [UIImage imageNamed:Club_MyAccount_List_Icon];
			break;
		case StatementSection:
			cell.cellImageView.image = [UIImage imageNamed:Club_ViewStatement_Icon];
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
