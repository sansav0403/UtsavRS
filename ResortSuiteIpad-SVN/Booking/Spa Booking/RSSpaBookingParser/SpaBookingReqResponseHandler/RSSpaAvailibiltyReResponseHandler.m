//
//  RSSpaAvailibiltyReResponseHandler.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/2/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSSpaAvailibiltyReResponseHandler.h"
#import "RSSpaAvailibility.h"
#import "DateManager.h"

@implementation RSSpaAvailibiltyReResponseHandler
@synthesize rsSpaAvailibilties;

-(void)dealloc
{
    [rsSpaAvailibilties release];
    [result release];
    [super dealloc];
    
}

- (id) init
{
    self = [super init];
    if (self) {
        
        rsSpaAvailibilties = nil;
        result = [[Result alloc]init];
		
    }
	
    return self;
}


-(void) checkAvailabilityForSpaBookingForSpaItemId:(NSString *)spaItemID forDateTime:(NSString *)selectedDateTime andSpaLocationID:(NSString *)LocationID
{

	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
	NSString *requestBody = [NSString stringWithFormat: 
							@"<rsap:FetchSpaAvailabilityRequest>"
							@"<AuthorizationId>%@</AuthorizationId>"
							"<SpaItemId>%@</SpaItemId>"							 
							"<StartDateTime>%@</StartDateTime>"
							"<CustomerId>%@</CustomerId>"
							"<SpaLocationId>%@</SpaLocationId>"
							"</rsap:FetchSpaAvailabilityRequest>",
							[prefs stringForKey:AuthorizationIdKey],
							spaItemID,
							selectedDateTime,
							[prefs stringForKey:CustomerIdKey],
							LocationID];
    NSMutableURLRequest *request = [self RequestWithSoapMessageBody:requestBody];
    [self.connectionManager startConnectionWithRequest:request];
}

#pragma mark - ConnectionManager delegate Methods
-(void)connectionFinishedWithData:(NSData *)data
{
    NSString *recievedData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    DLog(@"FetchSpaAvailabilityRequest recieved data = %@", recievedData);
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
            rsSpaAvailibilties = [[RSSpaAvailibilties alloc]init];
            rsSpaAvailibilties.spaAvailibilityResult.resultValue = SUCCESS;
        }
    }
    
    else if ([elementName isEqualToString:@"SpaAvailability"])
    {
        spaAvailibility = [[RSSpaAvailibility alloc]init];
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
    }
    
    else if ([elementName isEqualToString:@"SpaAvailability"])
    {
        [rsSpaAvailibilties.spaAvailibilities addObject:spaAvailibility];
        
        [spaAvailibility release];
        
    }
    //----------------------
    else if ([elementName isEqualToString:@"StartTime"])
    {
        
        //spaAvailibility.startTime = value;
        
        spaAvailibility.startTime = [DateManager stringFromServerResponseString:value requiredFormat:MMMM_dd_yyyy_hh_mm_aFormat withTime:YES];
    }
    
    else if ([elementName isEqualToString:@"AvailabilityId"])
    {
        spaAvailibility.availibilityID = [value intValue];
    }
    
    else if ([elementName isEqualToString:@"SpaStaffId"])      
    {
        spaAvailibility.spaStaffID = [value intValue];
    }
    
}

//at the end of parsing call the delegate method
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    if (result.resultValue == FAIL) {
        [self.delegate parsingComplete:result];
    }
    else
    {
        
        [self.delegate parsingComplete:rsSpaAvailibilties];
    }
    
}


-(NSDate *)stringToDate:(NSString *)stringDate withTime:(BOOL)flag
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
	if(flag)
	{
		[dateFormatter setDateFormat:yyyy_MM_ddHHmmssFormat];
	}
	else
	{
		[dateFormatter setDateFormat:EEEE_MMMM_d_yyyyFormat];  
	}
    
	NSDate* date = (NSDate*)[dateFormatter dateFromString:stringDate];  
	[dateFormatter release];
	
	return date;
}

@end
