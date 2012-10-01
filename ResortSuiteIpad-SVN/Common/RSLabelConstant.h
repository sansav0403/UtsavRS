//
//  RSLabelConstant.h
//  Ipad-ResortSuite
//
//  Created by Cybage on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//#import <Foundation/Foundation.h>
//
//@protocol RSLabelConstant <NSObject>
//
//@end

#pragma mark- Pop up Error messages

#define POPUP_ConnectionError               @"Error in connection"
#define POPUP_ConnectionError_text          @"Please Check your network connection"
#define POPUP_Error                         @""

#define POPUP_Sign_Out                      @"Sign Out"
#define POPUP_Sign_Out_Text                 @"Do you want to sign out?"
#define POPUP_Offline_Mode                  @"Offline Mode"
#define POPUP_Offline_Content               @"A network connection cannot be detected.  Offline content may be out of date."			
#define POPUP_Offline_Content_Unavailable   @"A network connection cannot be detected. Content not available in offline mode."			

#define POPUP_Meeting_Data_Unavailable      @"You have no group meetings to display"


#define POPUP_Invalid_Email                 @"Invalid Email Address and/or Password"
#define POPUP_Invalid_Request               @"Invalid request. Missing reservation or customer credentials."
#define POPUP_Invalid_GuestPin              @"Invalid guest pin for PMSFolioId"
#define POPUP_Invalid_FolioId               @"Invalid PMSFolioId"
#define POPUP_Start_End_Date                @"End date should be greater than Start date"
#define POPUP_Enter_Date                    @"Please enter start date or/and end date"
#define POPUP_No_Bookings                   @"There are no bookings for the selected date range"
#define POPUP_Server_Unavailable            @"Server not available. Please try again later."

#define POPUP_No_Network                    @"No network available"
#define POPUP_Select_Service                @"Please select service first"
#define POPUP_Select_Date                   @"Please select date first"
#define POPUP_Activity_Data_Unavailable     @"No data available for requested activity"
#define POPUP_Service_Unavailable           @"Requested service is not available. Please select an alternative day or time."
#define POPUP_Class_Already_Booked          @"You are already booked for a class or service during the requested date and time. Please select another date and/or time."
#define POPUP_Change_Search                 @"No available appointments. Change your search criteria and try again."

#define POPUP_Tee_Times                     @"No tee times available"
#define POPUP_Tee_Times_Text                @"Please select another time"

#define POPUP_Booking_Unavailable           @"You have no bookings to display"
#define POPUP_No_MemberShip                 @"No Memebership found for the Guest"
#define POPUP_Button_Ok                     @"Ok"
#define POPUP_Button_Cancel                 @"Cancel"

//#define kPOPUP_Guarantee_Required       @"Please contact us with your credit card information in order to guarantee your booking first."
//Updated Guarantee Require Message
#define kPOPUP_Guarantee_Required           @"We cannot complete your booking at this time as your account is not cinfigured with a valid guarantee. \n\nPlease contact us so we can update your account."

/********************************************************************/
#pragma Mark - Error Codes
#define kGuaranteeRequiredErrorId    1010


/********************************************************************/


#pragma mark - user registration screen Titles and alert messages validation strings

#define ALERT_OK_TITLE                      @"OK"
#define CHANGE_PASSWORD_VIEW_TITLE          @"Change Password"
#define FORGOT_PASSWORD_VIEW_TITLE          @"Forgot Password"
#define New_user_viewtitle                  @"New User"
#define VerifyEmail_viewtitle               @"Verify Email"
// Validation variables
#define PASSWORD_REQ_LENGTH                 8

#define alertTitleForInvalidText            @"Enter valid Information"
#define alertMessageForInvalidText          @"Field cannot be empty"

#define alertTitleForEmptyGender            @""
#define alertMessageForEmptyGender          @"Please enter your Gender"

#define alertTitleForValidSalutation        @""
#define alertMessageForValidSalutation      @"Please enter appropriate salutation"

#define alertTitleForInvalidEmailAddress            @"Invalid Email Address"
#define alertMessageForInvalidEmailAddress          @"Enter a valid email address"

#define alertTitleForUnmatchedEmail                 @"Unmatched Email Address"
#define alertMessageForUnmatchedEmail               @"Enter the same email address for confirmation"

#define alertTitleForImproperPassord                @"Invalid Password"
#define alertMessageForImproperPassord              @"Password must be of atleast %d length" //%d represents the requird length of the password

#define alertTitleForUnmatchedPassword          @"Password Not Confirmed"
#define alertMessageForUnmatchedPassword        @"Enter the same password as new password"

