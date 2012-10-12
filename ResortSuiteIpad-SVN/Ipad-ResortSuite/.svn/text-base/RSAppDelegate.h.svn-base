//
//  RSAppDelegate.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/13/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "Reachability.h"
#import "LoginActionSheet.h"
#import "LogoutScreen.h"
#import "RSMyAccountManager.h"
enum iPadOrientation{
    noneOrientation,
    potrait,
    landscape
};
@class RSStaticNodeVC;


enum TabBarTags {
	HOME_TAB,
	MY_HOTEL_CLUB_TAB,
#if !defined CLUB_VERSION_TWO_MYACCOUNT   		//Condition for Club Version with 2 buttons (Static, My Account)
    MY_ITINERARY_TAB,						//Removing the My Itinerary Tab from Tab Bar		
#endif
#if !defined HOTEL_VERSION_TWO_BUTTON
	MY_GROUP_ACCOUNT_TAB,
#endif
	BOOKINGS_TAB
};

@interface RSAppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate,UINavigationControllerDelegate,LoginViewDelegate,LogoutViewDelegate,AccountManagerProtcol>
{
    EndPointConfiguration *endPointConfiguration;   //one time intialization in didFinishLaunchingWithOptions
    //HomeViewController
    HomeViewController *homeViewController;
	UIViewController *homeViewController1;
#if !defined CLUB_VERSION_TWO_MYACCOUNT   		//Condition for Club Version with 2 buttons (Static, My Account)
    UIViewController *homeViewController2;						//Removing the My Itinerary Tab from Tab Bar		
#endif
#if !defined HOTEL_VERSION_TWO_BUTTON
	UIViewController *homeViewController3;
#endif
	UIViewController *homeViewController4;
    
    NSMutableArray *navControllerArray;                 //Mutable array to hold all the controllers for TabController
    BOOL isLoggedIn;    //bool value to store the user's login status.
    
    BOOL isConnectedToInternet;  //bool value to store the network's connection status.
    Reachability *internetReachable;
    
    int currentOrientation; //to store the state of orinetation
}
@property (nonatomic,retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@property(nonatomic) BOOL isLoggedIn;
@property(nonatomic) BOOL isConnectedToInternet;

@property (nonatomic, assign)  int selectedLocBookingType; //store the booking type of hte  selected spa locations
@property (nonatomic) int currentOrientation;


/*!
 @method		addHomeControllerToTabController
 @brief			add HomeController To TabController
 @details		--
 @param			--
 @return		void
 */
- (void)addHomeControllerToTabController;

#if !defined CLUB_VERSION_TWO_MYACCOUNT 

/*!
 @method		addMyItineraryOrMyStatic
 @brief			add MyItinerary Or MyStatic Controller To TabController
 @details		--
 @param			--
 @return		void
 */
- (void)addMyItineraryOrMyStatic;
#endif
#if !defined HOTEL_VERSION_TWO_BUTTON
/*!
 @method		addMyGroupOrMyAccountOrMyStatic
 @brief			add MyGroup Or MyAccount Or MyStatic Controller To TabController
 @details		--
 @param			--
 @return		void
 */
- (void)addMyGroupOrMyAccountOrMyStatic;
#endif

/*!
 @method		addStaticHotelOrClubInformatiomFromPlistNode
 @brief			add Static Hotel Or ClubInformatiom From PlistNode Controller To TabController
 @details		--
 @param			--
 @return		void
 */
- (void)addStaticHotelOrClubInformatiomFromPlistNode;

/*!
 @method		createNavigationControllerWithRootViewController
 @brief			create Navigation Controller With given RootViewController
 @details		--
 @param			(UIViewController *)viewController
 @return		void
 */
- (void)createNavigationControllerWithRootViewController:(UIViewController *)viewController;

/*!
 @method		showUpdatedLoginButton:onController
 @brief			show updated login button on the navigation bar of each controller
 @details		--
 @param			(BOOL)isSignedIn, (UIViewController *) viewController
 @return		void
 */
- (void)showUpdatedLoginButton:(BOOL)isSignedIn onController:(UIViewController *) viewController;

/*!
 @method		createStaticControllerOnTabBarWithProjectTree
 @brief			create Static Controller On TabBar With ProjectTree
 @details		--
 @param			(NSString *)projectTree
 @return		void
 */
- (RSStaticNodeVC *)createStaticControllerOnTabBarWithProjectTree:(NSString *)projectTree;


/*!
 @method		showLoginScreen
 @brief			show Login Screen
 @details		--
 @param			--
 @return		void
 */
- (void)showLoginScreen;

/*!
 @method		showLogoutScreen
 @brief			show Logout Screen
 @details		--
 @param			--
 @return		void
 */
- (void)showLogoutScreen;


/*!
 @method		updateNavControllerWithRootController:AtIndex
 @brief			update NavController With RootController
 @details		change the root view controller of a navigation controller
 @param			--
 @return		void
 */
- (void)updateNavControllerWithRootController:(UIViewController *)viewController AtIndex:(int)tag;

@end
