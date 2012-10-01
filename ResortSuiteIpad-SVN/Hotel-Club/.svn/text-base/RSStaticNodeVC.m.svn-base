//
//  RSStaticNodeVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/16/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSStaticNodeVC.h"
#import "RSAppDelegate.h"
#import "Gallery.h"
#import "RSListViewNode.h"
#import "RSDetailPageVC.h"
#import "MapViewController.h"
#import "RSDetailPageWithoutHeaderVC.h"
@implementation RSStaticNodeVC
@synthesize viewTitle, headerImage, dictionaryArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withNode:(RSListViewNode *)node
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.viewTitle = node.nodeTitle;
		self.headerImage = node.nodeHeader_Image;
		self.dictionaryArray = node.nodeDictionaryArray;
    }
    return self;
}
-(void)dealloc
{
    DLog(@"RSStaticNodeVC dealloc");
    [viewTitle release];
	[headerImage release];
	[dictionaryArray release];
    [super dealloc];
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
    self.title = self.viewTitle;
    [self.headerImageView setImage:[UIImage imageNamed:self.headerImage]];
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

    return [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [dictionaryArray count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
	//Create a custom cell to display content on the screen
    BaseListTableViewCell *cell = (BaseListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *customCellArray = [[NSBundle mainBundle]loadNibNamed:@"BaseListTableViewCell" owner:nil options:nil];
        
        for (id currerntObject in customCellArray) {
            if ([currerntObject isKindOfClass:[BaseListTableViewCell class]]) {
                cell = (BaseListTableViewCell *)currerntObject;
                break;
            }
        }

    }
    
	//Create a lable to display the content in the cell
	cell.cellText.text = [[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_Title_Key];
	
	//Create a image thumbnail which will come under each cell
	cell.cellImageView.image = [UIImage imageNamed:[[dictionaryArray objectAtIndex:indexPath.section] objectForKey:Plist_Thumbnail_Image_Key]];
	
    
	
	//Edit accessory view for directional button
//    if ([[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_DetailPage_Key] != nil)
//    {
//    		[cell EditAccessoryView];
//    }
    return cell;
}

#pragma mark -
#pragma mark Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	
	//Adding selected mask image to the selected row.
        BaseListTableViewCell *cell = (BaseListTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.cellOverlayImageView.image = [UIImage imageNamed:SelectedTableCellBackgroudImage];

    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
	if ([[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_DetailPage_Key] != nil)
	{
		//To display Map on the screen, use Map View controller.
       		if ([[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_DetailPage_Key]isEqualToString:@"Map"]) {
                    //get array of dictionary for location
                    NSArray *plistlocationArray = [[NSArray alloc]initWithArray:[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:@"Locations"]];
                    NSString *infoPage = [[NSString alloc]initWithString:[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:@"Info"]];
                    NSString *infoPageTitle = [[NSString alloc]initWithString:[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:@"InfoTitle"]];
                    DLog(@"info page = %@",infoPage);
    			MapViewController *mapVC = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:[NSBundle mainBundle]];
                    mapVC.locationArray = plistlocationArray;
                   mapVC.InfoButtonPageName = infoPage;
                    mapVC.InfoButtonPageTitle = infoPageTitle;
        			[self.navigationController pushViewController:mapVC animated:YES];
                    [plistlocationArray release];
                    [infoPage release];
                    [infoPageTitle release];
        			[mapVC release];
                    
        		}
    else if ([[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_DetailPage_Key]isEqualToString:@"Gallery"]) {
			Gallery *galleryVC = [[Gallery alloc] init];
			[self.navigationController pushViewController:galleryVC animated:YES];
			[galleryVC release];
		}		
		else {//check if to load detail with or without header image
            if ([[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_Header_Image_Key] isEqualToString:@""]) {
                RSDetailPageWithoutHeaderVC *detailPageWithoutHeader = [[RSDetailPageWithoutHeaderVC alloc]initWithNibName:@"RSDetailPageWithoutHeaderVC" bundle:[NSBundle mainBundle] viewTitle:[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_Title_Key] content:[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_DetailPage_Key]];
                [self.navigationController pushViewController:detailPageWithoutHeader animated:YES];
                [detailPageWithoutHeader release];
            }
            else{
            			RSDetailPageVC *detailPage = [[RSDetailPageVC alloc]initWithNibName:@"RSDetailPageVC" 
                                    bundle:[NSBundle mainBundle]
                                viewTitle:[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_Title_Key] 
                                viewImage:[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_Header_Image_Key] 
                                content:[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_DetailPage_Key] ];
            
            			[self.navigationController pushViewController:detailPage animated:YES];
            			[detailPage release];
            }
		}
        
	}
	else 
	{
		RSListViewNode *nextNode = [[RSListViewNode alloc]initWithTitle:[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_Title_Key] 
                                                            HeaderImage:[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_Header_Image_Key]
                                                              IConImage:[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_Thumbnail_Image_Key]
                                                              NodeArray:[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_DictionaryArray_Key] ];
		
		RSStaticNodeVC * nextListController = [[RSStaticNodeVC alloc]initWithNibName:@"BaseListViewController" bundle:[NSBundle mainBundle] withNode:nextNode];
		[self.navigationController pushViewController:nextListController animated:YES];
		[nextListController release];
		[nextNode release];
        
		
	}
    
    
}

@end
