/*
 *  RSConstant.h
 *  ResortSuite
 *
 *  Created by Cybage on 6/1/11.
 *  Copyright 2011 ResortSuite . All rights reserved.
 *
 */

#define Screen_Width				768
#define Screen_Height				1004

#define Hotel_BGImage               @"HotelBG.jpg"
#define Club_BGImage                @"ClubBG.jpg"

#define Screen_Width_L				1004
#define Screen_Height_L				768

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
#define BackButtonTitle             @"Back"
#define RSnavBarImage				@"nav_bar.png"
#define RSTabBarImage				@"tab_bar.png"
#define RSSignOutBtn                @"SignOut_icon.png"
#define RSSignInBtn                 @"SignIn_icon.png"
#define SignInButtonRect            CGRectMake(0, 0, 30, 30)

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
#define SelectedTableCellBackgroudImage @"selected-imgPlaceholder-h.png"    //Background image visible when the cell is selected on sub class of baselist view

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
#define Club_Transportation_Icon		@"TransportationThumbnail.jpg"
#define Club_GOLF_Icon					@"GolfThumbnail.jpg"


//My Account Title:



//TableViewCell Images
#define ScreenBackgroudImageMAsk	@"innerPg_bg_positioning-4.png"
#define CellBackgroudImage			@"tableViewRowBGimg.png"
#define CellSelectedBGImage         @"TableCellSelected.png"
#define CellThumbnailMaskImage		@"innerPg_btn_imgPlaceholder.png"
#define CellSelectedThumbnailImage  @"tableViewCell_thumbnail_img_h.png"
#define CellAccessoryImage			@"arrow.png"
#define CellAccessoryImageRect      CGRectMake(0, 0, 18, 15)
#define CellAccessoryImageCircular	@"round-arrow.png"
#define CellAccessoryImageSize		CGRectMake(0, 0, 117,30)

#define CellAccessoryImageCircularListcell  @"round-arrow-listCell.png"
#define CellAccessoryImageSizeListCell      CGRectMake(0, 0, 30, 30)

//Details page
#define	DetailsPage					@"DetailsPage.jpg"

#define dot_width					700

//MainMenu Icons
#define ScreenWhiteOverLay			@"inner_overlay_withoutWindow_landscape.png"

#if (defined CLUB_VERSION_TWO_MYACCOUNT	|| defined HOTEL_VERSION_TWO_BUTTON)
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
#define FONT_SIZE				14

//Profile label cords
#define titleLabelCord_x                                0
#define titleLabelCord_y                                45
#define titleLabelCord_width                            320
#define titleLabelCord_height                           35

#define Y_diff                                          20
#define X_diff                                          250//150
#define Label1Cord_x									35  //15
#define LabelCord_y                                     85 + (labelIndex*Y_diff)
#define LabelCord_width                                 150
#define LabelCord_height                                20
#define LabelCord_TwoLinesDifference                    36    //26


#define Label2Cord_x                                    180 //160
#define ScrollLabel_YCord								44
#define ScrollLabel_Width								(Screen_Width - Label2Cord_x - 10)

//Payment and charges label cords
#define tableHeight                                     (270) //170 tableHeightOffset already decleared in the code 
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


//#define RSCBCTiltleYcord                                5
//#define RSCBCTiltleLabelFont                            14
//
//#define RSCBCMessageXcord                               15
//#define RSCBCMessageYcord                               47
//#define RSCBCMessageLabelWidth                          300
//
//#define RSCBCMessageLabelFont                           13
//#define RSCBCMessageLabelhieght                         20
//
//#define RSCBDynamicLabelXcord                           120
//#define RSCBDynamicLabelWidth                           (Screen_Width - RSCBDynamicLabelXcord - 10)
//#define RSCBDynamicLabelFont                            12
//
#define TitleHeaderYcord                                45
#define sepratorImageYcord                              80
//#define scrollViewHeight                                260
//
//#define actionButtonYcord                               (scrollViewHeight + 90)
//
//#define actionButtonXcord                               241
//#define actionButtonWidth                               296
//#define actionButtonHeight                              45


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
enum ArrayIndex {
    indexZero = 0,
    indexOne = 1,
    indexTwo = 2
};
#pragma mark -
#pragma mark spa service table view & cell 