#define alertTitleForAtleastOnePhoneNumber      @"Contact number"
#define alertMessageForAtleastOnePhoneNumber    @"Please enter atleast one contact number"

#define alertMessageForPassWordResset @"You will receive an email with your new password"
#define alertTitleForUserCreated      @""
#define alertMessageForUserCreated @"Your account has been successfully created"

#pragma Mark  - TabTitle and Tab icon Image

#define RSHomeTabTitle                      @"Home"

#define RSMyHotelTabTitle                   @"My Hotel"
#define RSMyClubTabTitle                    @"My Club"

#define RSHotelSelfTabTitle                 @"Self"
#define RSClubItineraryTabTitle             @"My Itinerary"

#define RSHotelMyGroupTabTitle              @"My Group"
#define RSClubMyAccountTabTitle             @"My Account"

#define RSBookingTabTitle                   @"Book"
#define RSStaticTabTitle                    @"My Static"
// view controller title
#define SelectDuration_ViewTitle            @"select Duration"
#define RSGallaryTitle                      @"Gallery"
#pragma Mark - Account Views Title
enum accountCount
{
    zeroAccount = 0,
    oneAccount = 1
};

#define AccountList_ViewTilte                   @"Account's List"
#define Club_MyActivity                         @"My Activity"
#define MyAccount_ViewTilte                     @"My Account"
#define ChargeDetail_ViewTilte                  @"Charge Detail"
#define BillingPeriod_ViewTilte                 @"Billing Periods"
#define BillingPeriod_Current                   @"Current"
#define BillingPeriod_Last                      @"Last"
#define BillingPeriod_Previous                  @"Previous"

#define StatementOptions_ViewTilte              @"Statement Options"
#define PreviousBilling_ViewTilte               @"Previous Billing Periods"
#define Club_ViewProfile                        @"View Profile"
#define Club_ViewStatement                      @"View Statement"

#define Club_Profile                            @"Profile"

#define Club_Summary                            @"Summary"
#define Club_Charges                            @"Charges"
#define Club_Payments                           @"Payments"

//Summary page screen text
#define AccountSummaryDetailHeader                  @"Account Details"
#define AccountSummaryHeader                        @"Account Summary"
#define AccountAgedBalanceHeader                    @"Aged Balance Summary"

#define AccountNumber                               @"Account #:"
#define AccountType                                 @"Account Type:"
#define AccountQwner                                @"Account Owner:"
#define AccountMemberShipCount                      @"Member #:"
#define AccountMemberShipID                         @"Member Id:"
#define AccountMemberShipLevel                      @"Member Level:"
#define AccountStatementperiod                      @"Statement Period:"
#define AccountpreviousBalance                      @"Previous Balance:"
#define AccountPayments                             @"Payments:"
#define AccountNewCharges                           @"New Charges:"
#define AccountBalance                              @"Account Balance:"
#define AccountCurrentBalance                       @"Current Balance:"
#define AccountCurrent30dayBalance                  @"30 Day Balance:"
#define AccountCurrent60dayBalance                  @"60 Day Balance:"
#define AccountCurrent90dayBalance                  @"90 Day Balance:"

//profile screen

#define AccountDetailHeader                     @"Account Details"
#define CurrentMembershipHeader                 @"Current Memberships"
#define AccountCustomerHeader                   @"Account Customers"
#define AccountNoStaticText                     @"Account #:"
#define AccountTypeStaticText                   @"Account Type:"
#define AccountOwnerStaticText                  @"Account Owner:"
#define AccountMemberNoStaticText               @"Member #:"
#define AccountMemberIDStaticText               @"Member Id:"
#define AccountMemberLevelStaticText            @"Member Level:"
#define AccountAddressStaticText                @"Address:"
#define AccountPhoneStaticText                  @"Phone:"
#define AccountEmailAddressStaticText           @"Email Address:"
#define MembershipType                          @"Type:"
#define MembershipName                          @"Member:"
#define MembershipStatus                        @"Status:"
#define MembershipEffectiveDate                 @"Effective Date:"
#define MembershipExpiryDate                    @"Expiry Date:"
#define AccountName                             @"Name:"
#define AccountMemberShipLevel                  @"Member Level:"

//charge and payment
#define Charge_PaymentDateTitle         @"Date"
#define Charge_PaymentAmountTitle       @"Amount"
#define ChargeDescriptionTitle          @"Description"
#define PaymentTypeTitle                @"Payment Type"

