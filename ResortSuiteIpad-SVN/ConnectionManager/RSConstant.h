/*
 *  RSConstant.h
 *  ResortSuite
 *
 *  Created by Cybage on 6/1/11.
 *  Copyright 2011 ResortSuite . All rights reserved.
 *
 */

#define Screen_Width				320
#define Screen_Height				480

#define NavigationBar_Height        44
#define ScreenImageView_X			0
#define ScreenImageView_Y			44
#define ScreenImageView_Width		305
#define ScreenImageView_Height		140

#define	HeaderImageHeight			130


#define TableCell_X					0
#define TableCell_Y					(ScreenImageView_Y + ScreenImageView_Height + 5)
#define TableCell_Width				Screen_Width
#define TableCell_Height			220

#define TableCellImageSize			CGRectMake(13, 10, 94, 50)
#define TableCellLableSize			CGRectMake(113, 10, 170, 50)
#define Itinerary_TableSize			CGRectMake(0, 44, 320, 360)
//Images Names
//Nav And TabBar Images
#define RSnavBarImage				@"nav_bar.png"
#define RSTabBarImage				@"tab_bar.png"
#define RSSignOutBtn                @"SignOut_icon.png"
#define RSSignInBtn                 @"SignIn_icon.png"

#define DetailPageSectionBG			@"detailsPg_TextBg_white.jpg"
//Itinerary Image
#define MyItinerary_HI				@"MyItineraryHeader.jpg"
#define GroupItinerary_HI			@"MyGroupHeaderNEW.jpg"
#define MyItinerary_Icon			@"MyItineraryThumbnail.jpg"
#define GroupItinerary_Icon			@"MyGroupThumbnail.jpg"

#define MyItineraryByCategory_HI	@"MyGroupByCategoryImageHeader.jpg"
#define MyItineraryByDate_HI		@"ByDateHeaderImageNEW.jpg"
#define MyItineraryByCategory_Icon	@"MyGroupByCategoryImageThumbnail.jpg"
#define MyItineraryByDate_Icon		@"ByDateThumbnailNEW.jpg"

#define GroupItineraryByCategory_HI		@"MyGroupByCategoryImageHeader.jpg"
#define GroupItineraryByDate_HI			@"ByDateHeaderImageNEW.jpg"
#define GroupItineraryByCategory_Icon	@"MyGroupByCategoryImageThumbnail.jpg"
#define GroupItineraryByDate_Icon		@"ByDateThumbnailNEW.jpg"

//Club Itinerary Images
#define Club_MyItineraryByCategory_HI	@"ByCategoryHeader.jpg"
#define Club_MyItineraryByCategory_Icon	@"ByCategoryThumbnail.jpg"

//Club My Account 
#define Club_MyAccount_HI				@"MyAccountHeader.jpg"
#define Club_MyAccount_List_Icon		@"ProfileThumbnail.jpg"

#define Club_Charges_Icon				@"ChargesThumbnail.jpg"
#define Club_Current_Icon				@"CurrentThumbnail.jpg"
#define Club_Last_Icon					@"LastThumbnail.jpg"
#define Club_Payments_Icon				@"PaymentsThumbnail.jpg"
#define Club_Previous_Icon				@"PreviousThumbnail.jpg"
#define Club_Summery_Icon				@"MyAccount_thumbnail.jpg"
#define Club_ViewStatement_Icon			@"MyAccount_thumbnail.jpg"

//My Itinerary by category icons :
#define Transportation_Icon				@"TransportationThumbnail.jpg"

#define Club_GOLF_Icon					@"GolfThumbnail.jpg"


//My Account Title:
#define Club_MyActivity					@"My Activity"
#define Club_ViewProfile				@"View Profile"
#define Club_ViewStatement				@"View Statement"

#define Club_Profile					@"Profile"

#define Club_Summary					@"Summary"
#define Club_Charges					@"Charges"
#define Club_Payments					@"Payments"

//TableViewCell Images
#define ScreenBackgroudImageMAsk	@"innerPg_bg_positioning-4.png"
#define CellBackgroudImage			@"tableViewRowBGimg.png"
#define CellSelectedBGImage         @"TableCellSelected.png"
#define CellThumbnailMaskImage		@"innerPg_btn_imgPlaceholder.png"
#define CellSelectedThumbnailImage  @"tableViewCell_thumbnail_img_h.png"
#define CellAccessoryImage			@"arrow.png"
#define CellAccessoryImageCircular	@"round-arrow.png"
#define CellAccessoryImageSize		CGRectMake(0, 0, 30, 30)

//Details page
#define	DetailsPage					@"DetailsPage.jpg"

#define dot_width					300

//MainMenu Icons
#define ScreenWhiteOverLay			@"innerPg_bg_whiteOverlay.png"

