//
//  RSGolfRatesReqResponseHandler.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/5/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSGolfRatesReqResponseHandler.h"
#import "RSGolfRates.h"

@implementation RSGolfRatesReqResponseHandler
@synthesize isError;
@synthesize errorResult;	
@synthesize golfRatesModel;

-(void) dealloc
{
	[errorResult release];
	[golfRatesModel release];
	
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
    DLog(@"RSGolfRatesReqResponseHandler recieved data = %@", recievedData);
    [recievedData release];
    [self parse:data];
}

-(void)connectionFailedWithError:(NSError *)error
{
    self.resultError = error;
}

-(void)fetchGolfRateForSelectedCourseID:(NSString *)CourseID forDate:(NSString *)date andTime:(NSString *)time
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *requestBody = [NSString stringWithFormat:  //fetch rate of golf                           
                             @"<rsap:FetchGolfRatesRequest>"
                             "<Source>IPAD</Source>"
                             "<CourseId>%@</CourseId>"
                             "<CustomerId>%@</CustomerId>"
                             "<Date>%@</Date>"
                             "<TeeTime>%@</TeeTime>"
                             "</rsap:FetchGolfRatesRequest>",
                             CourseID,
                             [NSString stringWithString:[prefs stringForKey:CustomerIdKey]],
                             date,
                             time
                             ];
    DLog(@"resquest =%@",requestBody);
    NSMutableURLRequest *request = [self RequestWithSoapMessageBody:requestBody];
    [self.connectionManager startConnectionWithRequest:request];
}

- (void) parse:(NSData*)data
{
	NSXMLParser *golfRatesParser = [[NSXMLParser alloc] initWithData:data];
	golfRatesParser.delegate = self;
	[golfRatesParser parse];
	[golfRatesParser release];
}



#pragma mark Parsing delegate

- (void)parserDidStartDocument:(NSXMLParser *)parser { 	
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qualifiedName
   attributes:(NSDictionary *)attributeDict{
	
	//Need to add check for failure error response, wait for Live response.
    
	if ([elementName isEqualToString:@"g:FetchGolfRatesResponse"]) {
		isError	= NO;
		if (self.golfRatesModel) {
			//[self.golfRatesModel release];
			self.golfRatesModel = nil;
		}
		golfRatesModel = [[RSGolfRates alloc] init];
	}
	//-----------------------------------------------------------
	else if ([elementName isEqualToString:@"Result"]) {
		
		if ([[attributeDict valueForKey:@"value"] isEqualToString:@"FAIL"]) {
			isError = YES;
		}		
		if (!isError) {
			if (self.golfRatesModel.golfRatesResult) {
				//[self.golfRatesModel.golfRatesResult release];	
                
				self.golfRatesModel.golfRatesResult = nil;
			}
            Result *golfRateResultObj = [[Result alloc] init];
			golfRatesModel.golfRatesResult = golfRateResultObj;
            [golfRateResultObj release];
			
			if ([[attributeDict valueForKey:@"value"] isEqualToString:@"SUCCESS"]) {
				self.golfRatesModel.golfRatesResult.resultValue= SUCCESS;
			}
			else {
				self.golfRatesModel.golfRatesResult.resultValue = FAIL;
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
	if ([elementName isEqualToString:@"g:FetchGolfRatesResponse"]){
		return;
	}
	else if ([elementName isEqualToString:@"Result"]) {
		return;	
	}	
	else if ([elementName isEqualToString:@"Text"]) {
		if (!isError) {
			self.golfRatesModel.golfRatesResult.resultText = value;	
		}
		else {
			self.errorResult.resultText = value;			
		}
	}	
	else if ([elementName isEqualToString:@"Price"]) {
		self.golfRatesModel.price = value;
	}
	else if ([elementName isEqualToString:@"ItemName"]) {
		self.golfRatesModel.itemName = value;
	}
	else if ([elementName isEqualToString:@"ItemId"]) {
		self.golfRatesModel.itemId = value;
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
		[self.delegate parsingComplete:self.golfRatesModel];
	}
}


#pragma mark Date conversions

-(NSDate *)stringToDate:(NSString *)stringDate withTime:(BOOL)flag
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
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


@end
