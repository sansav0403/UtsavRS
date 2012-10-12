//
//  RSMyAccountsReqResponseHandler.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 3/6/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSMyAccountsReqResponseHandler.h"
#import "DateManager.h"

@implementation RSMyAccountsReqResponseHandler
@synthesize clubAccounts;
@synthesize isError;
@synthesize errorResult;


-(void) dealloc
{
	[clubAccounts release];
	[errorResult release];
	
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
    DLog(@"RSMyAccountsReqResponseHandler recieved data = %@", recievedData);
    [recievedData release];
    [self parse:data];
}

-(void)connectionFailedWithError:(NSError *)error
{
    self.resultError = error;
}

- (void) parse:(NSData*)data
{
	NSXMLParser *myAccParser = [[NSXMLParser alloc] initWithData:data];
	myAccParser.delegate = self;
	[myAccParser parse];
	[myAccParser release];
}

-(void) fetchClubAccounts
{
//#if	!defined ALL_VERSIONS_SECOND_STATIC
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSString *requestBody = [NSString stringWithFormat: 
							 @"<rsap:FetchClubAccountsRequest>"
                             "<Source>IPAD</Source>"
							 "<CustomerId>%@</CustomerId>"
							 "<CustomerGUID>%@</CustomerGUID>"
							 "<EmailAddress>%@</EmailAddress>"
							 "<Password>%@</Password>"
							 "</rsap:FetchClubAccountsRequest>",
							 [prefs objectForKey:CustomerIdKey], 
							 [prefs objectForKey:CustomerGUIDKey],
							 [prefs objectForKey:EmailAddressKey], 
							 [prefs objectForKey:PasswordKey]];
    
    DLog(@"account req string %@", requestBody);
    
    NSMutableURLRequest *request = [self RequestWithSoapMessageBody:requestBody];
    [self.connectionManager startConnectionWithRequest:request];
}


#pragma mark Parsing delegate