#if (defined CLUB_VERSION_TWO_MYACCOUNT	|| defined HOTEL_VERSION_TWO_BUTTONS)
	#define MenuButtonLayout				@"MyMenu_btn_TwoButton.png"
	#define MenuButtonLayout_Width			160
	#define MenuButtonLayout_Height			112
	#define MenuButton_Title1_TextSize			17
	#define MenuButton_Title2_TextSize			20
	#define MenuButton_Title1_BoxSize			CGRectMake(0, 85, 160, 17)
	#define MenuButton_Title2_BoxSize			CGRectMake(13 , 82, 85, 20)
#else
	#define MenuButtonLayout				@"MyMenu_btn.png"
	#define MenuButtonLayout_Width			107
	#define MenuButtonLayout_Height			112
	#define MenuButton_Title1_TextSize			15
	#define MenuButton_Title2_TextSize			20
	#define MenuButton_Title1_BoxSize			CGRectMake(13 , 65, 85, 15)
	#define MenuButton_Title2_BoxSize			CGRectMake(13 , 82, 85, 20)
#endif

//Font 
#define FontSize_Date				18
#define FontColor_Red				0.65
#define FontColor_Green				0.50
#define FontColor_Blue				0.33
#define SeparatorImage				@"separator.jpg"
//label cordinates
#define label_x                     10
#define Headerlabel_y               5
#define label_y                     10
#define label_width                 150
#define label_height                20

#define dateLabelcords              CGRectMake(label_x, Headerlabel_y, label_width + 150, label_height)

#define serviceLabelcords           CGRectMake(label_x, label_y +(label_height) , label_width, label_height-5)
#define DyserviceLabelcords         CGRectMake(label_x + 100, label_y +(label_height), label_width + 100, label_height-5)

#define timeLabelcords              CGRectMake(label_x, label_y +(label_height * 2),label_width , label_height-5)
#define DytimeLabelcords            CGRectMake(label_x + 100, label_y +(label_height * 2),label_width + 100, label_height-5)

#define performedByLabelcords       CGRectMake(label_x, label_y +(label_height * 3),label_width , label_height-5)
#define DyperformedByLabelcords     CGRectMake(label_x + 100, label_y +(label_height * 3),label_width , label_height-5)

#define roomLabelcords              CGRectMake(label_x, label_y +(label_height * 4 ),label_width , label_height-5)
#define DyroomLabelcords            CGRectMake(label_x + 100, label_y +(label_height * 4 ),label_width , label_height-5)

#define Labelcords5              CGRectMake(label_x, label_y +(label_height * 5 ),label_width , label_height-5)
#define DyLabelcords5            CGRectMake(label_x + 100, label_y +(label_height * 5 ),label_width , label_height-5)

#define dotLineLabelcords           CGRectMake(label_x, label_y +(label_height * 4+10 ),300 , label_height-5)

#define LisAccountLabel           CGRectMake(15, 25, 300, 20)


//Refresh button
#define	RefreshButton				@"refresh_btn.png"

#define dot_height				1
#define FONT_SIZE				12

//Profile label cords
#define titleLabelCord_x                                0
#define titleLabelCord_y                                45
#define titleLabelCord_width                            320
#define titleLabelCord_height                           35

#define Y_diff                                          20
#define X_diff                                          80
#define Label1Cord_x									15
#define LabelCord_y                                     85 + (labelIndex*Y_diff)
#define LabelCord_width                                 130
#define LabelCord_height                                20
#define LabelCord_TwoLinesDifference                    26


#define Label2Cord_x                                    160
#define ScrollLabel_YCord								44
#define ScrollLabel_Width								(Screen_Width - Label2Cord_x - 10)

//Payment and charges label cords
#define tableHeight                                     (170) // tableHeightOffset already decleared in the code 
#define tableCellLabel_y                                0

//PList dictionary Key constants
#define Plist_Title_Key									@"Title"
#define Plist_Header_Image_Key							@"Header_Image"
#define Plist_Thumbnail_Image_Key						@"Thumbnail_Image"
#define Plist_DictionaryArray_Key						@"NodeArray"
#define Plist_DetailPage_Key							@"DetailPage"

#pragma mark -
#pragma mark Booking cell base label 
//Booking cell base label
#define cellLabelCord                                   headerLabel1Cord
#define cellLabelFontSize                               15

#define DataNotAvailable                                @"<Data not available>"

#pragma mark -
#pragma mark Booking conformation base class 

//confirmationBaseClass macros


#define RSCBCTiltleYcord                                5
#define RSCBCTiltleLabelFont                            14

#define RSCBCMessageXcord                               15
#define RSCBCMessageYcord                               47
#define RSCBCMessageLabelWidth                          300

#define RSCBCMessageLabelFont                           13
#define RSCBCMessageLabelhieght                         20

#define RSCBDynamicLabelXcord                           120
#define RSCBDynamicLabelWidth                           (Screen_Width - RSCBDynamicLabelXcord - 10)
#define RSCBDynamicLabelFont                            12

#define TitleHeaderYcord                                45
#define sepratorImageYcord                              80
#define scrollViewHeight                                260

