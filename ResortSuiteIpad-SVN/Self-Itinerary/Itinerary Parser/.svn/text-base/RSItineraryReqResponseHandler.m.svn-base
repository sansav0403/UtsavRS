//
//  RSItineraryReqResponseHandler.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/23/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSItineraryReqResponseHandler.h"

#import "RSMyItineraryModel.h"
#import "RSGroupEvents.h"
#import "RSFolio.h"
#import "DateManager.h"

@implementation RSItineraryReqResponseHandler

@synthesize guestItinerary;
@synthesize isError;
@synthesize errorResult;
@synthesize isAuthCustomer;
@synthesize authCustomer;



-(void)dealloc
{
    [guestItinerary release];
	[errorResult release];
	[authCustomer release];

    [super dealloc];
}

-(id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void) authenticateCustomerRequestWithEmail:(NSString *) EmailAddress Password:(NSString *) Password
{
	//Auth Customer request
	NSString *requestBody = [NSString stringWithFormat: 
							 @"<rsap:AuthCustomerRequest>"
                             "<Source>IPAD</Source>"
							 "<EmailAddress>%@</EmailAddress>"
							 "<Password>%@</Password>"
							 "</rsap:AuthCustomerRequest>",EmailAddress, Password];
	
	
	NSMutableURLRequest *request = [self RequestWithSoapMessageBody:requestBody];
    [self.connectionManager startConnectionWithRequest:request];
}

-(void) fetchGuestItineraryForHotelWithStartDate: (NSString *) startdate EndDate:(NSString *) enddate
{ 
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *requestBody = [NSString stringWithFormat: 
							 @"<rsap:FetchGuestItineraryRequest>"
                             "<Source>IPAD</Source>"
							 "<CustomerId>%@</CustomerId>"
							 "<CustomerGUID>%@</CustomerGUID>"
							 "<EmailAddress>%@</EmailAddress>"
							 "<Password>%@</Password>"
							 "<StartDate>%@</StartDate>"
							 "<EndDate>%@</EndDate>"
							 "</rsap:FetchGuestItineraryRequest>",
							 [prefs objectForKey:CustomerIdKey], 
							 [prefs objectForKey:CustomerGUIDKey],
							 [prefs objectForKey:EmailAddressKey], 
							 [prefs objectForKey:PasswordKey],
							 startdate, enddate];	
	NSMutableURLRequest *request = [self RequestWithSoapMessageBody:requestBody];
    [self.connectionManager startConnectionWithRequest:request];
}

-(void) fetchGroupItineraryForHotelWithStartDate: (NSString *) startdate EndDate:(NSString *) enddate;
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString *requestBody = [NSString stringWithFormat: 
							 @"<rsap:FetchGuestItineraryRequest>"
                             "<Source>IPAD</Source>"
							 "<CustomerId>%@</CustomerId>"
							 "<CustomerGUID>%@</CustomerGUID>"
							 "<EmailAddress>%@</EmailAddress>"
							 "<Password>%@</Password>"
							 "<StartDate>%@</StartDate>"
							 "<EndDate>%@</EndDate>"
							 "</rsap:FetchGuestItineraryRequest>",
							 [prefs objectForKey:CustomerIdKey], 
							 [prefs objectForKey:CustomerGUIDKey],
							 [prefs objectForKey:EmailAddressKey], 
							 [prefs objectForKey:PasswordKey],
							 startdate, enddate];
  	NSMutableURLRequest *request = [self RequestWithSoapMessageBody:requestBody];
    [self.connectionManager startConnectionWithRequest:request];
    
}

#pragma mark - ConnectionManager delegate Methods
-(void)connectionFinishedWithData:(NSData *)data
{
    NSString *recievedData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    DLog(@"FetchGuestItineraryRequest recieved data = %@", recievedData);
    [recievedData release];
    [self parse:data];
}

-(void)connectionFailedWithError:(NSError *)error
{
    self.resultError = error;
}

#pragma mark - parser methods
- (void) parse:(NSData*)data
{
	NSXMLParser *guestItineraryParser = [[NSXMLParser alloc] initWithData:data];
	guestItineraryParser.delegate = self;
	[guestItineraryParser parse];
	[guestItineraryParser release];
}

#pragma mark Parsing delegate

