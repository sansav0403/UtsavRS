//
//  RSAppDelegate.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/13/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSAppDelegate.h"
//------------------basic tab viewcontrollers-
#if !defined CLUB_VERSION_TWO_MYACCOUNT  
#if !defined ALL_VERSION_SECONDSTATIC_MYACCOUNT//Condition for Club Version with 2 buttons (Static, My Account)
#import "RSItinerarySelectPeriodVC.h"						//Removing the My Itinerary Tab from Tab Bar		
#endif
#endif
#if defined HOTEL_VERSION
#if !defined HOTEL_VERSION_TWO_BUTTON
#if !defined All_VERSION_SECOND_STATIC
#import "RSGroupSelectPeriodVC.h"
#endif
#endif
#endif
#if defined CLUB_VERSION
#import "RSAccountListVC.h"
#import "RSMyAccountManager.h"
#import "RSMyAccountActivity.h"
#endif

#import "RSStaticNodeVC.h"
#import "RSListViewNode.h"
#import "RSNavigationViewController.h"
//--------------------
//----5th tab gallery inplace of booking
#import "RSBookMenuVC.h"
#import "MapViewController.h"   //used in the nav delegate method
//---------------

#import "DateManager.h"


@implementation RSAppDelegate

#define AccountTabPostion_forTwoButton 2
#define AccountTabPostion_forThreeButton 3

//-----sample-----------------------------------------------------------
#define sampleDateFormat                    @"yyyy-MM-ddhhmmss"
//#define kServerRespondedDateFormat          @"yyyy-MM-ddhhmmss"
#define sampleDateFormatOld                 @"EEEE, MMMM d, yyyy hh:mm a"
//----------------------------------------------------------------------

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize isLoggedIn;
@synthesize isConnectedToInternet;

