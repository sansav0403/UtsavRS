//
//  RSBookingConfirmedVC.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/1/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSAppDelegate.h"
@interface RSBookingConfirmedVC : BaseViewController
{

}
@property(nonatomic, retain) IBOutlet UILabel *BookingConfirmedMessageLbl;

/*!
 @method		BookAnotherButtonAction
 @brief			Book Another Button Action
 @details		jump to the booking view
 @param			(id)sender
 @return		
 */
-(IBAction)BookAnotherButtonAction:(id)sender;

/*!
 @method		HomeViewButtonAction
 @brief			jump to the home view
 @details		--
 @param			(id)sender
 @return		
 */
-(IBAction)HomeViewButtonAction:(id)sender;

/*!
 @method		veiwItineraryButtonAction
 @brief			jump to the itinerary view 
 @details		--
 @param			(id)sender
 @return		
 */
-(IBAction)veiwItineraryButtonAction:(id)sender;
@end