- (void)parserDidStartDocument:(NSXMLParser *)parser { 	
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qualifiedName
   attributes:(NSDictionary *)attributeDict{
    
	if ([elementName isEqualToString:@"FetchGuestItineraryResponse"] ||			//For Hotel
		[elementName isEqualToString:@"n:FetchGuestItineraryResponse"] ||		//For Hotel
		[elementName isEqualToString:@"AuthCustomerResponse"] ||				//For Club
		[elementName isEqualToString:@"soapenv:Fault"])					
	{	
		isError = YES;
	}
	if ([elementName isEqualToString:@"tns:FetchGuestItineraryResponse"]) {
		isError	= NO;
		if (self.guestItinerary) {
			//[self.guestItinerary release];
			self.guestItinerary = nil;
		}
		guestItinerary = [[RSMyItineraryModel alloc] init];
		self.guestItinerary.PMSFolioId = [[attributeDict valueForKey:@"PMSFolioId"] intValue];				
	}
	else if ([elementName isEqualToString:@"rsapp:AuthCustomerResponse"]) {		//For Club
		isAuthCustomer = YES;
		if (self.authCustomer) {
			//[self.authCustomer release];
			self.authCustomer = nil;
		}
		authCustomer = [[AuthCustomer alloc] init];
		return;
	}
	else if ([elementName isEqualToString:@"Result"]) {
		
		if ([[attributeDict valueForKey:@"value"] isEqualToString:@"FAIL"]) {
			isError = YES;
		}
		
		if (!isError) {
			
			if (!isAuthCustomer) {
				if (self.guestItinerary.result) {
				
                    self.guestItinerary.result = nil;
				}
                Result *resultObj = [[Result alloc] init];
				guestItinerary.result = resultObj;
                [resultObj release];
				
				if ([[attributeDict valueForKey:@"value"] isEqualToString:@"SUCCESS"]) {
					self.guestItinerary.result.resultValue= SUCCESS;
				}
				else {
					self.guestItinerary.result.resultValue = FAIL;
				}
			}
			else {
				if (self.authCustomer.authResult) {
    
                    self.authCustomer.authResult = nil;
				}
                Result *resultObj = [[Result alloc] init];
				authCustomer.authResult = resultObj;
                [resultObj release];
				
				if ([[attributeDict valueForKey:@"value"] isEqualToString:@"SUCCESS"]) {
					self.authCustomer.authResult.resultValue= SUCCESS;
				}
				else {
					self.authCustomer.authResult.resultValue = FAIL;
				}
			}
		}
		else {
			if (self.errorResult) {
				self.errorResult = nil;
			}
			errorResult = [[Result alloc] init];
			self.errorResult.resultValue = FAIL;
		}
	}
	
	//----------------------- GuestBookings ---------------------------------
	
	else if ([elementName isEqualToString:@"GuestBookings"]) {
		if (self.guestItinerary.guestBookings) {
            self.guestItinerary.guestBookings = nil;
		}
        RSGuestBookings *guestBooking = [[RSGuestBookings alloc] init];
		guestItinerary.guestBookings = guestBooking;
        [guestBooking release];
		return;	
	}
	else if ([elementName isEqualToString:@"Folio"]) {
		
		if (!currentAppType) {
			//currentAppType = [[NSMutableString alloc] init];//2. hence dont need to allocate
		}
		currentAppType = [attributeDict valueForKey:@"app"];    //1. now current apptype is pointing to an autoreleased object string
		
		if ([currentAppType isEqualToString:@"Hotel"]) 
		{
			if (hotelFolio) {
				[hotelFolio release];
				hotelFolio = nil;
			}
			hotelFolio = [[HotelFolio alloc] init];
			hotelFolio.appType = Hotel;			
		}
		else if ([currentAppType isEqualToString:@"Spa"]) 
		{
			if (spaFolio) {
				[spaFolio release];
				spaFolio = nil;
			}
			spaFolio = [[SpaFolio alloc] init];
			spaFolio.appType = Spa;
		}
		else 
		{
			if (folio) {
				[folio release];
				folio = nil;
			}
			folio = [[RSFolio alloc] init];
			
			if ([currentAppType isEqualToString:@"Golf"]) 
			{			
				folio.appType = Golf;
			}
			else if ([currentAppType isEqualToString:@"Dining"]) 
			{			
				folio.appType = Dining;
			}
			else if ([currentAppType isEqualToString:@"Transportation"]) 
			{			
				folio.appType = Transportation;
			}	
		}
	}
	else if ([elementName isEqualToString:@"Customer"]) {
		return;
	}
	
	//----------------------- GroupEvents ---------------------------------
	
	else if ([elementName isEqualToString:@"GroupEvents"]) {
		isGroupEvent = YES;
		
		if (guestItinerary.groupEvents) {
            guestItinerary.groupEvents = nil;
		}
        RSGroupEvents *groupEventsObj = [[RSGroupEvents alloc] init];
		guestItinerary.groupEvents = groupEventsObj;
        [groupEventsObj release];
		return;	
	}
	else if ([elementName isEqualToString:@"GroupEvent"]) {
		if (groupEvent) {
			[groupEvent release];
			groupEvent = nil;
		}
		groupEvent = [[GroupEvent alloc] init];
		return;	
	}
	
	//--------------------------to remove unwanted allocation of "value" object---------------------------------
	else if ([elementName isEqualToString:@"soapenv:Envelope"]|| [elementName isEqualToString:@"soapenv:Body"]) {
        return;
    }
    //-----------------------------------------------------------
	else {
       
		value =[[NSMutableString alloc] init];
	}
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	
	if(value && string && [string length]>0)
	{
		[value appendString:string];
	}
}


-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{   
	if ([elementName isEqualToString:@"tns:FetchGuestItineraryResponse"] ||		//For Hotel
		[elementName isEqualToString:@"FetchGuestItineraryResponse"] ||			//For Hotel
		[elementName isEqualToString:@"n:FetchGuestItineraryResponse"] ||		//For Hotel
		[elementName isEqualToString:@"AuthCustomerResponse"] ||				//For Club
		[elementName isEqualToString:@"rsapp:AuthCustomerResponse"])			//For Club
	{
		return;
	}
	else if ([elementName isEqualToString:@"Result"]) {
		return;	
	}	
	else if ([elementName isEqualToString:@"Text"]) {
		if (!isError) {
			if (!isAuthCustomer) {
				self.guestItinerary.result.resultText = value;	
			}
			else {
				self.authCustomer.authResult.resultText = value;
			}	
		}
		else {
			self.errorResult.resultText = value;			
		}
	}
	
	
	//----------------------- GuestBookings ---------------------------------
	
	else if ([elementName isEqualToString:@"GuestBookings"]) {
		return;	
	}
	else if ([elementName isEqualToString:@"Folio"]) {
		if ([currentAppType isEqualToString:@"Golf"] || 
			[currentAppType isEqualToString:@"Dining"] || 
			[currentAppType isEqualToString:@"Transportation"]) 
		{
			[self.guestItinerary.guestBookings.folios addObject:folio];
			[folio release];
			folio = nil;
		}
		else if ([currentAppType isEqualToString:@"Hotel"])  {
			[self.guestItinerary.guestBookings.folios addObject:hotelFolio];
			[hotelFolio release];
			hotelFolio = nil;
		}
		else if ([currentAppType isEqualToString:@"Spa"])  {
			[self.guestItinerary.guestBookings.folios addObject:spaFolio];
			[spaFolio release];
			spaFolio = nil;
		}
		
		return;
	}
	else if ([elementName isEqualToString:@"AppFolioId"]) {
		if([currentAppType isEqualToString:@"Hotel"])
		{
			hotelFolio.appFolioId = [value intValue];
		}
		else if([currentAppType isEqualToString:@"Spa"])
		{
			spaFolio.appFolioId = [value intValue];
		}
		else 
		{
			folio.appFolioId = [value intValue];
		}
		
	}
	else if ([elementName isEqualToString:@"GroupFolioId"]) {		
		hotelFolio.groupFolioId = [value intValue];
	}
	else if (!isGroupEvent && [elementName isEqualToString:@"Location"]) {
		if([currentAppType isEqualToString:@"Hotel"])
		{
			hotelFolio.location = value;
		}
		else if([currentAppType isEqualToString:@"Spa"])
		{
			spaFolio.location = value;
		}
		else 
		{
			folio.location = value;
		}
		
	}
	else if ([elementName isEqualToString:@"Customer"]) {
		return;
	}
	else if ([elementName isEqualToString:@"CustomerId"]) {
		folio.customer.customerId = [value intValue];
	}
	else if ([elementName isEqualToString:@"Salutation"]) {
		
		if ([value isEqualToString:@"Mr."]) {
			folio.customer.salutation = Mr;
		}	
		else if ([value isEqualToString:@"Ms."]) {
			folio.customer.salutation = Ms;
		}
		else if ([value isEqualToString:@"Mrs."]) {
			folio.customer.salutation = Mrs;
		}
		else if ([value isEqualToString:@"Miss."]) {
			folio.customer.salutation = Miss;
		}
		else if ([value isEqualToString:@"MrMrs"]) {
			folio.customer.salutation = MrMrs;
		}
	}
	else if ([elementName isEqualToString:@"FirstName"]) {
		folio.customer.firstName = value;
	}
	else if ([elementName isEqualToString:@"LastName"]) {
		folio.customer.lastName = value;
	}
	else if ([currentAppType isEqualToString:@"Dining"] && [elementName isEqualToString:@"StartDate"]) {
        NSString *convertedDateStr = [DateManager convertStandardDateFormateStringFromServerResponseString:value withTime:YES];
		folio.startDate = convertedDateStr;
		folio.formatedStartDate = [self stringToDate:convertedDateStr withTime:YES];
	}	
	else if ([currentAppType isEqualToString:@"Dining"] && [elementName isEqualToString:@"Details"]) {
		folio.details = value;
	}	
	else if ([elementName isEqualToString:@"ArrivalDate"]) {
		if([currentAppType isEqualToString:@"Hotel"])
		{
            NSString *convertedDateStr = [DateManager convertStandardDateFormateStringFromServerResponseString:value withTime:NO];
			hotelFolio.startDate = convertedDateStr;
			hotelFolio.formatedStartDate = [self stringToDate:convertedDateStr withTime:NO];
		}
	}
	else if ([elementName isEqualToString:@"DepartureDate"]) {
		if([currentAppType isEqualToString:@"Hotel"])
		{
            NSString *convertedDateStr = [DateManager convertStandardDateFormateStringFromServerResponseString:value withTime:NO];
			hotelFolio.finishDate = convertedDateStr;
			hotelFolio.formatedFinishDate = [self stringToDate:convertedDateStr withTime:NO];
		}
	}
	else if ([elementName isEqualToString:@"NumAdults"]) {
		hotelFolio.numAdults = [value intValue];
	}
	else if ([elementName isEqualToString:@"NumYouth"]) {
		hotelFolio.numYouth = [value intValue];
	}
	else if ([elementName isEqualToString:@"NumChildren"]) {
		hotelFolio.numChildren = [value intValue];
	}
	else if ([elementName isEqualToString:@"TotalGuests"]) {
		hotelFolio.totalGuests = [value intValue];
	}
	else if ([currentAppType isEqualToString:@"Hotel"] && [elementName isEqualToString:@"RoomNumber"]) {
		hotelFolio.roomNumber = value;	
	}
	else if ([currentAppType isEqualToString:@"Spa"] && [elementName isEqualToString:@"RoomNumber"]) {
		spaFolio.room = value;
	}	
	else if ([elementName isEqualToString:@"Details"]) {
		if ([currentAppType isEqualToString:@"Spa"]) {
			spaFolio.details = value;
		}
		else if	([currentAppType isEqualToString:@"Hotel"]) {
			hotelFolio.details = value;
		}		
		else {
			folio.details = value;
		}	
	}	
	else if ([elementName isEqualToString:@"StartDate"])
	{
		if([currentAppType isEqualToString:@"Spa"]) {
            NSString *convertedDateStr = [DateManager convertStandardDateFormateStringFromServerResponseString:value withTime:YES];
			spaFolio.startDate = convertedDateStr;
			spaFolio.formatedStartDate = [self stringToDate:convertedDateStr withTime:YES];
		}
		else
		{
            NSString *convertedDateStr = [DateManager convertStandardDateFormateStringFromServerResponseString:value withTime:YES];
			folio.startDate = convertedDateStr;
			folio.formatedStartDate = [self stringToDate:convertedDateStr withTime:YES];
		}
		
	}	
	else if ([elementName isEqualToString:@"FinishDate"])
	{
		if([currentAppType isEqualToString:@"Spa"]) {
            NSString *convertedDateStr = [DateManager convertStandardDateFormateStringFromServerResponseString:value withTime:YES];
			spaFolio.finishDate = convertedDateStr;
			spaFolio.formatedFinishDate = [self stringToDate:convertedDateStr withTime:YES];    //prev YES
		}
		else 
		{
            NSString *convertedDateStr = [DateManager convertStandardDateFormateStringFromServerResponseString:value withTime:YES];
			folio.finishDate = convertedDateStr;
			folio.formatedFinishDate = [self stringToDate:convertedDateStr withTime:YES];   //prev YES
		}
		
	}
	else if ([elementName isEqualToString:@"Staff"]) {
		spaFolio.staff = value;
	}
    ///--------------------------------------- Addition for service desc and client instruction
    else if ([elementName isEqualToString:@"ItemDescription"]) {
		spaFolio.spaDescription = value;
	}
    else if ([elementName isEqualToString:@"ClientInstructions"]) {
		spaFolio.clientInstruction = value;
	}
    ///---------------------------------------
	else if ([elementName isEqualToString:@"RoomType"]) {
		hotelFolio.roomType = value;
	}
	else if ([elementName isEqualToString:@"RateType"]) {
		hotelFolio.rateType = value;
	}
	else if ([elementName isEqualToString:@"RateDescription"]) {
		hotelFolio.rateDescription = value;
	}
	else if ([elementName isEqualToString:@"NetAmount"]) {
		folio.netAmount = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
	}
	else if ([elementName isEqualToString:@"GrossAmount"]) {
		folio.grossAmount = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
	}
	else if ([elementName isEqualToString:@"Deposite"]) {
		hotelFolio.deposit = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
	}
	else if ([elementName isEqualToString:@"BalanceDue"]) {
		hotelFolio.balanceDue = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
	}
	
	
	//----------------------- GroupEvents ---------------------------------
    
	else if ([elementName isEqualToString:@"GroupEvents"]) {
		return;	
	}
	else if ([elementName isEqualToString:@"GroupEvent"]) {
		[self.guestItinerary.groupEvents.groupEventsArr addObject:groupEvent];
		[groupEvent release];
		groupEvent = nil;
		return;
	}	
	else if ([elementName isEqualToString:@"PMSFolioGroupEventId"]) {
		groupEvent.PMSFolioGroupEventId = [value intValue];
	}
	else if (isGroupEvent && [elementName isEqualToString:@"Location"]) {
		groupEvent.location = value;
	}
	else if ([elementName isEqualToString:@"StartTime"]) {
        NSString *convertedDateStr = [DateManager convertStandardDateFormateStringFromServerResponseString:value withTime:YES];
		groupEvent.startTime = convertedDateStr;
		groupEvent.formatedStartTime = [self stringToDate:convertedDateStr withTime:YES];
	}
	else if ([elementName isEqualToString:@"EndTime"]) {
        NSString *convertedDateStr = [DateManager convertStandardDateFormateStringFromServerResponseString:value withTime:YES];
		groupEvent.endTime = convertedDateStr;
		groupEvent.formatedEndTime = [self stringToDate:convertedDateStr withTime:YES];
	}
	else if ([elementName isEqualToString:@"EventCategory"]) {
		groupEvent.eventCategory = value;
	}
	else if ([elementName isEqualToString:@"EventName"]) {
		groupEvent.eventName = value;
	}	
	else if ([elementName isEqualToString:@"EventDesc"]) {
		groupEvent.eventDesc = value;
	}	
	//---------------------- Club Specific Tags------------------------------
	
	if ([elementName isEqualToString:@"CustomerId"]) {
		authCustomer.customerId = value;
	}	
	else if ([elementName isEqualToString:@"FirstName"]) {
		authCustomer.firstName = value;
	}
	else if ([elementName isEqualToString:@"LastName"]) {
		authCustomer.lastName = value;
	}
	else if ([elementName isEqualToString:@"ResetPwd"]) {
		authCustomer.resetPwd = value;
	}
	else if ([elementName isEqualToString:@"CustomerGUID"]) {
		authCustomer.customerGUID = value;
	}
	else if ([elementName isEqualToString:@"EmailAddress"]) {
		authCustomer.emailAddress = value;
	}
	else if ([elementName isEqualToString:@"AuthorizationId"]) {
		authCustomer.authorizationId = value;
	}
	else if ([elementName isEqualToString:@"Guaranteed"]) {
		authCustomer.guaranteed = value;
	}
   
	[value release];
	value = nil;	
}

-(NSDate *)stringToDate:(NSString *)stringDate withTime:(BOOL)flag
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
	if(flag)
	{
		[dateFormatter setDateFormat:EEEE_MMMM_d_yyyy_hh_mm_aFormat];  
        
	}
	else
	{
		[dateFormatter setDateFormat:EEEE_MMMM_d_yyyyFormat];  
	}
    
	NSDate* date = (NSDate*)[dateFormatter dateFromString:stringDate];
	[dateFormatter release];
	
	return date;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    //Here the delegate is the object of RSParserBase class.
	if (isError) {
		[self.delegate parsingComplete:self.errorResult];		//Either for Hotel or Club
	}
	else if	(!isAuthCustomer){
		[self.delegate parsingComplete:self.guestItinerary];		//For Hotel
	}
	else {
		[self.delegate parsingComplete:self.authCustomer];		//For Club
	}
    
    
}

@end
