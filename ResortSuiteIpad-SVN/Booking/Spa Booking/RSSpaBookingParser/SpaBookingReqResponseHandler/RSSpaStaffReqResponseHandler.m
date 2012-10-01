//
//  RSSpaStaffReqResponseHandler.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/2/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSSpaStaffReqResponseHandler.h"

@implementation RSSpaStaffReqResponseHandler
@synthesize rsSpaStaffs;

-(void)dealloc
{
    [rsSpaStaffs release];
    [super dealloc];
    
}

- (id) init
{
    self = [super init];
    if (self) {
        rsSpaStaffs = nil;
        result = [[Result alloc]init];
		
    }
	
    return self;
}

//create a funtion to create req body for spa staff req
-(void) fetchSpaStaffsForId:(NSString *) spaItemId forGender:(NSString *) gender
{	
	NSString *requestBody = [NSString stringWithFormat: 
                            @"<rsap:FetchSpaStaffRequest>"
                            "<SpaItemId>%@</SpaItemId>"							 
                            "<Gender>%@</Gender>"		//"<!--Optional:-->"
                            "</rsap:FetchSpaStaffRequest>",spaItemId, gender];
    
    NSMutableURLRequest *request = [self RequestWithSoapMessageBody:requestBody];
    [self.connectionManager startConnectionWithRequest:request];
}

#pragma mark - ConnectionManager delegate Methods
-(void)connectionFinishedWithData:(NSData *)data
{
    NSString *recievedData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    DLog(@"FetchSpaStaffRequest recieved data = %@", recievedData);
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



#pragma mark Parser delegateMethods

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
            rsSpaStaffs = [[RSSpaStaffs alloc]init];
            rsSpaStaffs.spaStaffResult.resultValue = SUCCESS;
        }
    }    
    else if ([elementName isEqualToString:@"SpaStaff"])
    {
        spaStaff = [[RSSpaStaff alloc]init];
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
        rsSpaStaffs.spaStaffResult.resultText = value;
    }
    
    else if ([elementName isEqualToString:@"SpaStaff"])
    {
        //add in the spalocation Array before release
        [rsSpaStaffs.spaStaffs addObject:spaStaff];
        [spaStaff release];
    }
    else if ([elementName isEqualToString:@"SpaStaffId"])
    {
        spaStaff.spaStaffID = [value intValue];
    }
    else if ([elementName isEqualToString:@"SpaStaffName"])
    {
        NSString *teststring = [[NSString alloc]initWithFormat:@"%@",value];
        spaStaff.spaStaffName = teststring;
        [teststring release];
    }
    
    else if ([elementName isEqualToString:@"Gender"])
    {
        if ([value isEqualToString:@"F"]) {
            spaStaff.gender = @"Female";
        }
        else
        {
            spaStaff.gender = @"Male";
        }
        
    }
    [value release];
	value = nil;	
}

//at the end of parsing call the delegate method
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    if (result.resultValue == FAIL) {
        [self.delegate parsingComplete:result];
    }
    else
    {
        
        [self.delegate parsingComplete:rsSpaStaffs];
    }
    
}

@end