#define serviceTableHeight 220
#define searchBarHeight    44

#define NONE                    @"None"
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



#pragma mark - Login Logout screen BtnImage and title

#define kLoginTitle                         @"Log In"
#define kLogOutTitle                        @"Log Out"
#define OK_Button_Enabled                   @"btn_ok_enabled.png"
#define OK_Button_Disabled                  @"btn_ok_disabled.png"
#define CANCEL_Button                       @"cancel.png"
// below image in login screen can only be change via the XIB of LoginActionSheet

#define CHANGE_Password_Button              @"change_password.png"
#define FORGOT_password_Button              @"forgot_password.png"
#define LOGOUT_Button                       @"log_out.png"
#define NEWUSER_Button                      @"log_out.png"
#define SIGNIN_Button                       @"sign_in.png"

#pragma mark - user registration screen validation strings

#define ValidationPhoneNumberString         @"^\\+(?:[0-9] ?){6,14}[0-9]$"
#define ValidationEmailAddresString         @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"


//Tab Icon Images
#pragma Mark  - Tab icon Image

#define RSHomeTabIcon               @"home_icon.png"
#define RSHotelTabIcon              @"hotel_icon.png"   //currently this icon is aslo used for the static tab icon
#define RSSelfTabIcon               @"self_icon.png"
#define RSBookTabIcon               @"book_icon.png"
#define RSGroupTabIcon              @"group_icon.png"   //also fro accounts
#define RSStaticTabIcon             @"hotel_icon.png"   //---


#pragma Mark  - Application endpoint configuration
//#define AppVersion                          @"1.0"
#define AppVersion                          @"1.1"//updated on July 27 

//----------Temporary commented and new code added below--------------------------------------
#define EndPointConfigurationUrl            @"https://test.resortsuitemobile.com:2112/RSMobile/testconfig.xml"

//#define EndPointConfigurationUrl  @"https://206.223.188.227:2112/RSMobile/testconfig.xml"
//--------------------------------------------------------------------------------------------
#define DeprecatedVersionAlertTitle         @"Update Available"
#define DeprecatedVersionAlertMessage       @"There is a newer version of the application available.Please update to the latest version"

#define DeprecatedStatus                    @"Deprecated"   //checking at the deprecated status via this string,
//change in case this string changes at the server
#define NotConfigured_tile                      @"error in connection"
#define NotConfigured_Message                   @"Application Not Configured"

#pragma mark - booking confirmation mesasge based on Guaranteed
#define GuaranteeStatusValueForYes          @"Y"
#define GuaranteeStatusValueForNo           @"N"
#define GuaranteedBookingMessage            @"Booking Confirmed - Your booking is successful. To make another booking, please select another from below:"
#define UnGuaranteedBookingMessage          @"A tentative booking has been made for you. To confirm your booking kindly contact us to provide us with your credit card information to guarantee your booking."




#pragma Mark - MapView URL and title
#define GoogleMap_url           @"http://maps.google.com/maps/geo?q=%@&output=csv&sensor=false&key=1"

#pragma Mark - UserDefaultKey
#define EmailAddressKey            @"EmailAddress"
#define PasswordKey                @"Password"
#define CustomerIdKey              @"CustomerId"
#define CustomerGUIDKey            @"CustomerGUID"
#define AuthorizationIdKey         @"AuthorizationId"
#define GuaranteedKey              @"Guaranteed"
#define LoggedInKey                @"LoggedIn"
#define endPointUrlKey             @"endPointUrl"
#define configStatusKey            @"configStatus"

#pragma Mark - Font Size
#define FontOfSize16    16
#define FontOfSize17    17
#define FontOfSize18    18
#define FontOfSize15    15
#define FontOfSize14    14
#define FontOfSize13    13
#define FontOfSize12    12