- (void)parserDidStartDocument:(NSXMLParser *)parser { 	
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qualifiedName
   attributes:(NSDictionary *)attributeDict{
	
	
	if ([elementName isEqualToString:@"FetchClubAccountsResponse"] || 
		[elementName isEqualToString:@"n:FetchClubAccountsResponse"]) {
//		isError = YES;
	}
	if ([elementName isEqualToString:@"tns:FetchClubAccountsResponse"]) {
        isError	= NO;
		if (self.clubAccounts) {
            self.clubAccounts = nil;
		}
		clubAccounts = [[RSClubAccounts alloc] init];
		return;
	}
	else if ([elementName isEqualToString:@"Result"]) {		
		if ([[attributeDict valueForKey:@"value"] isEqualToString:@"FAIL"]) {
			isError = YES;
		}	
		if (isError) {
			if (self.errorResult) {
                self.errorResult = nil;
			}
			errorResult = [[Result alloc] init];
			self.errorResult.resultValue = FAIL;
		}
		else {
			if (self.clubAccounts.clubResult) {                
                self.clubAccounts.clubResult = nil;
			}
            Result *resultObj = [[Result alloc] init];
			clubAccounts.clubResult = resultObj;
			self.clubAccounts.clubResult.resultValue = SUCCESS;
            [resultObj release];
		}		
		return;
	}	
	else if ([elementName isEqualToString:@"Customer"]) {
		if (self.clubAccounts.accCustomer) {           
            self.clubAccounts.accCustomer = nil;
		}
        AccCustomer *accCustomer = [[AccCustomer alloc] init];
		clubAccounts.accCustomer = accCustomer;
        [accCustomer release];
		isCustomer = YES;
		return;
	}
	else if ([elementName isEqualToString:@"Address"]) {
        Address *address = [[Address alloc] init];
		self.clubAccounts.accCustomer.address = address;
        [address release];
		return;
	}
	else if ([elementName isEqualToString:@"Account"]) {	
		if (account) {
			[account release];
		}
		account = [[Account alloc] init];
		
		account.accountId = [attributeDict valueForKey:@"Id"];
		account.classType = [attributeDict valueForKey:@"Class"];
		account.statementCustomerName = [attributeDict valueForKey:@"StatementCustomerName"];
		
		return;
	}
	else if ([elementName isEqualToString:@"Member"]) {
		isMember = YES;
		if (member) {
			[member release];
		}
		member = [[Member alloc] init];
		return;
	}
	else if ([elementName isEqualToString:@"Membership"]) {
		if (memberShip) {
			[memberShip release];
		}
		memberShip = [[MemberShip alloc] init];
		
		memberShip.name = [attributeDict valueForKey:@"Name"];
		memberShip.status = [attributeDict valueForKey:@"Status"];
		//memberShip.effectiveDate = [attributeDict valueForKey:@"EffectiveDate"];
		//memberShip.expiryDate = [attributeDict valueForKey:@"ExpiryDate"];
		
        // Date format changes
        NSString *effectiveDateStr = [attributeDict valueForKey:@"EffectiveDate"];
		NSString *expiryDateStr = [attributeDict valueForKey:@"ExpiryDate"];
        
        DLog(@"effectiveDateStr = %@",effectiveDateStr);
        DLog(@"expiryDateStr = %@",expiryDateStr);
        
        memberShip.effectiveDate = [DateManager stringFromServerResponseString:effectiveDateStr requiredFormat:MMMM_dd_yyyyFormat withTime:YES];
		memberShip.expiryDate = [DateManager stringFromServerResponseString:expiryDateStr requiredFormat:MMMM_dd_yyyyFormat withTime:YES];
        
        DLog(@"effectiveDateStr = %@",memberShip.effectiveDate);
        DLog(@"expiryDateStr = %@",memberShip.expiryDate );
        
        //------------------------------------------------------------//

        
		isMembership = YES;
		
		return;
	}	
	else if ([elementName isEqualToString:@"Billing"]) {
		if (account.billing) {
			//[account.billing release];
            account.billing = nil;
		}
        Billing *billing = [[Billing alloc] init];
		account.billing = billing;
        [billing release];
		
		account.billing.frequency = [attributeDict valueForKey:@"Frequency"];
		//account.billing.nextBillDate = [attributeDict valueForKey:@"NextBillDate"];
        account.billing.nextBillDate = [DateManager stringFromServerResponseString:[attributeDict valueForKey:@"NextBillDate"] requiredFormat:MMMM_dd_yyyyFormat withTime:YES];
        
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
	if ([elementName isEqualToString:@"tns:FetchClubAccountsResponse"]) {	
		return;
	}
	else if ([elementName isEqualToString:@"Result"]) {		
		return;
	}	
	else if ([elementName isEqualToString:@"Text"]) {
		if (isError) {
			self.errorResult.resultText = value;			
		}
		else {
			self.clubAccounts.clubResult.resultText = value;
		}
	}	
	//Customer
	else if ([elementName isEqualToString:@"Customer"]) {
		isCustomer = NO;
		return;
	}
	else if ([elementName isEqualToString:@"CustomerId"]) {
		self.clubAccounts.accCustomer.customerId = value;		
	}
	else if ([elementName isEqualToString:@"CustomerGUID"]) {
		self.clubAccounts.accCustomer.customerGUID = value;		
	}	
	else if ([elementName isEqualToString:@"EmailAddress"]) {
		self.clubAccounts.accCustomer.emailAddress = value;
		
	}
	else if ([elementName isEqualToString:@"PhoneNumber"]) {
		self.clubAccounts.accCustomer.phoneNumber = value;
		
	}
	else if ([elementName isEqualToString:@"CustomerCode"]) {
		self.clubAccounts.accCustomer.customerCode = value;
		
	}	
	//Customer-Address
	else if ([elementName isEqualToString:@"Address"]) {
		return;
	}
	else if ([elementName isEqualToString:@"AddressLine1"]) {
		self.clubAccounts.accCustomer.address.addressLine1 = value;	
	}
	else if ([elementName isEqualToString:@"AddressLine2"]) {
		self.clubAccounts.accCustomer.address.addressLine2 = value;	
	}
	else if ([elementName isEqualToString:@"City"]) {
		clubAccounts.accCustomer.address.city = value;	
	}
	else if ([elementName isEqualToString:@"Province"]) {
		self.clubAccounts.accCustomer.address.province = value;	
	}
	else if ([elementName isEqualToString:@"Country"]) {
		self.clubAccounts.accCustomer.address.country = value;	
	}
	else if ([elementName isEqualToString:@"PostalCode"]) {
		self.clubAccounts.accCustomer.address.postalCode = value;	
	}
	
	//Account
	else if ([elementName isEqualToString:@"Account"]) {
		[self.clubAccounts.accounts addObject:account];
		[account release];
		account = nil;
		return;
	}
	else if ([elementName isEqualToString:@"Member"]) {		
		[account.members addObject:member];
		[member release];
		member = nil;
		isMember = NO;
		
		return;
	}
	else if ([elementName isEqualToString:@"VIPLevel"]) {
		if(isCustomer)
		{
			self.clubAccounts.accCustomer.VIPLevel = value;
		}
		if (isMember)		
		{
			member.VIPLevel = value;
		}
		return;
	}		
	else if ([elementName isEqualToString:@"Membership"]) {
		[account.memberShips addObject:memberShip];
		[memberShip release];
		memberShip = nil;
		isMembership = NO;
		return;
	}	
	else if ([elementName isEqualToString:@"Billing"]) {	
		return;
	}
	else if ([elementName isEqualToString:@"Salutation"]) {	
		if(isCustomer)
		{
			self.clubAccounts.accCustomer.salutation = value;
		}
		if(isMember)
		{
			member.salutation = value;	
		}
		if(isMembership)
		{
			memberShip.salutation = value;
		}
	}
	else if ([elementName isEqualToString:@"FirstName"]) {		
		if(isCustomer)
		{
			self.clubAccounts.accCustomer.firstName = value;
		}
		if(isMember)
		{
			member.firstName = value;
		}
		if(isMembership)
		{
			memberShip.firstName = value;
		}
	}
	else if ([elementName isEqualToString:@"LastName"]) {	
		if(isCustomer)
		{
			self.clubAccounts.accCustomer.lastName = value;
		}
		if(isMember)
		{
			member.lastName = value;
		}
		if(isMembership)
		{
			memberShip.lastName = value;
		}
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
		[self.delegate parsingComplete:self.clubAccounts];
	}
}

@end
