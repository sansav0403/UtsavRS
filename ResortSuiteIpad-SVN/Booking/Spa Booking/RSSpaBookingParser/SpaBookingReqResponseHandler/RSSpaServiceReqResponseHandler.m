//
//  RSSpaServiceReqResponseHandler.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/2/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSSpaServiceReqResponseHandler.h"
#import "RSSelectedSpaLocation.h"
@implementation RSSpaServiceReqResponseHandler
@synthesize rsSpaServices;


-(void)dealloc
{
    [rsSpaServices release];
    [result release];
    [super dealloc];
}

- (id) init
{
    self = [super init];
    if (self) {
        
        rsSpaServices =nil;
        result = [[Result alloc]init];
		
    }
	
    return self;
}

//create a funtion to create req body for spa service req
#pragma mark fetch the data for the spa services
-(void) fetchSpaServices
{
    RSSelectedSpaLocation *location = [RSSelectedSpaLocation sharedInstance];
    
	NSString *requestBody = [NSString stringWithFormat:                             
                            @"<rsap:FetchSpaServicesRequest>"
                            "<Location>%@</Location>"
                            "</rsap:FetchSpaServicesRequest>",
                            [NSString stringWithFormat:@"%d",location.spaLocation.locationID] //Locatiojn id from Spa Location service
                            ];
    
    NSMutableURLRequest *request = [self RequestWithSoapMessageBody:requestBody];
    [self.connectionManager startConnectionWithRequest:request];
}
#pragma mark - ConnectionManager delegate Methods
-(void)connectionFinishedWithData:(NSData *)data
{
    NSString *recievedData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    DLog(@"FetchSpaServicesRequest recieved data = %@", recievedData);
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
            rsSpaServices = [[RSSpaServices alloc]init];
            rsSpaServices.spaServiceResult.resultValue = SUCCESS;
        }
    }    
    if ([elementName isEqualToString:@"SpaService"])
    {
        spaService = [[RSSpaService alloc]init];
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
        rsSpaServices.spaServiceResult.resultText = value;
    }
    
    else if ([elementName isEqualToString:@"SpaService"])
    {
        [rsSpaServices.spaServices addObject:spaService];
        [spaService release];
        spaService = nil;
        
    }
    //----------------------
    
    else if ([elementName isEqualToString:@"SpaItemId"])
    {
        
        spaService.spaItemID = [value intValue];
    }
    
    else if ([elementName isEqualToString:@"Location"])
    {
        
        spaService.location = [value intValue];
    }
    
    else if ([elementName isEqualToString:@"ItemName"])
    {
        NSString *temp = [[NSString alloc]initWithFormat:@"%@",value];
        spaService.itemName = temp;
        [temp release];
    }
    
    else if ([elementName isEqualToString:@"ItemDesc"])
    {
        NSString *temp = [[NSString alloc]initWithFormat:@"%@",value];
        spaService.itemDesc = temp;
        [temp release];
    }
    else if ([elementName isEqualToString:@"ClientInstructions"])
    {
        NSString *temp = [[NSString alloc]initWithFormat:@"%@",value];
        spaService.clientInstruction = temp;
        [temp release];
    }
    
    else if ([elementName isEqualToString:@"Price"])
    {
        spaService.price = [value floatValue];
    }
    
    else if ([elementName isEqualToString:@"ServiceTime"])      
    {
        spaService.serviceTime = [value intValue];
    }
    
    else if ([elementName isEqualToString:@"SameGender"])
    {
        if ([value isEqualToString:@"Y"])
        {
            spaService.sameGender = YES;
        }
        else
        {
            spaService.sameGender = NO;
        }
    }
    else if ([elementName isEqualToString:@"ItemCategory"])
    {
        NSString *temp = [[NSString alloc]initWithFormat:@"%@",value];
        spaService.itemCategory = temp;
        [temp release];
    }
    else if ([elementName isEqualToString:@"ItemSubcategory"])
    {
        NSString *temp = [[NSString alloc]initWithFormat:@"%@",value];
        spaService.itemSubCategory = temp;
        [temp release];
    }
    [value release];
	value = nil;	
}


- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    if (result.resultValue == FAIL) {
        [self.delegate parsingComplete:result];
    }
    else
    {
        
        [self.delegate parsingComplete:rsSpaServices];
    }
    
}

@end
