//
//  RSGroupMainVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/21/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSGroupMainVC.h"
#import "RSMyItineraryModel.h"
#import "RSMGByDateVC.h"
#import "RSMGByCategoryVC.h"
#import "RSMGEventsTableVC.h"
#import "DateManager.h"
@implementation RSGroupMainVC

@synthesize guestItinerary;

-(void)dealloc
{
    [mainFieldArray release];
    [guestItinerary release];
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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withGuestItinerary:(RSMyItineraryModel *)itineraryModel;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.guestItinerary = itineraryModel;
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
    [self.headerImageView setImage:[UIImage imageNamed:GroupItinerary_HI]];//
    self.title = MyGroup_ViewTilte;
    mainFieldArray = [[NSArray alloc]initWithObjects:ItineraryCategory_ByDate,ItineraryCategory_ByCategory,ItineraryCategory_ByAll, nil];
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
    switch (indexPath.section)
	{
		case ByDatesSection:
        {
            NSDictionary *dateDictionary = [self dictionaryOfGroupEventsWithDatesAsKeys];
            RSMGByDateVC *groupItineraryByDate = [[RSMGByDateVC alloc]initWithNibName:@"BaseListViewController" bundle:[NSBundle mainBundle] withDateDictionary:dateDictionary];
            [self.navigationController pushViewController:groupItineraryByDate animated:YES];
            [groupItineraryByDate release];
        }
			break;
		case ByCategoriesSecion:
        {
            NSDictionary *categoryDictionary = [self dictionaryOfGroupEventsWithCategoriesAsKeys];
            RSMGByCategoryVC *groupItineraryByCategory = [[RSMGByCategoryVC alloc]initWithNibName:@"BaseListViewController" bundle:[NSBundle mainBundle] withCategoryDictionay:categoryDictionary];
            [self.navigationController pushViewController:groupItineraryByCategory animated:YES];
            [groupItineraryByCategory release];
        }			
			break;
		case AllEventsSection:
        {
            NSDictionary *folioDateDictionary = [self dictionaryOfGroupEventsWithDatesAsKeys];
            RSMGEventsTableVC *eventTable = [[RSMGEventsTableVC alloc]initWithNibName:@"RSMIEventsTableVC" bundle:[NSBundle mainBundle] withDateDictionary:folioDateDictionary];
            eventTable.title =  ItineraryCategory_ByAll;
            [self.navigationController pushViewController:eventTable animated:YES];
            [eventTable release];
        }
			break;
		default:
			break;
	}

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
    }
    switch (indexPath.section)
	{
		case ByDatesSection:
			cell.cellImageView.image = [UIImage imageNamed:GroupItineraryByDate_Icon];
			break;
		case ByCategoriesSecion:
			cell.cellImageView.image = [UIImage imageNamed:GroupItineraryByCategory_Icon];
			break;
		case AllEventsSection:
			cell.cellImageView.image = [UIImage imageNamed:GroupItinerary_Icon];
			break;
		default:
			break;
	}
    cell.cellText.text = [mainFieldArray objectAtIndex:indexPath.section];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [mainFieldArray count];
}

#pragma mark - dictionary creation methods
-(NSDictionary *)dictionaryOfGroupEventsWithDatesAsKeys
{
    
    NSArray *GroupEventArray = [[NSArray alloc]initWithArray:self.guestItinerary.groupEvents.groupEventsArr];
 //create the dictionary with date as keys	

    NSMutableDictionary *dateDictionary = [[NSMutableDictionary alloc]init];
 
    for(int eventIndex=0; eventIndex<[GroupEventArray count]; eventIndex++)
    {
        NSArray *lkeyArray = [dateDictionary allKeys];
        GroupEvent *groupEvent = [GroupEventArray objectAtIndex:eventIndex];//get the obj at index
        NSDate *keyDate = [self stringToDate:[self stringFromDate:[groupEvent formatedStartTime]]];	//to act as akey get only the date
 
        if ([lkeyArray containsObject:keyDate])
        {
            NSMutableArray *localEventArray = [dateDictionary objectForKey:keyDate];
            [localEventArray addObject:groupEvent];
            [dateDictionary setObject:localEventArray forKey:keyDate];
        }
        else 
        {
            NSMutableArray *localEventArray = [[NSMutableArray alloc] initWithObjects:groupEvent,nil];
            [dateDictionary setObject:localEventArray forKey:keyDate];
            [localEventArray release];

        }	
    }

     
    [GroupEventArray release];

    return [dateDictionary autorelease];
}

-(NSDictionary *)dictionaryOfGroupEventsWithCategoriesAsKeys
{
    
    NSArray *GroupEventArray = [[NSArray alloc]initWithArray:self.guestItinerary.groupEvents.groupEventsArr];
    //create the dictionary with date as keys	

	NSMutableDictionary *categoryDictionary = [[NSMutableDictionary alloc]init];
	for(int eventIndex=0; eventIndex<[GroupEventArray count]; eventIndex++)	//geting obj from the sorted event objs
	{
		NSArray *lkeyArray = [categoryDictionary allKeys];
		GroupEvent *groupEvent = [GroupEventArray objectAtIndex:eventIndex];//get the obj at index
		NSString *keycategory = groupEvent.eventCategory;	//to act as akey 
        
		
		if ([lkeyArray containsObject:keycategory])
		{
			NSMutableArray *localEventArray = [categoryDictionary objectForKey:keycategory];
			[localEventArray addObject:groupEvent];
			[categoryDictionary setObject:localEventArray forKey:keycategory];
		}
		else 
		{
			NSMutableArray *localEventArray = [[NSMutableArray alloc] initWithObjects:groupEvent,nil];
			[categoryDictionary setObject:localEventArray forKey:keycategory];
			[localEventArray release];
		}
        
	}

    
    [GroupEventArray release];
    return [categoryDictionary autorelease];

}


-(NSString *)stringFromDate:(NSDate *)date
{
     NSString *stringDate = [DateManager stringFromDate:date withDateFormat:EEEE_MMMM_d_yyyyFormat];
	return stringDate;
}

-(NSDate *)stringToDate:(NSString *)stringDate 
{
    NSDate* date = [DateManager dateFromString:stringDate withDateFormat:EEEE_MMMM_d_yyyyFormat];
	return date;
}

@end
