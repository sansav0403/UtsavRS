//
//  RequestResponseHandlerClass.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/22/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RequestResponseHandlerClass.h"
#import "SoapRequests.h"

@implementation RequestResponseHandlerClass
@synthesize delegate;
-(void)dealloc
{
    if (parserItineraryObj != nil) {
        [parserItineraryObj release];
        parserItineraryObj = nil;
    }
    
    if (connection != nil) {
        [connection release];
        connection = nil;
    }
    delegate = nil;
    [super dealloc];
}
#pragma mark - connection Manager delegate Method
-(void)connectionFinishedWithData:(NSData *)data
{   

    DLog(@"connectionFinishedWithData connection manager delegate method");
    /*depending upon the kind of response string call the appropriate parser object */
    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    DLog(@"responseString ===== \n%@",responseString);
    
        if ([responseString rangeOfString:@"AuthCustomerResponse"].length > 0)
    {
        parserItineraryObj = [[RSMyItineraryParser alloc] init];     
		parserItineraryObj.delegate = self;
		[parserItineraryObj parse:data];
    }
    else if ([responseString rangeOfString:@"FetchGuestItineraryResponse"].length > 0)
    {
        parserItineraryObj = [[RSMyItineraryParser alloc] init];     
		parserItineraryObj.delegate = self;
		[parserItineraryObj parse:data];
    }    
    [responseString release];
    responseString = nil;
}

#pragma mark - Parser Delegate Method
-(void)parsingComplete:(id)parserModelData
{
    /*just return the object via delegate method*/
    if (delegate) {
        [delegate responseHandledWithObject:parserModelData];
    }
}

#pragma mark Common method for creating soap request
-(void) fetchDataForRequestWithBody:(NSString *) bodyString
{
	SoapRequests *soapRequest = [[SoapRequests alloc] init];
	NSString *soapString = [soapRequest createSoapRequestForBody:bodyString];
	[soapRequest release];
	
	connection = [[ConnectionManager alloc]init];
	connection.delegate = self;
	
	[connection	startConnectionWithSoapStringMessage:soapString];
    
    DLog(@" request body: %@",soapString);
}

#pragma mark - requestbody creation methods
//authentication flow are same in the hotel and club App.
-(void) authenticateCustomer:(NSString *) EmailAddress Password:(NSString *) Password
{
	//Auth Customer request
	NSString *requestBody = [NSString stringWithFormat: 
							 @"<rsap:AuthCustomerRequest>"
                             "<Source>IPAD</Source>"
							 "<EmailAddress>%@</EmailAddress>"
							 "<Password>%@</Password>"
							 "</rsap:AuthCustomerRequest>",EmailAddress, Password];
	
	[self fetchDataForRequestWithBody:requestBody];
	
}


-(void) fetchClubAccountsRequest
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];


	NSString *requestBody = [NSString stringWithFormat: 
							 @"<rsap:FetchClubAccountsRequest>"
                             "<Source>IPAD</Source>"
							 "<CustomerId>%@</CustomerId>"
							 "<CustomerGUID>%@</CustomerGUID>"
							 "<EmailAddress>%@</EmailAddress>"
							 "<Password>%@</Password>"
							 "</rsap:FetchClubAccountsRequest>",
							 [prefs objectForKey:CustomerIdKey], 
							 [prefs objectForKey:CustomerGUIDKey],
							 [prefs objectForKey:EmailAddressKey], 
							 [prefs objectForKey:PasswordKey]];
	
	[self fetchDataForRequestWithBody:requestBody];


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
	[self fetchDataForRequestWithBody:requestBody];
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
    [self fetchDataForRequestWithBody:requestBody];
    
}
@end
