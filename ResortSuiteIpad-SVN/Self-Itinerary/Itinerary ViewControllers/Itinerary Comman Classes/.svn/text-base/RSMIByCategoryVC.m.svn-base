//
//  RSMIByCategoryVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/23/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSMIByCategoryVC.h"
#import "RSMIEventsTableVC.h"
#import "DateManager.h"
@implementation RSMIByCategoryVC

#define cellTextFrame CGRectMake(50, 25, 268, 22)
@synthesize categoryDictionary;

-(void)dealloc
{
    [categoryDictionary release];
    [categorySortedKeyArray release];
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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withCategoryDictionay:(NSDictionary *)ItineraryCategoryDictionary
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.categoryDictionary = ItineraryCategoryDictionary;
        categorySortedKeyArray = [[[self.categoryDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)]retain];
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
    [self.headerImageView setImage:[UIImage imageNamed:MyItineraryByCategory_HI]];
    self.title = ItineraryCategory_ByCategory;
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
    //Adding selected mask image to the selected row.
    BaseListTableViewCell *cell = (BaseListTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.cellOverlayImageView.image = [UIImage imageNamed:SelectedTableCellBackgroudImage];
    
    DLog(@"table row selected");
    /*create coresponding dictionary and send it to the next class*/
    NSString *dateKeyString = [categorySortedKeyArray objectAtIndex:indexPath.section];
    NSArray *arrayOfFolios = [self.categoryDictionary objectForKey:dateKeyString];
    /*create dic of date for that array of folio that is available for value for the key at hte present insex.section*/
    NSDictionary *folioDateDictionary = [self dictionaryofDateFromTheArrayofFolios:arrayOfFolios];
    RSMIEventsTableVC *eventTable = [[RSMIEventsTableVC alloc]initWithNibName:@"RSMIEventsTableVC" bundle:[NSBundle mainBundle] withDateDictionary:folioDateDictionary];
    eventTable.title =  [categorySortedKeyArray objectAtIndex:indexPath.section];
    [self.navigationController pushViewController:eventTable animated:YES];
    [eventTable release];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseListTableViewCell *cell = (BaseListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        NSArray *customCellArray = [[NSBundle mainBundle]loadNibNamed:@"BaseListTableViewCell" owner:nil options:nil];
        
        for (id currerntObject in customCellArray) {
            if ([currerntObject isKindOfClass:[BaseListTableViewCell class]]) {
                cell = (BaseListTableViewCell *)currerntObject;
                break;
            }
        }
        //cell.backgroundColor = [UIColor clearColor];
    }

    
    cell.cellText.text = [categorySortedKeyArray objectAtIndex:indexPath.section];
    
    //Create a image thumbnail which will come under each cell
	if([cell.cellText.text isEqualToString:Hotel_Itinerary_Title])
	{
#if defined(HOTEL_VERSION)
		cell.cellImageView.image = [UIImage imageNamed:Hotel_MyHotel_Icon];
#elif defined(CLUB_VERSION)
		cell.cellImageView.image = [UIImage imageNamed:Club_MyClub_Icon];
#endif
	}
	else if([cell.cellText.text isEqualToString:Hotel_SPA_Title])
	{
#if defined(HOTEL_VERSION)
		cell.cellImageView.image = [UIImage imageNamed:Hotel_SPA_Icon];
#elif defined(CLUB_VERSION)
		cell.cellImageView.image = [UIImage imageNamed:Club_SPA_Icon];
#endif
		
	}
	else if([cell.cellText.text isEqualToString:Hotel_GOLF_Title])
	{
#if defined(HOTEL_VERSION)
		cell.cellImageView.image = [UIImage imageNamed:Hotel_GOLF_Icon];
#elif defined(CLUB_VERSION)
		cell.cellImageView.image = [UIImage imageNamed:Club_GOLF_Icon];
#endif
		
	}
	else if([cell.cellText.text isEqualToString:Hotel_Dining_Title])
	{
#if defined(HOTEL_VERSION)
		cell.cellImageView.image = [UIImage imageNamed:Hotel_Dining_Icon];
#elif defined(CLUB_VERSION)
		cell.cellImageView.image = [UIImage imageNamed:Club_Dining_Icon];
#endif		
	}
	else if([cell.cellText.text isEqualToString:Hotel_Transportation_Title])
	{
#if defined(HOTEL_VERSION)
		cell.cellImageView.image = [UIImage imageNamed:Transportation_Icon];
#elif defined(CLUB_VERSION)
		cell.cellImageView.image = [UIImage imageNamed:Club_Transportation_Icon];
#endif		
	}
    else
    {
        //for the group category screen
        cell.cellText.frame = cellTextFrame;
        cell.cellOverlayImageView.hidden = YES;
        cell.cellImageView.hidden = YES;
    }

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [categorySortedKeyArray count];
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
		RSFolio *groupEvent = [sortedEventObjectArray objectAtIndex:objectIndex];//get the obj at index
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
//    
//	[dateFormatter setDateFormat:EEEE_MMMM_d_yyyyFormat];  
//    
//	
//	NSDate* date = (NSDate*)[dateFormatter dateFromString:stringDate];
//	[dateFormatter release];
    NSDate* date = (NSDate*)[DateManager dateFromString:stringDate withDateFormat:EEEE_MMMM_d_yyyyFormat];
	return date;
}
@end
