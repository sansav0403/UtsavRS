//
//  RSGolfBookingReqResponseHandler.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/5/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSGolfBookingReqResponseHandler.h"
#import "RSSelectedGolfLocation.h"


@implementation RSGolfBookingReqResponseHandler
@synthesize golfBookingResult;
@synthesize golfBookingId;
@synthesize isError;

-(void) dealloc
{
	[golfBookingResult release];
	[golfBookingId release];
	
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
    DLog(@"RSGolfBookingReqResponseHandler recieved data = %@", recievedData);
    [recievedData release];
    
    [self parse:data];
}

-(void)connectionFailedWithError:(NSError *)error
{
    self.resultError = error;
}

- (void) parse:(NSData*)data
{
	NSXMLParser *golfBookingParser = [[NSXMLParser alloc] initWithData:data];
	golfBookingParser.delegate = self;
	[golfBookingParser parse];
	[golfBookingParser release];
}

-(void)BookGolfServiceForBookingTime:(NSString *)BookingTime forSelectedCourseID:(NSString *)selectedCourseID forNumberOfPlayers:(NSString *)players withGolfItemID:(NSString *)golfRateItemID andPlayingCost:(NSString *)price
{
    RSSelectedGolfLocation *selectedGolfLocation = [RSSelectedGolfLocation sharedInstance];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString *requestBody = [NSString stringWithFormat:                             
                             @"<rsap:CreateGolfBookingRequest>"
                             "<Source>IPAD</Source>"
                             "<AuthorizationId>%@</AuthorizationId>"
                             "<TeeTime>%@</TeeTime>"
                             "<CourseId>%@</CourseId>"
                             "<Players>%@</Players>"
                             "<CustomerId>%@</CustomerId>"
                             "<ItemId>%@</ItemId>"
                             "<Price>%@</Price>"
                             "<LocationId>%@</LocationId>"
                             "</rsap:CreateGolfBookingRequest>",
                             [NSString stringWithString:[prefs stringForKey:AuthorizationIdKey]],           
                             BookingTime,
                             selectedCourseID,
                             players,
                             [NSString stringWithString:[prefs stringForKey:CustomerIdKey]],
                             golfRateItemID,           
                             price,
                             [NSString stringWithString:selectedGolfLocation.golfLocation.locationId]
                             ];
    DLog(@"requestBody of GolfBooking=%@",requestBody); 
    NSMutableURLRequest *request = [self RequestWithSoapMessageBody:requestBody];
    [self.connectionManager startConnectionWithRequest:request];
}

#pragma mark Parsing delegate

- (void)parserDidStartDocument:(NSXMLParser *)parser { 	
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qualifiedName
   attributes:(NSDictionary *)attributeDict{
	
	//Need to add check for failure error response, wait for Live response.
	
	if ([elementName isEqualToString:@"g:CreateGolfBookingResponse"]) {
        isError	= NO;
		return;
	}
	//-----------------------------------------------------------
	else if ([elementName isEqualToString:@"Result"]) {
        
        if (self.golfBookingResult) {
            //[self.golfBookingResult release];					
            self.golfBookingResult = nil;
        }
        golfBookingResult = [[Result alloc] init];
        
        if ([[attributeDict valueForKey:@"value"] isEqualToString:@"SUCCESS"]) {
            self.golfBookingResult.resultValue= SUCCESS;
            isError	= NO;
        }
        else if ([[attributeDict valueForKey:@"value"] isEqualToString:@"FAIL"]){
            self.golfBookingResult.resultValue = FAIL;
            isError = YES;
        }
	}	
	//-----------------------------------------------------------
    else if ([elementName isEqualToString:@"soapenv:Envelope"]|| [elementName isEqualToString:@"soapenv:Body"]) {
        return;
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
	if ([elementName isEqualToString:@"g:CreateGolfBookingResponse"]){
		return;
	}
	else if ([elementName isEqualToString:@"Result"]) {
		return;	
	}	
	else if ([elementName isEqualToString:@"Text"]) {
		self.golfBookingResult.resultText = value;	
	}	
	else if ([elementName isEqualToString:@"GolfBookingId"]) {
		self.golfBookingId = value;
	}
	else if ([elementName isEqualToString:@"ErrorId"]) {
		self.golfBookingResult.ErrorID = [value intValue];
	}
	[value release];
	value = nil;	
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
	//Here the delegate is the object of RSParserBase class.
    if (isError)
    {
        [self.delegate parsingComplete:self.golfBookingResult];
    }
    else
    {
        [self.delegate parsingComplete:self];
    }
}

@end