//----------------------------------------

#pragma mark - date selection and booking cell Selection images
#define BookTableColor          @"tableColor.png"
#define option_arrow_image      @"1option_no_arrow.png"
#define top_arrow_image         @"top_no_arrow.png" //also used in ititnerary/Group select date
#define bottom_arrow_image      @"bottom_no_arrow.png"
#define mid_arrow_image         @"mid_no_arrow.png"

#define accessoryBlankImage      @"arrow_blank_img.png"

#pragma Mark - itinerary_GroupSelectdate
#define TopNoArrow_white            @"top_no_arrow_white.png"





#pragma mark - Date Formats

#define MMMM_dd_yyyy_hh_mm_aFormat          @"MMMM dd, yyyy hh:mm a"
//#define MMMM_dd_yyyy_hh_mm_aFormat          @"YYYY-MM-DDHH24MISS"
#define yyyy_MM_ddFormat                    @"yyyy-MM-dd"
#define dd_MMM_yyyyFormat                   @"dd-MMM-yyyy"
#define dd_MM_yyyyFormat                    @"dd-MM-yyyy"
#define MMMM_d_yyyyFormat                   @"MMMM d, yyyy"
#define MMMM_d_YYYYFormat                   @"MMMM d, YYYY"
#define MMMM_dFormat                        @"MMMM d"
#define yyyy_MM_ddHHmmssFormat              @"yyyy-MM-ddHHmmss"
#define HH_mm_aFormat                       @"HH:mm a"
#define MMMM_dd_yyyyFormat                  @"MMMM dd, yyyy"
#define hh_mm_aFormat                       @"hh:mm a"
#define EEEE_MMMM_d_yyyyFormat              @"EEEE, MMMM d, yyyy"
#define EEEE_MMMM_d_yyyy_hh_mm_aFormat      @"EEEE, MMMM d, yyyy hh:mm a"
#define MMMM_d_yyyy_hh_mm_aFormat           @"MMMM d, yyyy hh:mm a"
#define HH_mmFormat                         @"HH:mm"
#define kCurrentTimeFormat                  @"hh:mm a"

//-----For Date format changes------------------------------------------
#define kServerRespondedDateTimeFormat       @"yyyy-MM-ddHHmmss"
#define kServerRespondedDateFormat           @"yyyy-MM-dd"
#define kServerRespondedTimeFormat           @"HHmmss"
//----------------------------------------------------------------------


#pragma mark - List Table Cell BAckGround color

#define ListCellUnSelectedBG                @"unselectedBGListCell.png"
#define ListCellSelectedBG                  @"selectedBGListCell.png"
#define ListCellUnselectedImageHolder       @"unseslected-imgPlaceholder.png"

#pragma mark - mainScreen Button Layout Images

#define MyMenuLeftButtonOverlay             @"MyMenu_btn_lft.png"
#define MyMenuMidButtonOverlay              @"MyMenu_btn_mid.png"
#define MyMenuRightButtonOverlay            @"MyMenu_btn_rgt.png"


// Project Tree
#define kProjectTree  [RSLocalizationManager localizedFileForKey:@"ProjectTree"]//load kProjectTree file
#define kProjectTreeSecondStatic  [RSLocalizationManager localizedFileForKey:@"ProjectTreeSecondStatic"]//load ProjectTreeSecondStatic file


// Project Tree
#define kMap  [RSLocalizationManager localizedStringForKey:@"kMap"]//Map
#define kLocations  @"Locations"//[RSLocalizationManager localizedStringForKey:@"kLocations"]//Locations
#define kInfo  @"Info"//[RSLocalizationManager localizedStringForKey:@"kInfo"]//Info
#define kInfoTitle  @"InfoTitle"//[RSLocalizationManager localizedStringForKey:@"kInfoTitle"]//InfoTitle
#define kGallery  [RSLocalizationManager localizedStringForKey:@"kGallery"]//Gallery
