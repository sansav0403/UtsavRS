//
//  RSClassBookingReqResponseHandler.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/1/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSClassBookingReqResponseHandler.h"

@implementation RSClassBookingReqResponseHandler

@synthesize classBooking;

-(void)dealloc
{
    
    [classBooking release];
    [result release];
    [super dealloc];
    
}

- (id) init
{
    self = [super init];
    if (self) {
        
        classBooking = nil;   
        result = [[Result alloc]init];
		
    }
	
    return self;
}

#pragma mark - ConnectionManager delegate Methods
-(void)connectionFinishedWithData:(NSData *)data
{
    NSString *recievedData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    DLog(@"RSClassBookingReqResponseHandler recieved data = %@", recievedData);
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
#pragma mark method to request
-(void)createClassBookingForSelectedClassID:(NSString *)SelectedClassID
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString *requestBody = [NSString stringWithFormat:                             
                             @"<rsap:CreateClassBookingRequest>"
                             "<Source>IPAD</Source>"
                             "<AuthorizationId>%@</AuthorizationId>"
                             "<CustomerId>%@</CustomerId>"
                             "<SpaClassId>%@</SpaClassId>"
                             "</rsap:CreateClassBookingRequest>",
                             [NSString stringWithString:[prefs stringForKey:AuthorizationIdKey]],
                             [NSString stringWithString:[prefs stringForKey:CustomerIdKey]],
                             SelectedClassID
                             ];    

    
    NSMutableURLRequest *request = [self RequestWithSoapMessageBody:requestBody];
    [self.connectionManager startConnectionWithRequest:request];
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
            classBooking = [[RSClassBooking alloc]init];
            classBooking.classBookingResult.resultValue = SUCCESS;
        }
    }
    else if ([elementName isEqualToString:@"SpaFolioItem"]) 
    {
        
        spaFolioItemTemp = [[RSSpaFolioItem alloc]init];
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
        classBooking.classBookingResult.resultText = value;
    }
    else if ([elementName isEqualToString:@"SpaFolioItem"]) 
    {
        classBooking.spaFolioItem = spaFolioItemTemp;
        [spaFolioItemTemp release];
        
    }
    
    else if ([elementName isEqualToString:@"SpaFolioItemId"]) 
    {
        NSString *temp = [[NSString alloc]initWithFormat:@"%@",value];
        spaFolioItemTemp.spaFolioItemId = [temp intValue];
        [temp release];
        
        
    }
    else if ([elementName isEqualToString:@"BookStartTime"]) 
    {
        NSDate *tempDate = [self stringToDate:value withTime:YES];
        spaFolioItemTemp.bookStartTime = tempDate;
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
        
        [self.delegate parsingComplete:classBooking];
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
    
	NSDate* date = (NSDate*)[dateFormatter dateFromString:stringDate];  //autoreleased
	[dateFormatter release];
	
	return date;
}

@end
