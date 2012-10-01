//
//  ChangePasswordReqResponseHandler.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/16/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "ChangePasswordReqResponseHandler.h"

@implementation ChangePasswordReqResponseHandler
@synthesize isError;
@synthesize changePasswordResult;

- (id) init
{
    if ((self = [super init])) {
        // instantiation code
	} 
	
    return self;
}

- (void)callConectionManagerForRequestBody:(NSString *)requestBody
{
    NSMutableURLRequest *request = [self RequestWithSoapMessageBody:requestBody];
    [self.connectionManager startConnectionWithRequest:request];
}

#pragma mark - ConnectionManager delegate Methods
- (void)connectionFinishedWithData:(NSData *)data
{
    NSString *recievedData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    DLog(@"ChangePasswordReqResponseHandler recieved data = %@", recievedData);
    [recievedData release];

    [self parse:data];
}

- (void)connectionFailedWithError:(NSError *)error
{
    self.resultError = error;
}


- (void) parse:(NSData*)data
{
	NSXMLParser *changePasswordParser = [[NSXMLParser alloc] initWithData:data];
	changePasswordParser.delegate = self;
	[changePasswordParser parse];
	[changePasswordParser release];
}

-(void) dealloc
{
	[changePasswordResult release];		
	[super dealloc];
}

#pragma mark Parsing delegate

- (void)parserDidStartDocument:(NSXMLParser *)parser { 	
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qualifiedName
   attributes:(NSDictionary *)attributeDict{
    
    //Need to add check for failure error response, wait for Live response.
	
	if ([elementName isEqualToString:@"rsapp:ChangePasswordCustomerResponse"]) {
        isError	= NO;
		return;
	}
	//-----------------------------------------------------------
	else if ([elementName isEqualToString:@"Result"]) {
        
        if (self.changePasswordResult) {
                            
            self.changePasswordResult = nil;
        }
        changePasswordResult = [[Result alloc] init];
        
        if ([[attributeDict valueForKey:@"value"] isEqualToString:@"SUCCESS"]) {
            self.changePasswordResult.resultValue= SUCCESS;
            isError	= NO;
        }
        else if ([[attributeDict valueForKey:@"value"] isEqualToString:@"FAIL"]){
            self.changePasswordResult.resultValue = FAIL;
             
            isError = YES;
        }
	}	
	//-----------------------------------------------------------
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
	if ([elementName isEqualToString:@"rsapp:ChangePasswordCustomerResponse"]){
		return;
	}
	else if ([elementName isEqualToString:@"Result"]) {
		return;	
	}	
	else if ([elementName isEqualToString:@"Text"]) {
		self.changePasswordResult.resultText = value;	
	}	
	else if ([elementName isEqualToString:@"ErrorId"]) {
		self.changePasswordResult.ErrorID = [value intValue];
	}
	
	[value release];
	value = nil;	
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
	//Here the delegate is the object of RSParserBase class.
    if (isError)
    {
        [self.delegate parsingComplete:self.changePasswordResult];
    }
    else
    {
        [self.delegate parsingComplete:self];
    }
}

@end
