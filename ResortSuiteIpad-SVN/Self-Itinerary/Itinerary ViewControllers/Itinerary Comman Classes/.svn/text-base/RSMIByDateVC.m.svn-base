//
//  RSMIByDateVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/23/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSMIByDateVC.h"
#import "RSMIByDateCustomCell.h"
#import "RSMIEventsTableVC.h"
#import "DateManager.h"
@implementation RSMIByDateVC
@synthesize dateDictionary;

-(void)dealloc
{
    [dateDictionary release];
    [dateSortedKeyArray release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withDateDictionary:(NSDictionary *)itineraryDateDictionary
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code
        self.dateDictionary = itineraryDateDictionary;
        dateSortedKeyArray = [[[self.dateDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)]retain];   //datesorted key array is auto released?
    }
    return self;
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.headerImageView setImage:[UIImage imageNamed:MyItineraryByDate_HI]];
    self.title = ItineraryCategory_ByDate;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];
	return YES;
}


 #pragma mark - TableView Delegate Method
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 DLog(@"table row selected");
     
     NSString *dateKeyString = [dateSortedKeyArray objectAtIndex:indexPath.section];
     NSArray *arrayOfFolios = [self.dateDictionary objectForKey:dateKeyString];
     /*create dic of date for that array of folio that is available for value for the key at hte present insex.section*/
     NSDictionary *folioDateDictionary = [self dictionaryofDateFromTheArrayofFolios:arrayOfFolios];
     RSMIEventsTableVC *eventTable = [[RSMIEventsTableVC alloc]initWithNibName:@"RSMIEventsTableVC" bundle:[NSBundle mainBundle] withDateDictionary:folioDateDictionary];
     eventTable.title =  [self stringFromDate:[dateSortedKeyArray objectAtIndex:indexPath.section]];
     [self.navigationController pushViewController:eventTable animated:YES];
     [eventTable release];

 }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RSMIByDateCustomCell *cell = (RSMIByDateCustomCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        NSArray *customCellArray = [[NSBundle mainBundle]loadNibNamed:@"RSMIByDateCustomCell" owner:nil options:nil];
        
        for (id currerntObject in customCellArray) {
            if ([currerntObject isKindOfClass:[RSMIByDateCustomCell class]]) {
                cell = (RSMIByDateCustomCell *)currerntObject;
                break;
            }
        }
        //cell.backgroundColor = [UIColor clearColor];
    }
    
    
    cell.cellDateText.text = [self stringFromDate:[dateSortedKeyArray objectAtIndex:indexPath.section]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [dateSortedKeyArray count];
}

-(NSString *)stringFromDate:(NSDate *)date
{
//	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc]init] autorelease];
//	[dateFormatter setDateFormat:EEEE_MMMM_d_yyyyFormat];
//    NSString *stringDate = [dateFormatter stringFromDate:date];
    NSString *stringDate = [DateManager stringFromDate:date withDateFormat:EEEE_MMMM_d_yyyyFormat];
	return stringDate;
}

-(NSDate *)stringToDate:(NSString *)stringDate 
{
//	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//	[dateFormatter setDateFormat:EEEE_MMMM_d_yyyyFormat];  
//	NSDate* date = (NSDate*)[dateFormatter dateFromString:stringDate];
//	[dateFormatter release];
    NSDate* date = (NSDate*)[DateManager dateFromString:stringDate withDateFormat:EEEE_MMMM_d_yyyyFormat];
	return date;
}

-(NSDictionary *)dictionaryofDateFromTheArrayofFolios:(NSArray *)folioArray
{
    //soting the folio by date...
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"formatedStartDate" ascending:YES] ;
	
	NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];       //autorelease   
	NSArray *sortedEventObjectArray = [[NSArray alloc]initWithArray:[folioArray sortedArrayUsingDescriptors:sortDescriptors] ];
    
    //
    //create a dictionry by date(day)

	NSMutableDictionary *folioDateDictionary = [[NSMutableDictionary alloc]init];
	for(int objectIndex=0; objectIndex<[sortedEventObjectArray count]; objectIndex++)
	{
		NSArray *lkeyArray = [folioDateDictionary allKeys];
		RSFolio *groupEvent = [sortedEventObjectArray objectAtIndex:objectIndex];//get the obj at index//groupEvent for groups
		NSDate *keyDate = [self stringToDate:[self stringFromDate:[groupEvent formatedStartDate]]];	//to act as akey get only the date
		
		if ([lkeyArray containsObject:keyDate])
		{
			NSMutableArray *localEventArray = [folioDateDictionary objectForKey:keyDate];
			[localEventArray addObject:groupEvent];
			[folioDateDictionary setObject:localEventArray forKey:keyDate];
		}
		else 
		{
			NSMutableArray *localEventArray = [[NSMutableArray alloc] initWithObjects:groupEvent,nil];
			[folioDateDictionary setObject:localEventArray forKey:keyDate];
			[localEventArray release];

		}
	}
	[sortedEventObjectArray release];
    [sortDescriptor release];
    
    return [folioDateDictionary autorelease];
}
@end
