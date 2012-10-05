//
//  RSGolfLocationReqResponseHandler.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/28/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSGolfLocationReqResponseHandler.h"
#import "RSGolfLocations.h"
#import "DateManager.h"

@implementation RSGolfLocationReqResponseHandler
@synthesize isError;
@synthesize errorResult;
@synthesize golfLocationsModel;

-(void)dealloc
{
    [errorResult release];
	[golfLocationsModel release];
    [super dealloc];
}

-(id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void) fetchGolfLocationsRequest
{
    //	[self fetchDataForRequestWithBody:@"<rsap:FetchGolfLocationsRequest></rsap:FetchGolfLocationsRequest>"];
    NSMutableURLRequest *request = [self RequestWithSoapMessageBody:@"<rsap:FetchGolfLocationsRequest></rsap:FetchGolfLocationsRequest>"];
    [self.connectionManager startConnectionWithRequest:request];
}

#pragma mark - ConnectionManager delegate Methods
-(void)connectionFinishedWithData:(NSData *)data
{
    NSString *recievedData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    DLog(@"FetchGolfLocationsRequest recieved data = %@", recievedData);
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
	
	//Need to add check for failure error response, wait for Live response.
	
	
	if ([elementName isEqualToString:@"g:FetchGolfLocationsResponse"]) {
		isError	= NO;
		if (self.golfLocationsModel) {
			//[self.golfLocationsModel release];
			self.golfLocationsModel = nil;
		}
		golfLocationsModel = [[RSGolfLocations alloc] init];
	}
	//-----------------------------------------------------------
	else if ([elementName isEqualToString:@"Result"]) {
		
		if ([[attributeDict valueForKey:@"value"] isEqualToString:@"FAIL"]) {
			isError = YES;
		}		
		if (!isError) {
			if (self.golfLocationsModel.golfLocationsfResult) {
				//[self.golfLocationsModel.golfLocationsfResult release];
                self.golfLocationsModel.golfLocationsfResult = nil;
			}
            Result *resultObj = [[Result alloc] init];
			golfLocationsModel.golfLocationsfResult = resultObj;
            [resultObj release];
			
			if ([[attributeDict valueForKey:@"value"] isEqualToString:@"SUCCESS"]) {
				self.golfLocationsModel.golfLocationsfResult.resultValue= SUCCESS;
			}
			else {
				self.golfLocationsModel.golfLocationsfResult.resultValue = FAIL;
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
	else if ([elementName isEqualToString:@"GolfLocation"]) {
		golfLocation = [[RSGolfLocation	alloc] init];
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
	if ([elementName isEqualToString:@"g:FetchGolfLocationsResponse"]){
		return;
	}
	else if ([elementName isEqualToString:@"Result"]) {
		return;	
	}	
	else if ([elementName isEqualToString:@"Text"]) {
		if (!isError) {
			self.golfLocationsModel.golfLocationsfResult.resultText = value;	
		}
		else {
			self.errorResult.resultText = value;			
		}
	}
	
	//----------------------------------------------------------
	
	else if ([elementName isEqualToString:@"GolfLocation"]) {
		[self.golfLocationsModel.golfLocations addObject:golfLocation];
		[golfLocation release];
		return;
	}
	else if ([elementName isEqualToString:@"LocationId"]) {
		golfLocation.locationId = value;
	}
	else if ([elementName isEqualToString:@"LocationName"]) {
		golfLocation.locationName = value;
	}
	else if ([elementName isEqualToString:@"MondayOpen"]) {
        golfLocation.mondayOpen = [self timeStringFromResponsedDateString:value];      
	}
	else if ([elementName isEqualToString:@"MondayClose"]) {
        golfLocation.mondayClose = [self timeStringFromResponsedDateString:value];
	}
	else if ([elementName isEqualToString:@"TuesdayOpen"]) {
		golfLocation.tuesdayOpen = [self timeStringFromResponsedDateString:value];
	}
	else if ([elementName isEqualToString:@"TuesdayClose"]) {
		golfLocation.tuesdayClose = [self timeStringFromResponsedDateString:value];
	}
	else if ([elementName isEqualToString:@"WednesdayOpen"]) {
		golfLocation.wednesdayOpen = [self timeStringFromResponsedDateString:value];
	}
	else if ([elementName isEqualToString:@"WednesdayClose"]) {
		golfLocation.wednesdayClose = [self timeStringFromResponsedDateString:value];
	}
	else if ([elementName isEqualToString:@"ThursdayOpen"]) {
		golfLocation.thursdayOpen = [self timeStringFromResponsedDateString:value];
	}
	else if ([elementName isEqualToString:@"ThursdayClose"]) {
		golfLocation.thursdayClose	= [self timeStringFromResponsedDateString:value];
	}
	else if ([elementName isEqualToString:@"FridayOpen"]) {
		golfLocation.fridayOpen = [self timeStringFromResponsedDateString:value];
	}
	else if ([elementName isEqualToString:@"FridayClose"]) {
		golfLocation.fridayClose = [self timeStringFromResponsedDateString:value];
	}
	else if ([elementName isEqualToString:@"SaturdayOpen"]) {
		golfLocation.saturdayOpen = [self timeStringFromResponsedDateString:value];
	}
	else if ([elementName isEqualToString:@"SaturdayClose"]) {
		golfLocation.saturdayClose = [self timeStringFromResponsedDateString:value];
	}
	else if ([elementName isEqualToString:@"SundayOpen"]) {
		golfLocation.sundayOpen = [self timeStringFromResponsedDateString:value];
	}
	else if ([elementName isEqualToString:@"SundayClose"]) {
		golfLocation.sundayClose = [self timeStringFromResponsedDateString:value];
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
		[self.delegate parsingComplete:self.golfLocationsModel];
	}
}


#pragma mark Date conversions

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

- (NSString *)timeStringFromResponsedDateString:(NSString *)sreverRespondedString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
    //convert server responded dateString into and NSDate object 
    [dateFormatter setDateFormat:kServerRespondedDateTimeFormat];		
	NSDate *convertedDate = [dateFormatter dateFromString:sreverRespondedString];
    
    //get time form date string
    [dateFormatter setDateFormat:hh_mm_aFormat];
    NSString *convertedString = [dateFormatter stringFromDate:convertedDate];
    
	return convertedString;
}

@end
