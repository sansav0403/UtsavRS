//
//  RSSpaServiceBookingReqResponseHandler.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/2/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSSpaServiceBookingReqResponseHandler.h"

@implementation RSSpaServiceBookingReqResponseHandler
@synthesize serviceBooking;


-(void)dealloc
{  
    [serviceBooking release];
    [result release];
    [super dealloc];
    
}


- (id) init
{
    self = [super init];
    if (self) {
        
        serviceBooking = nil;   
        result = [[Result alloc]init];
		
    }
	
    return self;
}


#pragma mark - method to fetch the bookking req

-(void)createSpaBookingForSpaItemId:(NSString *)spaItemID withStartDateTime:(NSString *)startTime andSpaStaffId:(NSString *)spaStaffID
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	
	NSString *requestBody = [NSString stringWithFormat: 
							@"<rsap:CreateSpaBookingRequest>"
							@"<AuthorizationId>%@</AuthorizationId>"
							"<CustomerId>%@</CustomerId>"
							@"<SpaItemId>%@</SpaItemId>"
							@"<StartDateTime>%@</StartDateTime>"
							"<SpaStaffId>%@</SpaStaffId>"
							"</rsap:CreateSpaBookingRequest>",
							[prefs stringForKey:AuthorizationIdKey],
							[prefs stringForKey:CustomerIdKey],
							spaItemID,
							startTime,
							spaStaffID
							];
    DLog(@"Create Spa Booking requestBody = %@",requestBody);
    NSMutableURLRequest *request = [self RequestWithSoapMessageBody:requestBody];
    [self.connectionManager startConnectionWithRequest:request];
}
#pragma mark - ConnectionManager delegate Methods
-(void)connectionFinishedWithData:(NSData *)data
{
    NSString *recievedData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    DLog(@"CreateSpaBookingRequest recieved data = %@", recievedData);
    [recievedData release];
    [self parse:data];
}

-(void)connectionFailedWithError:(NSError *)error
{
    self.resultError = error;
}

- (void) parse:(NSData*)data
{
    NSXMLParser *parser = [[NSXMLParser alloc]initWithData:data];
    
    [parser setDelegate:self];
    [parser parse];
    [parser release];
}

#pragma mark parser Delegate Method

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName 
	attributes:(NSDictionary *)attributeDict
{
	
    if ([elementName isEqualToString:@"Result"])
    {
		
		if ([[attributeDict valueForKey:@"value"] isEqualToString:@"FAIL"])
        {
            result.resultValue = FAIL;
        }
        else
        {
            result.resultValue = SUCCESS;
            serviceBooking = [[RSSpaServiceBooking alloc]init];
            serviceBooking.serviceBookingResult.resultValue = SUCCESS;
        }
    }
    //--------------------------to remove unwanted allocation of "value" object---------------------------------
	else if ([elementName isEqualToString:@"soapenv:Envelope"]|| [elementName isEqualToString:@"soapenv:Body"]) {
        return;
    }
	else
	{
        value = [[NSMutableString alloc]init];
	}
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
   	if(value && string && [string length]>0)
	{
		[value appendString:string];
	} 
    
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if ([elementName isEqualToString:@"Text"])   
    {
        result.resultText = value;
        serviceBooking.serviceBookingResult.resultText = value;
    }
    else if ([elementName isEqualToString:@"SpaFolioId"]) 
    {
        serviceBooking.spaFolioId = value;
    }    
    else if ([elementName isEqualToString:@"SpaFolioItemId"]) 
    {
        serviceBooking.spaFolioItemId = value;
    }
    else if ([elementName isEqualToString:@"ErrorId"]) {
		result.ErrorID = [value intValue];
	}
    [value release];
	value = nil;	
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    if (result.resultValue == FAIL)
    {
        [self.delegate parsingComplete:result];
    }
    else
    {
        [self.delegate parsingComplete:serviceBooking];
    }
    
}


@end