@synthesize selectedLocBookingType;
@synthesize currentOrientation;
- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [endPointConfiguration release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Checking Network Reachability by adding Notification Listener and starting the notifier to check the status.
    currentOrientation = noneOrientation;
    
    endPointConfiguration = [[EndPointConfiguration alloc]init];    //one time intialization/starts configuring always in appp did become active
    navControllerArray = [[NSMutableArray alloc]init];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    self.isLoggedIn = [prefs boolForKey:LoggedInKey];
    
    // Override point for customization after application launch.
    //-----------------add View controllers to tabcontroller array--------------------
    [self addHomeControllerToTabController];
    
    
	[self addStaticHotelOrClubInformatiomFromPlistNode];
    
#if !defined CLUB_VERSION_TWO_MYACCOUNT   		//Condition for Club Version with 2 buttons (Static, My Account)
    
    [self addMyItineraryOrMyStatic];
    
#endif
    
#if !defined HOTEL_VERSION_TWO_BUTTON
	[self addMyGroupOrMyAccountOrMyStatic];
#endif
    
    
    RSBookMenuVC *homeViewController4g = [[RSBookMenuVC alloc] initWithNibName:@"RSBaseBookVC" bundle:[NSBundle mainBundle]];
    homeViewController4g.title=Book_ViewTilte;
    homeViewController4g.tabBarItem.image=[UIImage imageNamed:RSBookTabIcon];    
    homeViewController4g.tabBarItem.title = RSBookingTabTitle;
    [self createNavigationControllerWithRootViewController:homeViewController4g];
    [homeViewController4g release];
    
    
    [self.tabBarController setViewControllers:navControllerArray animated:YES];
    [navControllerArray release];
    
    //--------------------------------------------------------------------------------
    
    [self.window addSubview:self.tabBarController.view];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [homeViewController DisplaySplashScreen];       //display splash screen
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    /*
     get endpoint configuration file
     parse the same and match with the hardcoded vesion in the App
     get the end point url and fetch service from it
     */
    DLog(@"applicationDidBecomeActive");
    
    [endPointConfiguration setWebConfiguration];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

#pragma mark - TabBarController Delegate Methods
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController 
{
    RSNavigationViewController *navController = (RSNavigationViewController *)viewController;
    
    DLog(@"no of controllers in navController = %@", [[[navController viewControllers]objectAtIndex:0]class]);
#if !defined CLUB_VERSION_TWO_MYACCOUNT 
#if !defined ALL_VERSION_SECONDSTATIC_MYACCOUNT
    if ( ([[[navController viewControllers]objectAtIndex:0]isKindOfClass:[RSItinerarySelectPeriodVC class]]) )
        
    { //check for book class int the last check
        if (!(self.isLoggedIn)) {
            [self showLoginScreen];
            
        }
    }
#endif
#endif    
    
#if defined CLUB_VERSION  
    if ([[[navController viewControllers]objectAtIndex:0]isKindOfClass:[RSMyAccountActivity class]] || [[[navController viewControllers]objectAtIndex:0]isKindOfClass:[RSAccountListVC class]]) {
        if (!(self.isLoggedIn)) {
            [self showLoginScreen];
        }
    }
    
#endif    
    
#if defined HOTEL_VERSION
#if !defined HOTEL_VERSION_TWO_BUTTON
#if !defined All_VERSION_SECOND_STATIC
    if (([[[navController viewControllers]objectAtIndex:0]isKindOfClass:[RSGroupSelectPeriodVC class]])) {
        if (!(self.isLoggedIn)) {
            [self showLoginScreen];
            
        }
    }
#endif
#endif    
#endif 
    //for booking class
    if (([[[navController viewControllers]objectAtIndex:0]isKindOfClass:[RSBookMenuVC class]])) {
        if (!(self.isLoggedIn)) {
            [self showLoginScreen];
            
        }
    }
    return YES;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
    switch (tabBarController.selectedIndex) {
        case HOME_TAB:
        {
            DLog(@"HOME_TAB");
            [self.tabBarController setSelectedIndex:HOME_TAB];
            RSNavigationViewController *navController = [[self.tabBarController viewControllers] objectAtIndex:HOME_TAB];
            [navController popToRootViewControllerAnimated:NO];
        }
            break;
        case MY_HOTEL_CLUB_TAB:
        {
            DLog(@"MY_HOTEL_CLUB_TAB");
            [self.tabBarController setSelectedIndex:MY_HOTEL_CLUB_TAB];
            RSNavigationViewController *navController = [[self.tabBarController viewControllers] objectAtIndex:MY_HOTEL_CLUB_TAB];
            [navController popToRootViewControllerAnimated:NO];
        }
            break;
#if !defined CLUB_VERSION_TWO_MYACCOUNT
        case MY_ITINERARY_TAB:
        {
            DLog(@"MY_ITINERARY_TAB");
            [self.tabBarController setSelectedIndex:MY_ITINERARY_TAB];
            RSNavigationViewController *navController = [[self.tabBarController viewControllers] objectAtIndex:MY_ITINERARY_TAB];
            [navController popToRootViewControllerAnimated:NO];
        }
            break;
#endif
#if !defined HOTEL_VERSION_TWO_BUTTON
        case MY_GROUP_ACCOUNT_TAB:
        {
            //# if defined HOTEL_VERSION
            DLog(@"MY_GROUP_ACCOUNT_TAB");
            [self.tabBarController setSelectedIndex:MY_GROUP_ACCOUNT_TAB];
            RSNavigationViewController *navController = [[self.tabBarController viewControllers] objectAtIndex:MY_GROUP_ACCOUNT_TAB];
            [navController popToRootViewControllerAnimated:NO];
            //for the account need to reload the tab view at the this index
            //  #endif
# if defined CLUB_VERSION   //to reload every time the account tab is pressed
            //call account manager
            BaseListViewController *accountController = (BaseListViewController *)[[navController viewControllers]objectAtIndex:0];
            [accountController startLoadingAnimation];
            RSMyAccountManager *accountManager = [RSMyAccountManager sharedInstance];   //shared instance can help us to decide
            //which vc to load via the account button in the homescreen
            [accountManager setDelegate:self];
            [accountManager fetchUsersAccountsListAndDetails];
            
#endif
        }
            break;
#endif
        case BOOKINGS_TAB:
        {
            DLog(@"BOOKINGS_TAB");
            [self.tabBarController setSelectedIndex:BOOKINGS_TAB];
            RSNavigationViewController *navController = [[self.tabBarController viewControllers] objectAtIndex:BOOKINGS_TAB];
            [navController popToRootViewControllerAnimated:NO];
        }
            break;
            
        default:
            break;
    }
}

- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray *)viewControllers
{
    
}
- (void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed 
{
    
}
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
    
}

