//
//  HomeViewController.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/13/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "HomeViewController.h"

#import "RSGroupSelectPeriodVC.h"
#import "RSItinerarySelectPeriodVC.h"
#import "RSAccountListVC.h"
#import "RSStaticNodeVC.h"
#import "RSListViewNode.h"

#import "RSAppDelegate.h"
#import "SplashScreenController.h"

#import "RSMyAccountManager.h"
@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    //self = [super init];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (RSAppDelegate *)[[UIApplication sharedApplication] delegate];
    [baseView.baseBGOverlayImageView removeFromSuperview];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    /*code can be put in the baseview controller to have the all round effect in each controller*/
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

    return [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

#pragma mark - Main Screen button actions
-(IBAction)MyHotelButtonAction:(id)sender
{
    DLog(@"MyHotelButtonAction");
    RSStaticNodeVC *homeViewController1 = [self createStaticControllerOnTabBarWithProjectTree:@"ProjectTree"];
    homeViewController1.title=RSMyHotelTabTitle;
    [self.navigationController pushViewController:homeViewController1 animated:YES];
    [homeViewController1 release];

    
}
#if !defined CLUB_VERSION_TWO_MYACCOUNT
-(IBAction)MyItineraryButtonAction:(id)sender
{
    DLog(@"MyItineraryButtonAction");

	if (!appDelegate.isLoggedIn) {
        [appDelegate showLoginScreen];
        RSItinerarySelectPeriodVC *rsItinerarySelectPeriodVC = [[RSItinerarySelectPeriodVC alloc]initWithNibName:@"BaseListViewController" bundle:[NSBundle mainBundle]];
        rsItinerarySelectPeriodVC.title=SelectDuration_ViewTitle;
        [self.navigationController pushViewController:rsItinerarySelectPeriodVC animated:YES];
        [rsItinerarySelectPeriodVC release];

    }else
    {
        RSItinerarySelectPeriodVC *rsItinerarySelectPeriodVC = [[RSItinerarySelectPeriodVC alloc]initWithNibName:@"BaseListViewController" bundle:[NSBundle mainBundle]];
        rsItinerarySelectPeriodVC.title=SelectDuration_ViewTitle;
        [self.navigationController pushViewController:rsItinerarySelectPeriodVC animated:YES];
        [rsItinerarySelectPeriodVC release];
    }
    
}
#endif

#if defined HOTEL_VERSION
#if !defined HOTEL_VERSION_TWO_BUTTON
#if !defined All_VERSION_SECOND_STATIC
-(IBAction)MyGroupButtonAction:(id)sender
{
    DLog(@"MyGroupButtonAction");
    if (!appDelegate.isLoggedIn) {
        [appDelegate showLoginScreen];
        RSGroupSelectPeriodVC *rsGroupSelectPeriodVC = [[RSGroupSelectPeriodVC alloc]initWithNibName:@"BaseListViewController" bundle:[NSBundle mainBundle]];
        rsGroupSelectPeriodVC.title=SelectDuration_ViewTitle;
        [self.navigationController pushViewController:rsGroupSelectPeriodVC animated:YES];
        [rsGroupSelectPeriodVC release];
    }else
    {
        RSGroupSelectPeriodVC *rsGroupSelectPeriodVC = [[RSGroupSelectPeriodVC alloc]initWithNibName:@"BaseListViewController" bundle:[NSBundle mainBundle]];
        rsGroupSelectPeriodVC.title=SelectDuration_ViewTitle;
        [self.navigationController pushViewController:rsGroupSelectPeriodVC animated:YES];
        [rsGroupSelectPeriodVC release];
    }
    
}
#endif
#endif
#endif

#if defined CLUB_VERSION
//#if !defined CLUB_VERSION_TWO_MYACCOUNT
-(IBAction)MyAccountButtonAction:(id)sender
{
    DLog(@"MyAccountButtonAction");
    DLog(@"MyGroupButtonAction");
    if (!appDelegate.isLoggedIn) {
        [appDelegate showLoginScreen];

    }else
    {//if already logged in the account info is in the sharedAccount Manger
        RSMyAccountManager *accountManager = [RSMyAccountManager sharedInstance];
        if ([accountManager.modelClubAccounts.accounts count] > oneAccount) {
            RSAccountListVC *rsAccoutListVC = [[RSAccountListVC alloc]initWithNibName:@"BaseListViewController" bundle:[NSBundle mainBundle] withClubAccounts:accountManager.modelClubAccounts];
            
            rsAccoutListVC.title=MyAccount_ViewTilte;
            [self.navigationController pushViewController:rsAccoutListVC animated:YES];
            [rsAccoutListVC release];
        }
        else if
            ([accountManager.modelClubAccounts.accounts count] == oneAccount) {
                RSMyAccountActivity *rsAccoutListVC = [[RSMyAccountActivity alloc]initWithNibName:@"BaseListViewController" bundle:[NSBundle mainBundle] withSelectedAccount:[accountManager.modelClubAccounts.accounts objectAtIndex:0]];
                
                rsAccoutListVC.title=MyAccount_ViewTilte;
                [self.navigationController pushViewController:rsAccoutListVC animated:YES];
                [rsAccoutListVC release];
            }
        else
        {
            RSMyAccountActivity *rsAccoutListVC = [[RSMyAccountActivity alloc]initWithNibName:@"BaseListViewController" bundle:[NSBundle mainBundle] ];
            
            rsAccoutListVC.title=MyAccount_ViewTilte;
            [self.navigationController pushViewController:rsAccoutListVC animated:YES];
            [rsAccoutListVC release];
        }
        
    }
    
}
//#endif
#endif

-(IBAction)MyStaticButtonAction:(id)sender
{

    RSStaticNodeVC *secStaticListController = [self createStaticControllerOnTabBarWithProjectTree:@"ProjectTreeSecondStatic"];
    secStaticListController.title = RSStaticTabTitle;
    [self.navigationController pushViewController:secStaticListController animated:YES];
    [secStaticListController release];
}

//Adding the splashScreen and removing when endpopintConfiguration is completed
#pragma mark - splash screen methods
#pragma mark - endPoint configuration delegate Methods

-(void)DisplaySplashScreen
{
    DLog(@"DisplaySplashScreen");
    splashController = [[SplashScreenController alloc]initWithNibName:@"SplashScreenController" bundle:[NSBundle mainBundle]];
    [self presentModalViewController:splashController animated:NO];

}

-(void)removeSplashScreen
{
    [self performSelector:@selector(removeSplashScreenAfterDelay) withObject:self afterDelay:3.0];
}

- (void)removeSplashScreenAfterDelay
{
    splashController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [splashController dismissModalViewControllerAnimated:YES];
}
-(void)endPointConfigurationDone
{
    //remove the splash screen from the view
    DLog(@"end point configuration done,removing the splash screen")
    [self removeSplashScreen];
}

#pragma mark - load static node plist
-(RSStaticNodeVC *) createStaticControllerOnTabBarWithProjectTree:(NSString *) projectTree 
{
	//read the infoplist in to the node;
	NSString *plistPath = [[NSBundle mainBundle] pathForResource:projectTree ofType:@"plist"];
	NSDictionary *dictionary = [[NSDictionary alloc]initWithContentsOfFile:plistPath];
	RSListViewNode* node = [[RSListViewNode alloc]initWithTitle:[dictionary objectForKey:Plist_Title_Key]
													HeaderImage:[dictionary objectForKey:Plist_Header_Image_Key] 
													  IConImage:[dictionary objectForKey:Plist_Thumbnail_Image_Key]
													  NodeArray:[dictionary objectForKey:Plist_DictionaryArray_Key]];
	
	RSStaticNodeVC *firstListController = [[RSStaticNodeVC alloc]initWithNibName:@"BaseListViewController" bundle:[NSBundle mainBundle] withNode:node];
   
    [dictionary release];
    [node release];
    
    return firstListController;
}
@end
