//
//  HomeViewController.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/13/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EndPointConfiguration.h"

@class RSAppDelegate;
@class SplashScreenController;
@class RSStaticNodeVC;
@interface HomeViewController : BaseViewController <endPointConfigurationDelegate>   
{
    SplashScreenController  *splashController;
    RSAppDelegate           *appDelegate;
}

/*!
 @method		MyHotelButtonAction
 @brief			MyHotel Button Action
 @details		--
 @param			(id)sender
 @return		
 */
-(IBAction)MyHotelButtonAction:(id)sender;

#if !defined CLUB_VERSION_TWO_MYACCOUNT
/*!
 @method		MyItineraryButtonAction
 @brief			MyItinerary Button Action
 @details		--
 @param			(id)sender
 @return		
 */
-(IBAction)MyItineraryButtonAction:(id)sender;
#endif


#if defined HOTEL_VERSION
#if !defined HOTEL_VERSION_TWO_BUTTON
#if !defined All_VERSION_SECOND_STATIC
/*!
 @method		MyGroupButtonAction
 @brief			MyGroup Button Action
 @details		--
 @param			(id)sender
 @return		
 */
-(IBAction)MyGroupButtonAction:(id)sender;
#endif
#endif
#endif

#if defined CLUB_VERSION
/*!
 @method		MyAccountButtonAction
 @brief			MyAccount Button Action
 @details		--
 @param			(id)sender
 @return		
 */
-(IBAction)MyAccountButtonAction:(id)sender;
#endif

/*!
 @method		MyStaticButtonAction
 @brief			MyStatic Button Action
 @details		--
 @param			(id)sender
 @return		
 */
-(IBAction)MyStaticButtonAction:(id)sender;

/*!
 @method		DisplaySplashScreen
 @brief			Display Splash Screen opn start of the application
 @details		--
 @param			
 @return		void
 */
-(void)DisplaySplashScreen;

/*!
 @method		removeSplashScreen
 @brief			remove Splash Screen once endpoint
 @details		--
 @param			(id)sender
 @return		void
 */
-(void)removeSplashScreen;

/*!
 @method		createStaticControllerOnTabBarWithProjectTree
 @brief			create Static Controller On TabBar With ProjectTree name 
 @details		--
 @param			(NSString *) projectTree
 @return		RSStaticNodeVC
 */
-(RSStaticNodeVC *) createStaticControllerOnTabBarWithProjectTree:(NSString *) projectTree;
@end
