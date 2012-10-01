//
//  RSSpaCustomerConflictCheck.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/1/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSSpaCustomerConflictCheck.h"
#import "ErrorPopup.h"
#import "RSAlertView.h"
#import "DateManager.h"
#import "RSSpaCustomerConflictingBookings.h"


@implementation RSSpaCustomerConflictCheck
@synthesize customerconflictInfoModel;

-(void)dealloc
{
    [customerconflictInfoModel release];
    [super dealloc];
}

-(id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}



-(void) checkForSpaCustomerConflicts:(id) spaServiceOrClass forDateAndTime:(NSString *) dateTime
{
    dateTime = [DateManager convertIntoResponseStringFromSpecificFormatString:dateTime dateFormatStyle:MMMM_d_yyyy_hh_mm_aFormat withTime:YES];
    spaCustConflictinghandler = [[RSSpaCustomerConflictReqResponseHandler alloc]init];
    [spaCustConflictinghandler setDelegate:self];
    [spaCustConflictinghandler checkForSpaCustomerConflicts:spaServiceOrClass forDateAndTime:dateTime];
}

#pragma mark base req handler delegate
-(void)parsingComplete:(id)parserModelData
{	
	if ([parserModelData isKindOfClass:[Result class]]) {
        
		Result *resultError = (Result *) parserModelData;		
		NSString *errorMessage = [NSString stringWithFormat:@"%@", resultError.resultText];
		
		ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
		[errorPopup initWithTitle:errorMessage];
	}	
	else if ([parserModelData isKindOfClass:[RSSpaCustomerConflictingBookings class]]) {	
      
		[self loadSpaCustomerConflictingBookingView:parserModelData];					
	}
	else {
		//Exception handling if WS gives an exception
		ErrorPopup *errorPopup = [ErrorPopup sharedInstance];
		[errorPopup initWithTitle:@"Fault"];
	}	
    [spaCustConflictinghandler release];
}

#pragma mark Show an alert if conflicts exists
-(void) loadSpaCustomerConflictingBookingView:(id) parserModelData
{
   	self.customerconflictInfoModel = (RSSpaCustomerConflictingBookings *) parserModelData;
	
	//Alert the user if there are conflicts exists
  	if ([self.customerconflictInfoModel.spaBookings count] > 0) {

        RSAlertView *rsAlertView = [[RSAlertView alloc]initWithTitle:POPUP_Error andMessage:POPUP_Class_Already_Booked withDelegate:self cancelButttonTitle:POPUP_Button_Ok otherButtonTitle:nil];
        [rsAlertView release];
    	}
 	else {
    DLog(@"There are no conflicts. Create Spa Class Booking call");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NoSpaConflictsNotification" 
   															object:nil];
  	}
}
#pragma mark Action event if conflict exists and user clicks OK
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// Clicked the OK button
	if (buttonIndex == [alertView cancelButtonIndex]) {
		//Navigate to the Date selection view
		[[NSNotificationCenter defaultCenter] postNotificationName:@"OKPressed" 
                                                            object:self.customerconflictInfoModel];
	}
}
@end