#define TotalChargeText     @"Total Charge"
#define TotalPaymentText    @"Total Payment"
//account statement option labels
#define AccOption_Chargesection_Title       @"Account Charges"
#define AccOption_Paymentsection_Title      @"Account Payments"
#define AccOption_Accountnum                @"Account #:"
#define AccOption_AccountType               @"Account Type:"
#define AccOption_AccountOwner              @"Account Owner:"
#define AccOption_StatementPeriod           @"Statement Period:"


#pragma Mark - My Itinerary/Group Views Title

#define MyItitnerary_ViewTite                   @"My Itinerary"
#define AllFutureBooking_CellTitle              @"All Future Bookings"
#define SpecificDate_CellTitle                  @"Specific Dates"
#define SelectDates_ViewTitle                   @"Select Dates"

#define ItineraryCategory_ByDate                @"By Date"
#define ItineraryCategory_ByCategory            @"By Category"
#define ItineraryCategory_ByAll                 @"All"
#pragma Mark - My Group Views Title
#define MyGroup_ViewTilte                       @"My Group"
//Duration selection in group and Itinerary
#define DurationSelection_Start     @"Starts"
#define DurationSelection_Ends      @"Ends"

#pragma Mark - Booking Views Title
#define NoBookingTitle   @""
#define NoBookingMessage @"We are currently not accepting mobile reservation at this time."

#define Book_ViewTilte                        @"Book Menu"
#define GolfLocation_ViewTilte                @"Golf Locations"
#define GolfCourse_ViewTilte                  @"Golf Course"
#define BookGolf_ViewTilte                    @"Book Golf"

#define ClassActivityCellText                 @"Class/Activity"
//spa booking form cell text
#define SpaBookingFormService       @"Service"
#define SpaBookingFormDate          @"Date"
#define SpaBookingFormTime          @"Time"
#define SpaBookingFormStafGender    @"Pref. Staff Gender"
#define SpaBookingFormStaff         @"Pref. Staff"
//spa service confirmation view text
#define SpaConfirmationView_Service         @"Service:"
#define SpaConfirmationView_Date            @"Date:"
#define SpaConfirmationView_Time            @"Time:"
#define SpaConfirmationView_Duration        @"Duration(min):"
#define SpaConfirmationView_Price           @"Price:"
#define SpaConfirmationView_Description     @"Description:"
//Golf Booking Form
#define GolfBookingFormDate                     @"Date" 
#define GolfBookingFormPrefTeeTime              @"Pref. Tee Time" 
#define GolfBookingFormNoOfPlayer               @"No. of Player"
#define ConfirmGolfBookDetailheader             @"Confirm Detail And Book Now"
//#define ConfirmBooking_ViewTilte              @"Confirm Booking"
#define pleaseSelectText                      @"Please select"
#define searchResultText                      @"  Search Results"
#define SpaAvailableTimeText                  @"The requested time slot is not available,  Please select the following alternate time."
//golf select players
#define NoOfPlayerCellText          @"No Of Players"
#define DefaultNoOfPlayers          @"2"

#pragma mark - Login Option text

#define Gender_Male                 @"Male"
#define Gender_Female               @"Female"
#define Gender_No_answer            @"No answer"

#define Salutation_Mr                @"Mr."
#define Salutation_Ms                @"Ms."
#define Salutation_Mrs               @"Mrs."
#define Salutation_Miss              @"Miss."
#define Salutation_Dr                @"Dr."
#define Salutation_Mr_Mrs            @"Mr. & Mrs."


#pragma mark - Description view Texts
#define DescClass_activityText          @"Class/Activity :"
#define DescDescriptionText             @"Description :"
#define DescNoOfClassText               @"# of Classes :"
#define DescStartTimeText               @"Start Time :"
#define DescDurationText                @"Duration(min) :"
#define DescPriceText                   @"Price :"
#define DescClientInstruction           @"Client Instructions :"

//event / spa description text
#define DescLocationText                @"Location :"
#define DescServiceText                 @"Service :"
#define DescTimeText                    @"Time :"
#define DescPerformedByText             @"Performed By :"
#define DescRoomText                    @"Room :"
//golf description
#define DescGolfCourseText              @"Course :"
#define DescGolfteeTimeText             @"Tee-Time :"

//dining desc
#define DescDininigVenueText             @"Venue :"
#define DescDetailText                   @"detail :"

//Departure description
#define DescDepartureLocationText           @"Departure Location :"
#define DescDepartureTimeText               @"Departure Time :"
#define DescArrivalLocationText             @"Arrival Location :"
#define DescArrivalTimeText                 @"Arrival Time :"
