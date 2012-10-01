//
//  RSSpaCustomerConflictReqResponseHandler.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/1/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSSpaCustomerConflictReqResponseHandler.h"
#import "RSSpaCustomerConflictingBookings.h"

#import "RSSpaClass.h"
#import "RSSpaService.h"
#import "DateManager.h"

@implementation RSSpaCustomerConflictReqResponseHandler
@synthesize isError;
@synthesize errorResult;	
@synthesize spaCustConflictBookingsModel;

-(void) dealloc
{
	[errorResult release];
	[spaCustConflictBookingsModel release];
	
	[super dealloc];
}

- (id) init
{
    if ((self = [super init])) {
        // instantiation code
	} 
	
    return self;
}

#pragma mark - ConnectionManager delegate Methods
-(void)connectionFinishedWithData:(NSData *)data
{
    NSString *recievedData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    DLog(@"RSSpaCustomerConflictReqResponseHandler recieved data = %@", recievedData);
    [recievedData release];
    [self parse:data];
}

-(void)connectionFailedWithError:(NSError *)error
{
    self.resultError = error;
}

-(void) checkForSpaCustomerConflicts:(id) spaServiceOrClass forDateAndTime:(NSString *) dateTime
{
	NSString *spaItemId = nil;
	
	if ([spaServiceOrClass isKindOfClass:[RSSpaService class]]) {
		RSSpaService *service = (RSSpaService *)spaServiceOrClass;
		spaItemId = [NSString stringWithFormat:@"%d", service.spaItemID];
	}
	else if([spaServiceOrClass isKindOfClass:[RSSpaClass class]]) {
		RSSpaClass *class = (RSSpaClass *)spaServiceOrClass;
		spaItemId = [NSString stringWithFormat:@"%d", class.spaItemId];
	}
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	
	NSString *bodyString = [NSString stringWithFormat: 
							@"<rsap:FetchSpaCustomerConflictingBookingsRequest>"
							"<CustomerId>%@</CustomerId>"	
							"<SpaItemId>%@</SpaItemId>"
							"<StartDateTime>%@</StartDateTime>"
							"</rsap:FetchSpaCustomerConflictingBookingsRequest>",
							[prefs stringForKey:CustomerIdKey],
							spaItemId, 
							dateTime];	//@"July 12, 2011 11:00 am"];
    
    NSMutableURLRequest *request = [self RequestWithSoapMessageBody:bodyString];
    [self.connectionManager startConnectionWithRequest:request];

}


- (void) parse:(NSData*)data
{
	NSXMLParser *spaCustConflictBookingsParser = [[NSXMLParser alloc] initWithData:data];
	spaCustConflictBookingsParser.delegate = self;
	[spaCustConflictBookingsParser parse];
	[spaCustConflictBookingsParser release];
}

#pragma mark Parsing delegate

- (void)parserDidStartDocument:(NSXMLParser *)parser { 	
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qualifiedName
   attributes:(NSDictionary *)attributeDict{
	
	//Need to add check for failure error response, wait for Live response.
	
	if ([elementName isEqualToString:@"s:FetchSpaCustomerConflictingBookingsResponse"]) {
		isError	= NO;
		if (self.spaCustConflictBookingsModel) {
			//[self.spaCustConflictBookingsModel release];
			self.spaCustConflictBookingsModel = nil;
		}
		spaCustConflictBookingsModel = [[RSSpaCustomerConflictingBookings alloc] init];
	}
	//-----------------------------------------------------------
	else if ([elementName isEqualToString:@"Result"]) {
		
		if ([[attributeDict valueForKey:@"value"] isEqualToString:@"FAIL"]) {
			isError = YES;
		}		
		if (!isError) {
			if (self.spaCustConflictBookingsModel.spaBookingResult) {
				//[self.spaCustConflictBookingsModel.spaBookingResult release];	
                self.spaCustConflictBookingsModel.spaBookingResult = nil;
			}
            Result * spaBookingResultObj = [[Result alloc] init];
			spaCustConflictBookingsModel.spaBookingResult = spaBookingResultObj;
            [spaBookingResultObj release];
			
			if ([[attributeDict valueForKey:@"value"] isEqualToString:@"SUCCESS"]) {
				self.spaCustConflictBookingsModel.spaBookingResult.resultValue= SUCCESS;
			}
			else {
				self.spaCustConflictBookingsModel.spaBookingResult.resultValue = FAIL;
			}
		}
		else {
			if (self.errorResult) {
				//[self.errorResult release];
				self.errorResult = nil;
			}
			errorResult = [[Result alloc] init];
			self.errorResult.resultValue = FAIL;
		}
	}	
	//-----------------------------------------------------------
	else if ([elementName isEqualToString:@"SpaBooking"]) {
		spaBooking = [[RSSpaBooking	alloc] init];
	}
	//-----------------------------------------------------------
    //--------------------------to remove unwanted allocation of "value" object---------------------------------
	else if ([elementName isEqualToString:@"soapenv:Envelope"]|| [elementName isEqualToString:@"soapenv:Body"]) {
        return;
    }
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
	if ([elementName isEqualToString:@"s:FetchSpaCustomerConflictingBookingsResponse"]){
		return;
	}
	else if ([elementName isEqualToString:@"Result"]) {
		return;	
	}	
	else if ([elementName isEqualToString:@"Text"]) {
		if (!isError) {
			self.spaCustConflictBookingsModel.spaBookingResult.resultText = value;	
		}
		else {
			self.errorResult.resultText = value;			
		}
	}	
	//----------------------------------------------------------
	else if ([elementName isEqualToString:@"SpaBooking"]) {
		[self.spaCustConflictBookingsModel.spaBookings addObject:spaBooking];
		[spaBooking release];
		return;
	}
	else if ([elementName isEqualToString:@"ItemName"]) {
		spaBooking.itemName = value;
	}
	else if ([elementName isEqualToString:@"StartTime"]) {
		//spaBooking.startTime = value;
        spaBooking.startTime = [DateManager stringFromServerResponseString:value requiredFormat:MMMM_dd_yyyy_hh_mm_aFormat withTime:YES];
	}
	else if ([elementName isEqualToString:@"EndTime"]) {
		//spaBooking.endTime = value;
        spaBooking.endTime = [DateManager stringFromServerResponseString:value requiredFormat:MMMM_dd_yyyy_hh_mm_aFormat withTime:YES];
	}
	else if ([elementName isEqualToString:@"Location"]) {
		spaBooking.location = value;
	}
	
	[value release];
	value = nil;	
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
	//Here the delegate is the object of RSParserBase class.
	if (isError) {
		[self.delegate parsingComplete:self.errorResult];
	}
	else {
		[self.delegate parsingComplete:self.spaCustConflictBookingsModel];
	}
}

@end
