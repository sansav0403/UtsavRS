//
//  RSItineraryMainVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/21/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSItineraryMainVC.h"
#import "RSMyItineraryModel.h"

#import "RSMIByDateVC.h"
#import "RSMIByCategoryVC.h"
#import "RSMIEventsTableVC.h"
#import "DateManager.h"
@implementation RSItineraryMainVC

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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withGuestItinerary:(RSMyItineraryModel *)itineraryModel
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
    
    [self.headerImageView setImage:[UIImage imageNamed:MyItinerary_HI]];
    self.title = MyItitnerary_ViewTite;
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
    /*create coresponding dictionary and send it to the next class*/
    switch (indexPath.section)
	{
		case ByDateSection:
        {
            NSDictionary *dateDictionary = [self dictionaryOfFoliosWithDatesAsKeys];
            RSMIByDateVC *myItineraryByDate = [[RSMIByDateVC alloc]initWithNibName:@"BaseListViewController" bundle:[NSBundle mainBundle] withDateDictionary:dateDictionary];
            [self.navigationController pushViewController:myItineraryByDate animated:YES];
            [myItineraryByDate release];
        }
			break;
		case ByCategorySection:
        {
            NSDictionary *categoryDictionary = [self dictionaryOfFoliosWithCategoriesAsKeys];
            RSMIByCategoryVC *myItineraryByCategory = [[RSMIByCategoryVC alloc]initWithNibName:@"BaseListViewController" bundle:[NSBundle mainBundle] withCategoryDictionay:categoryDictionary];
            [self.navigationController pushViewController:myItineraryByCategory animated:YES];
            [myItineraryByCategory release];
        }			
			break;
		case AllSection:
        {
            NSDictionary *folioDateDictionary = [self dictionaryOfFoliosWithDatesAsKeys];
            RSMIEventsTableVC *eventTable = [[RSMIEventsTableVC alloc]initWithNibName:@"RSMIEventsTableVC" bundle:[NSBundle mainBundle] withDateDictionary:folioDateDictionary];
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
        //cell.backgroundColor = [UIColor clearColor];
    }
    //Create a image thumbnail which will come under each cell
	switch (indexPath.section)
	{
		case ByDateSection:
			cell.cellImageView.image = [UIImage imageNamed:MyItineraryByDate_Icon];
			break;
		case ByCategorySection:
#if defined(HOTEL_VERSION)
			cell.cellImageView.image = [UIImage imageNamed:MyItineraryByCategory_Icon];
#elif defined(CLUB_VERSION)
			cell.cellImageView.image = [UIImage imageNamed:Club_MyItineraryByCategory_Icon];
#endif
			
			break;
		case AllSection:
			cell.cellImageView.image = [UIImage imageNamed:MyItinerary_Icon];
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
-(NSDictionary *)dictionaryOfFoliosWithDatesAsKeys
{
    
     NSArray *folioArray = [[NSArray alloc]initWithArray:self.guestItinerary.guestBookings.folios];
//     NSMutableArray *dateKeyArray = [[NSMutableArray alloc] init];	//array of key in the dic
     NSMutableDictionary *dateDictionary = [[NSMutableDictionary alloc]init];
     for(int folioIndex=0; folioIndex<[folioArray count]; folioIndex++)
     {
         NSArray *lkeyArray = [dateDictionary allKeys];
         RSFolio *folio = [folioArray objectAtIndex:folioIndex];//get the obj at index
         NSDate *keyDate = [self stringToDate:[self stringFromDate:[folio formatedStartDate]]];	//to act as akey
     
         if ([lkeyArray containsObject:keyDate])
         {
             NSMutableArray *localEventArray = [dateDictionary objectForKey:keyDate];
             [localEventArray addObject:folio];
             [dateDictionary setObject:localEventArray forKey:keyDate];
         }
         else 
         {
             NSMutableArray *localEventArray = [[NSMutableArray alloc] initWithObjects:folio,nil];
             [dateDictionary setObject:localEventArray forKey:keyDate];
             [localEventArray release];

         }

     }
     [folioArray release];

     
    return [dateDictionary autorelease];
}
-(NSDictionary *)dictionaryOfFoliosWithCategoriesAsKeys
{
    
     NSArray *GroupEventArray = [[NSArray alloc]initWithArray:self.guestItinerary.guestBookings.folios];
     
     //create the dictionary with date as keys	
    
     NSMutableDictionary *categoryDictionary = [[NSMutableDictionary alloc]init];
     
     for(int eventIndex=0; eventIndex<[GroupEventArray count]; eventIndex++)	//geting obj from the sorted event objs
     {
     NSArray *lkeyArray = [categoryDictionary allKeys];
     RSFolio *groupEvent = [GroupEventArray objectAtIndex:eventIndex];//get the obj at index
     
     NSString *keycategory;	//to act as akey 
         switch ([groupEvent appType]) {
             case Hotel:
                 keycategory = Hotel_Itinerary_Title;    //in constant.h
                 break;
             case Spa:
                 keycategory = Hotel_SPA_Title;          //in teaserbuildconstant
                 break;
             case Golf:
                 keycategory = Hotel_GOLF_Title;         //in teaserbuildconstant
                 break;
             case Dining:
                 keycategory = Hotel_Dining_Title;       //in teaserbuildconstant
                 break;
             case Transportation:
                 keycategory = Hotel_Transportation_Title;   //in constant.h
                 break;
             default:
                 keycategory = @"";
                 break;
            }
     
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
