/*
 *  RSTaserBuildConstant.h
 *  ResortSuite
 *
 *  Created by Cybage on 7/19/11.
 *  Copyright 2011 ResortSuite . All rights reserved.
 *
 */
//////////////////////////////////////////////////////////////////////////////
//Titles for Hotel application
//////////////////////////////////////////////////////////////////////////////

//Application Header Name
#define Hotel_Application_Title					@"Brentwood Bay Resort"

//My Hotel Home Screen Buttons Name

#if (defined CLUB_VERSION_TWO_MYACCOUNT	|| defined HOTEL_VERSION_TWO_BUTTONS)
	#define Hotel_Button1_Title1					@"My Hotel"
	#define Hotel_Button1_Title2					@""

	#define Hotel_Button2_Title1					@"My Itinerary"
	#define Hotel_Button2_Title2					@""
#else
	#define Hotel_Button1_Title1					@"My"
	#define Hotel_Button1_Title2					@"Hotel"

	#define Hotel_Button2_Title1					@"My"
	#define Hotel_Button2_Title2					@"Itinerary"
#endif

#if defined (ALL_VERSIONS_SECOND_STATIC)

	#define Hotel_Button3_Title1					@"My"
	#define Hotel_Button3_Title2					@"Static"

#else

	#define Hotel_Button3_Title1					@"My"
	#define Hotel_Button3_Title2					@"Group"

#endif



//Hotel Information
#define Hotel_Map_Address						@"849 Verdier Avenue, Victoria, BC V8M 1C5"		

//////////////////////////////////////////////////////////////////////////////
// Hotel Images
//////////////////////////////////////////////////////////////////////////////

//Background images
#if defined(HOTEL_VERSION)
#define Application_SplashScreen				@"BrentwoodMain640x960.jpg"

#define Application_HomeScreen					@"BrentwoodMain640x960.jpg"
#define Application_BackgroundScreen			@"BackgroundImageFinal.jpg"
#endif

//Main Screen Icons
#define Hotel_MyHotel_Icon						@"MyHotelFrontPageThumbnail.jpg"
#define Hotel_MyItinerary_Icon					@"MyItineraryThumbnail.jpg"
#define Hotel_MyGroup_Icon						@"MyGroupFrontPageThumbnail.jpg"

//Itinerary Icons
#define Hotel_Dining_Icon						@"DiningThumbnail.jpg"
#define Hotel_SPA_Icon							@"SpaThumbnail.jpg"
#define Hotel_GOLF_Icon							@"GolfThumbnail.jpg"


//////////////////////////////////////////////////////////////////////////////
//HTML files for Hotel application
//////////////////////////////////////////////////////////////////////////////
#define Hotel_Map_Direction_HTML				@"Directions.html"


/////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//Titles for Club application
//////////////////////////////////////////////////////////////////////////////

//Application Header Name
#define Club_Application_Title					@"Washington Athletic Club"

//My Club Home Screen Buttons Name

#if (defined CLUB_VERSION_TWO_MYACCOUNT	|| defined HOTEL_VERSION_TWO_BUTTONS)
	#define Club_Button1_Title1						@"My Club"
	#define Club_Button1_Title2						@""
		
	#define Club_Button2_Title1						@"My Itinerary"
	#define Club_Button2_Title2						@""
#else
	#define Club_Button1_Title1						@"My"
	#define Club_Button1_Title2						@"Club"

	#define Club_Button2_Title1						@"My"
	#define Club_Button2_Title2						@"Itinerary"
#endif	

#if defined (ALL_VERSIONS_SECOND_STATIC)
	#define Club_Button3_Title1						@"My"
	#define Club_Button3_Title2						@"Static"
#else
	#if (defined CLUB_VERSION_TWO_MYACCOUNT)
		#define Club_Button3_Title1						@"My Account"
		#define Club_Button3_Title2						@""
	#else	
		#define Club_Button3_Title1						@"My"
		#define Club_Button3_Title2						@"Account"
	#endif
#endif

//Itinerary
#define Club_Dining_Title						@"Dining"
#define Club_SPA_Title							@"Spa"
#define Club_Athletics_Title					@"Athletics"

//Club Information
#define Club_Map_Address						@"1325 6th Ave. Seattle, WA 98101"		
//////////////////////////////////////////////////////////////////////////////
// Club Images
//////////////////////////////////////////////////////////////////////////////


#if defined(CLUB_VERSION)

	#define Application_SplashScreen			@"FrontSplashRS.jpg"

	#define Application_HomeScreen				@"BackgroundImage.jpg"
	#define Application_BackgroundScreen		@"BackgroundImage.jpg"
#endif

//Club MainMenu Icons
#define RefrenceImageForSize                       @"MyMenu_01.png"
#define Club_MyClub_Icon						@"MyClubThumbnail.jpg"
#define Club_MyItinerary_Icon					@"MyItineraryThumbnail.jpg"

#if defined (ALL_VERSIONS_SECOND_STATIC)
	#define Club_MyAccount_Icon						@"AmenitiesThumbnailNEW.jpg"
#else
	#define Club_MyAccount_Icon						@"MyAccount_thumbnail.jpg"
#endif

//Itinerary
#define Club_Dining_Icon						@"DiningThumbnail.jpg"
#define Club_SPA_Icon							@"SpaThumbnail.jpg"

#pragma mark - Itinerary title
//Itinerary
#define Hotel_Dining_Title						@"Dining"
#define Hotel_SPA_Title							@"Spa"
#define Hotel_GOLF_Title						@"Golf"
//My Itinerary Title :
#define Hotel_Transportation_Title              @"Transportation"
#define Hotel_Itinerary_Title                   @"Hotel"
