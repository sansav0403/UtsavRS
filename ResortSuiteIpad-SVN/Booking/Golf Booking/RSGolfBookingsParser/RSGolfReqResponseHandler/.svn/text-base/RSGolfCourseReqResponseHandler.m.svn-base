//
//  RSGolfCourseReqResponseHandler.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/28/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSGolfCourseReqResponseHandler.h"
#import "RSGolfCourses.h"

@implementation RSGolfCourseReqResponseHandler

@synthesize isError;
@synthesize errorResult;	
@synthesize golfCoursesModel;

-(void) dealloc
{
	[errorResult release];
	[golfCoursesModel release];
	
	[super dealloc];
}

-(id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)fetchGolfCoursesForLocationId:(int)golfLocationID
{
    NSString *requestBody = [NSString stringWithFormat:                             
                             @"<rsap:FetchGolfCoursesRequest>"
                             "<Source>IPAD</Source>"
                             "<LocationId>%@</LocationId>"
                             "</rsap:FetchGolfCoursesRequest>",
                             [NSString stringWithFormat:@"%d",golfLocationID] //Locatiojn id from Spa Location service
                             ];
    NSMutableURLRequest *request = [self RequestWithSoapMessageBody:requestBody];
    [self.connectionManager startConnectionWithRequest:request];
    
}
#pragma mark - ConnectionManager delegate Methods
-(void)connectionFinishedWithData:(NSData *)data
{
    NSString *recievedData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    DLog(@"fetchGolfCoursesForLocationId recieved data = %@", recievedData);
    [recievedData release];
    [self parse:data];
}

-(void)connectionFailedWithError:(NSError *)error
{
    self.resultError = error;
}

- (void) parse:(NSData*)data
{
	NSXMLParser *golfCoursesParser = [[NSXMLParser alloc] initWithData:data];
	golfCoursesParser.delegate = self;
	[golfCoursesParser parse];
	[golfCoursesParser release];
}


#pragma mark Parsing delegate

- (void)parserDidStartDocument:(NSXMLParser *)parser { 	
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qualifiedName
   attributes:(NSDictionary *)attributeDict{
	
	//Need to add check for failure error response, wait for Live response.
    
	if ([elementName isEqualToString:@"g:FetchGolfCoursesResponse"]) {
		isError	= NO;
		if (self.golfCoursesModel) {
			//[self.golfCoursesModel release];
			self.golfCoursesModel = nil;
		}
		golfCoursesModel = [[RSGolfCourses alloc] init];
	}
	//-----------------------------------------------------------
	else if ([elementName isEqualToString:@"Result"]) {
		
		if ([[attributeDict valueForKey:@"value"] isEqualToString:@"FAIL"]) {
			isError = YES;
		}		
		if (!isError) {
			if (self.golfCoursesModel.golfCoursesResult) {
				//[self.golfCoursesModel.golfCoursesResult release];
                
                self.golfCoursesModel.golfCoursesResult = nil;
			}
            Result *golfCourseResultObj = [[Result alloc] init];
			golfCoursesModel.golfCoursesResult = golfCourseResultObj;
            [golfCourseResultObj release];
			
			if ([[attributeDict valueForKey:@"value"] isEqualToString:@"SUCCESS"]) {
				self.golfCoursesModel.golfCoursesResult.resultValue= SUCCESS;
			}
			else {
				self.golfCoursesModel.golfCoursesResult.resultValue = FAIL;
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
	else if ([elementName isEqualToString:@"GolfCourse"]) {
		golfCourse = [[RSGolfCourse	alloc] init];
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
	if ([elementName isEqualToString:@"g:FetchGolfCoursesResponse"]){
		return;
	}
	else if ([elementName isEqualToString:@"Result"]) {
		return;	
	}	
	else if ([elementName isEqualToString:@"Text"]) {
		if (!isError) {
			self.golfCoursesModel.golfCoursesResult.resultText = value;	
		}
		else {
			self.errorResult.resultText = value;			
		}
	}	
	//----------------------------------------------------------
	else if ([elementName isEqualToString:@"GolfCourse"]) {
		[self.golfCoursesModel.golfCources addObject:golfCourse];
		[golfCourse release];
		return;
	}
	else if ([elementName isEqualToString:@"CourseId"]) {
		golfCourse.courseId = value;
	}
	else if ([elementName isEqualToString:@"CourseName"]) {
		golfCourse.courseName = value;
	}
	else if ([elementName isEqualToString:@"LocationId"]) {
		golfCourse.locationId = value;
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
		[self.delegate parsingComplete:self.golfCoursesModel];
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



@end