-(void)addHomeControllerToTabController
{//AllVersionSecondStatic
    //for Hotel version
#if defined HOTEL_VERSION
#if defined HOTEL_VERSION_TWO_BUTTON
    homeViewController = [[HomeViewController alloc]initWithNibName:@"TwoButtonMyItinerary" bundle:[NSBundle mainBundle]];
#elif defined All_VERSION_SECOND_STATIC
    homeViewController = [[HomeViewController alloc]initWithNibName:@"AllVersionSecondStatic" bundle:[NSBundle mainBundle]];
#else
    homeViewController = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:[NSBundle mainBundle]];
#endif
#endif
    
    //for club version    
#if defined CLUB_VERSION
#if defined CLUB_VERSION_TWO_MYACCOUNT
    homeViewController = [[HomeViewController alloc]initWithNibName:@"TwoButtonMyAccount" bundle:[NSBundle mainBundle]];
#elif defined ALL_VERSION_SECONDSTATIC_MYACCOUNT
    homeViewController = [[HomeViewController alloc]initWithNibName:@"SecondStaticMyAccount" bundle:[NSBundle mainBundle]];
#else
    homeViewController = [[HomeViewController alloc]initWithNibName:@"ClubHomeViewController" bundle:[NSBundle mainBundle]];
#endif
#endif
    
    homeViewController.title=RSHomeTabTitle;
    homeViewController.tabBarItem.image=[UIImage imageNamed:RSHomeTabIcon];
    [endPointConfiguration setDelegate:homeViewController];
    
    [self createNavigationControllerWithRootViewController:homeViewController];  
    [homeViewController release];
}

#if !defined HOTEL_VERSION_TWO_BUTTON
-(void)addMyGroupOrMyAccountOrMyStatic
{
    //for Hotel version
#if defined HOTEL_VERSION
#if defined All_VERSION_SECOND_STATIC
    homeViewController3 = [self createStaticControllerOnTabBarWithProjectTree:kProjectTreeSecondStatic];
    homeViewController3.title=RSStaticTabTitle;
    homeViewController3.tabBarItem.image=[UIImage imageNamed:RSStaticTabIcon];
#else
    homeViewController3 = [[RSGroupSelectPeriodVC alloc]initWithNibName:@"BaseListViewController" bundle:[NSBundle mainBundle]];
    homeViewController3.title=SelectDuration_ViewTitle;
    homeViewController3.tabBarItem.image=[UIImage imageNamed:RSGroupTabIcon];
    homeViewController3.tabBarItem.title = RSHotelMyGroupTabTitle;
#endif
#endif
    
    //for club version    
#if defined CLUB_VERSION
    homeViewController3 = [[RSMyAccountActivity alloc]initWithNibName:@"BaseListViewController" bundle:[NSBundle mainBundle]];
    homeViewController3.title=RSClubMyAccountTabTitle;  //check for title of the view
    homeViewController3.tabBarItem.image=[UIImage imageNamed:RSGroupTabIcon];
    homeViewController3.tabBarItem.title = RSClubMyAccountTabTitle;
#endif
    [self createNavigationControllerWithRootViewController:homeViewController3];
    [homeViewController3 release];
}
#endif

#if !defined CLUB_VERSION_TWO_MYACCOUNT
-(void)addMyItineraryOrMyStatic
{
#if defined HOTEL_VERSION
    homeViewController2 = [[RSItinerarySelectPeriodVC alloc]initWithNibName:@"BaseListViewController" bundle:[NSBundle mainBundle]];
    homeViewController2.title=SelectDuration_ViewTitle;//RSHotelSelfTabTitle;
    homeViewController2.tabBarItem.image=[UIImage imageNamed:RSSelfTabIcon];
    homeViewController2.tabBarItem.title = RSHotelSelfTabTitle;
#endif
    
#if defined CLUB_VERSION
#if defined ALL_VERSION_SECONDSTATIC_MYACCOUNT
    homeViewController2 = [self createStaticControllerOnTabBarWithProjectTree:kProjectTreeSecondStatic];
    homeViewController2.title=RSStaticTabTitle;
    homeViewController2.tabBarItem.image=[UIImage imageNamed:RSStaticTabIcon];
#else
    homeViewController2 = [[RSItinerarySelectPeriodVC alloc]initWithNibName:@"BaseListViewController" bundle:[NSBundle mainBundle]];
    homeViewController2.title=SelectDuration_ViewTitle;
    homeViewController2.tabBarItem.image=[UIImage imageNamed:RSSelfTabIcon];
    homeViewController2.tabBarItem.title = RSClubItineraryTabTitle;
#endif
#endif
    [self createNavigationControllerWithRootViewController:homeViewController2];
    [homeViewController2 release];
}
#endif