#define actionButtonYcord                               (scrollViewHeight + 90)

#define actionButtonXcord                               12
#define actionButtonWidth                               296
#define actionButtonHeight                              45


#pragma mark -
#pragma mark Booking Form class 

enum BOOKINGTYPE {
    SINGLE = 1,         //for class/servive
    ALL = 2

    };

#define BOOK_SERVICE_PAGE_CONTROLLER_COUNT_FOR_ALL          2
#define BOOK_SERVICE_PAGE_CONTROLLER_COUNT_FOR_CLASSORSERVICE   1

//#define BOOK_SERVICE_PAGE_CONTROLLER_COUNT                  2

enum Weeday {
    SUNDAY = 1,
    MONDAY,
    TUESDAY,
    WEDNESDAY,
    THRUSDAY,
    FRIDAY,
    SATURDAY
};

#pragma mark -
#pragma mark spa service table view & cell 

#define serviceTableHeight 220
#define searchBarHeight    44

#define NONE                @"None"
#define PM                      @"pm"
#define PM_CAPITAL              @"PM"
#define TIME_INTERVAL           10

#define labelSeprationWidth 10
#define label_YCord 5
#define label1_XCord 10
#define label1Width 140

//#define label2_XCord  label1_XCord + label1Width + labelSeprationWidth
//#define label2Width 110

#define label1_2Height 40


#define label3_XCord    label1_XCord + label1Width +labelSeprationWidth
#define label3Width 50

#define label4_XCord    label3_XCord + label3Width +labelSeprationWidth+20
#define label4Width 40

#define label3_4Height 40


#pragma mark-

#define BookingTable_Y 68

#define InstructionLabelFrame CGRectMake(0, 43, 320, 35)
#define Picker_Height           216
#define PickerFrame CGRectMake(0, 128, Screen_Width, Picker_Height)

#define ButtonImageFrame CGRectMake(15, 350, 286, 45)

#pragma mark- Long Buttons

#define Enabled_Availibility_button         @"enabled_CheckAvailability.png"
#define Disabled_Availibility_button        @"disabled_check_availability.png"

#define Enabled_Select_button               @"enabled_Select.png"
#define Disabled_Select_button              @"disabled_select.png"

#define Enabled_Book_button                 @"enabled_BookNow.png"
#define Disabled_Book_button                @"disabled_book_now.png"

#define Enabled_Done_button                 @"enabled_Done.png"
#define Disabled_Done_button                @"disabled_Done.png"

#define Book_Another_Service_button         @"btn_book_another_service.png"
#define View_Itinerary_button               @"btn_view_itinerary.png"
#define Home_button                         @"btn_home.png"


#pragma mark- Pop up Error messages
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

#define POPUP_Button_Ok                     @"Ok"
#define POPUP_Button_Cancel                 @"Cancel"

#pragma mark - Login Logout screen BtnImage

#define OK_Button_Enabled                   @"btn_ok_enabled.png"
#define OK_Button_Disabled                  @"btn_ok_disabled.png"
#define CANCEL_Button                       @"cancel.png"
// below image in login screen can only be change via the XIB of LoginActionSheet

#define CHANGE_Password_Button              @"change_password.png"
#define FORGOT_password_Button              @"forgot_password.png"
#define LOGOUT_Button                       @"log_out.png"
#define NEWUSER_Button                      @"log_out.png"
#define SIGNIN_Button                       @"sign_in.png"

// Validation variables
#define PASSWORD_REQ_LENGTH                 8

//Tab Icon Images
#pragma Mark  - TabTitle and Tab icon Image

#define RSHotelTabIcon              @"hotel_icon.png"   //currently this icon is used for the static tab icon
#define RSSelfTabIcon               @"self_icon.png"
#define RSBookTabIcon               @"book_icon.png"
#define RSGroupTabIcon              @"group_icon.png"
#define RSStaticTabIcon             @"hotel_icon.png"   //---

#define RSHomeTabTitle                      @"Home"
#define RSHomeTabIcon                       @"home_icon.png"

#define RSMyHotelTabTitle                   @"My Hotel"
#define RSMyClubTabTitle                    @"My Club"

#define RSHotelSelfTabTitle                 @"Self"
#define RSClubItineraryTabTitle             @"My Itinerary"

#define RSHotelMyGroupTabTitle              @"My Group"
#define RSClubMyAccountTabTitle             @"My Account"

#define RSBookingTabTitle                   @"Book"
#define RSStaticTabTitle                    @"My Static"

#pragma Mark  - Application endpoint configuration
#define AppVersion                          @"1.0"
#define EndPointConfigurationUrl            @"https://test.resortsuitemobile.com:2112/RSMobile/testconfig.xml"

#define DeprecatedVersionAlertTitle         @"Update Available"
#define DeprecatedVersionAlertMessage       @"There is a newer version of the application available.Please update to the latest version"

#define DeprecatedStatus                    @"Deprecated"   //checking at the deprecated status via this string,
                                                            //change in case this string changes at the server