-(void)addStaticHotelOrClubInformatiomFromPlistNode
{
#if defined HOTEL_VERSION
	homeViewController1 = [self createStaticControllerOnTabBarWithProjectTree:kProjectTree];
    homeViewController1.title=RSMyHotelTabTitle;
    homeViewController1.tabBarItem.image=[UIImage imageNamed:RSHotelTabIcon];
#endif
#if defined CLUB_VERSION
    homeViewController1 = [self createStaticControllerOnTabBarWithProjectTree:kProjectTree];
    homeViewController1.title=RSMyClubTabTitle;
    homeViewController1.tabBarItem.image=[UIImage imageNamed:RSHotelTabIcon];
#endif
    [self createNavigationControllerWithRootViewController:homeViewController1];
    [homeViewController1 release];
    
}

-(void)createNavigationControllerWithRootViewController:(UIViewController *)viewController
{
    RSNavigationViewController *navcontroller = [[RSNavigationViewController alloc]initWithRootViewController:viewController];
    [navcontroller setDelegate:self];
    [navControllerArray addObject:navcontroller];
}

#pragma mark - navigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self showUpdatedLoginButton:YES onController:viewController];
    //also change the back button title to back;
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:BackButtonTitle style:UIBarButtonItemStylePlain target:nil action:nil];
	viewController.navigationItem.backBarButtonItem = item;
	[item release];
}

-(void) showUpdatedLoginButton:(BOOL) isSignedIn onController:(UIViewController *) viewController
{    
    UIButton *signInOutButton = [UIButton buttonWithType:UIButtonTypeCustom];
	RSAppDelegate *appDelegate = (RSAppDelegate *)[[UIApplication sharedApplication] delegate];
	if (!appDelegate.isLoggedIn) {//if (isSignedIn) { for logged out state
		[signInOutButton setBackgroundImage:[UIImage imageNamed:RSSignInBtn] forState:UIControlStateNormal];
	}
	else if(appDelegate.isLoggedIn){//else {
		[signInOutButton setBackgroundImage:[UIImage imageNamed:RSSignOutBtn] forState:UIControlStateNormal];
	}
	
	signInOutButton.frame = SignInButtonRect;
	[signInOutButton addTarget:self action:@selector(signInOutButtonAction:) forControlEvents:UIControlEventTouchUpInside];
	
	UIBarButtonItem *modalButton = [[UIBarButtonItem alloc] initWithCustomView:signInOutButton];
	
    if ( !([viewController isKindOfClass:[MapViewController class]]) ) // && [ResortSuiteAppDelegate getContactUsIcon]
    {
        [viewController.navigationItem setRightBarButtonItem:modalButton animated:YES];
    }
	[modalButton release];
    
}

-(void)signInOutButtonAction:(id)sender
{
    DLog(@"signInOutButtonAction");
    /*show login or logout screen based on status of isLoggedIn*/
    if(self.isLoggedIn)
    {   //IF USER IS LOOGED IN SHOW LOGOUT OPTIONS
        [self showLogoutScreen];
    }
    else
    {   //IF USER IS LOGGED OUT SHOW LOGIN OPTIONS
        [self showLoginScreen];
    }
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

#pragma mark - LoginActions Delegatemethods
-(void)showLoginScreen
{
    LoginActionSheet *login = [[LoginActionSheet alloc]initWithNibName:@"LoginActionSheet" bundle:[NSBundle mainBundle]];
    [login setDelegate:self];
    RSNavigationViewController *loginNavcontroller = [[RSNavigationViewController alloc]initWithRootViewController:login];
    [self.tabBarController presentModalViewController:loginNavcontroller animated:YES];
    [login release];
    [loginNavcontroller release];
}

-(void)ActionSheet:(LoginActionSheet *)actionSheet buttonSelectedAtindex:(int)buttonIndex
{   //called only for login cancel button
    [self.tabBarController setSelectedIndex:0];
    RSNavigationViewController *navController = [[self.tabBarController viewControllers] objectAtIndex:0];
    [navController popToRootViewControllerAnimated:NO];
    [actionSheet dismissModalViewControllerAnimated:YES];
}
-(void)ActionSheet:(LoginActionSheet *)actionSheet isLoginSuccesful:(BOOL)loginStatus
{
    if (loginStatus) { //success
        //[actionSheet dismissModalViewControllerAnimated:YES];
#if defined CLUB_VERSION
        //        if ([self.tabBarController selectedIndex] == MY_GROUP_ACCOUNT_TAB) //account manager should be called every time
        //the user does the login screen.
        {
            //start the animation on the account activty vc
            RSNavigationViewController *navController = (RSNavigationViewController *)[[self.tabBarController viewControllers]objectAtIndex:MY_GROUP_ACCOUNT_TAB];
            
            BaseListViewController *controller = [[navController viewControllers] objectAtIndex:0];
            [controller startLoadingAnimation];
            
            //
            
            //call account manager
            RSMyAccountManager *accountManager = [RSMyAccountManager sharedInstance];   //shared instance can help us to decide
            //which vc to load via the account button in the homescreen
            [accountManager setDelegate:self];
            [accountManager fetchUsersAccountsListAndDetails];
            
        }
#endif
    }
    else
    {
        //show alert view in the login handler in fail
        //also set the navigation view controller to index zero
        RSNavigationViewController *navController = [[self.tabBarController viewControllers] objectAtIndex:HOME_TAB];
        [navController popToRootViewControllerAnimated:NO];
        [self.tabBarController setSelectedIndex:HOME_TAB];
    }
    [actionSheet dismissModalViewControllerAnimated:YES];   //dismiss @last and also this is comman line
}

//----------
-(void)showLogoutScreen
{
    LogoutScreen *logout = [[LogoutScreen alloc]initWithNibName:@"LogoutScreen" bundle:[NSBundle mainBundle]];
    [logout setDelegate:self];
    RSNavigationViewController *logoutNavcontroller = [[RSNavigationViewController alloc]initWithRootViewController:logout];
    [self.tabBarController presentModalViewController:logoutNavcontroller animated:YES];
    [logout release];
    [logoutNavcontroller release];
}

-(void)logoout:(LogoutScreen *)actionSheet buttonSelectedAtindex:(int)buttonIndex
{
    switch (buttonIndex) {
        case Logout_ok:
            self.isLoggedIn = NO;
            //same for hotel and club
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            // saving a email address and password
            [prefs setObject:@"" forKey:EmailAddressKey];
            [prefs setObject:@"" forKey:PasswordKey];
            [prefs setObject:@"" forKey:CustomerIdKey];
            [prefs setObject:@"" forKey:CustomerGUIDKey];
            [prefs setObject:@"" forKey:@"StartDate"];
            [prefs setObject:@"" forKey:@"EndDate"];
            [prefs setObject:@"" forKey:AuthorizationIdKey];
            [prefs setObject:@"" forKey:GuaranteedKey];
            [prefs setBool:self.isLoggedIn forKey:LoggedInKey];
            [prefs synchronize];
            
            [self.tabBarController setSelectedIndex:0];
            RSNavigationViewController *navController = [[self.tabBarController viewControllers] objectAtIndex:0];
            [navController popToRootViewControllerAnimated:NO];
            [actionSheet dismissModalViewControllerAnimated:YES];
            
            break;
            
        default:
            break;
    }
    
}


#pragma mark - AccountManager Delegate Methods
-(void)updateTheAccountViewControllerWithController:(UIViewController *)accountController
{
    accountController.tabBarItem.image=[UIImage imageNamed:RSGroupTabIcon];
    accountController.tabBarItem.title = RSClubMyAccountTabTitle;
#if !defined CLUB_VERSION_TWO_MYACCOUNT
    [self updateNavControllerWithRootController:accountController AtIndex:AccountTabPostion_forThreeButton];
#else
    [self updateNavControllerWithRootController:accountController AtIndex:AccountTabPostion_forTwoButton];//2
#endif
}

-(void)errorInFetchingUsersAccountInfo
{
    //stil load the acout acctivitycontroller
    //i.e is loaded by default
    //handle nil account in there
}
-(void)updateNavControllerWithRootController:(UIViewController *)viewController AtIndex:(int)tag
{
    RSNavigationViewController* navController = [[RSNavigationViewController alloc] initWithRootViewController:viewController];
    [navController setDelegate:self];
    NSMutableArray *tabArray = [[NSMutableArray alloc] initWithArray:self.tabBarController.viewControllers];
    [tabArray removeObjectAtIndex:tag];
    
    [tabArray insertObject:navController atIndex:tag];
    
    self.tabBarController.viewControllers = tabArray;    
    
    [tabArray removeAllObjects];
    [tabArray release];    
    
    [navController release];    
    navController = nil;
}
@end
