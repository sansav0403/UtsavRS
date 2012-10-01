    //
//  RSListViewController.m
//  ResortSuite
//
//  Created by Cybage on 27/07/11.
//  Copyright 2011 ResortSuite . All rights reserved.
//

#import "RSListViewController.h"
//#import "RSTableView.h"
//#import "RSTableViewCell.h"
#import "RSListViewNode.h"
//#import "RSDetailsPageViewController.h"
//#import "MapViewController.h"
//#import "RSMainViewController.h"
#import "BaseListTableViewCell.h"
#import "Gallery.h"

@implementation RSListViewController

@synthesize viewTitle, headerImage, dictionaryArray;

-(id)initViewWithNode:(RSListViewNode *)node
{
	self = [super init];
	if (self) {
		self.viewTitle = node.nodeTitle;
		self.headerImage = node.nodeHeader_Image;
		self.dictionaryArray = node.nodeDictionaryArray;
	}
	
	return self;
	
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];


}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return YES;
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
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	
	//Adding selected mask image to the selected row.    
	if ([[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_DetailPage_Key] != nil)
	{
		//To display Map on the screen, use Map View controller.
            if ([[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_DetailPage_Key]isEqualToString:@"Gallery"]) {
			Gallery *galleryVC = [[Gallery alloc] init];
			[self.navigationController pushViewController:galleryVC animated:YES];
			[galleryVC release];
		}		
		else {
//			RSDetailsPageViewController *detailPage = [[RSDetailsPageViewController alloc]initWithNibName:@"RSDetailsPageViewController" 
//																								   bundle:nil
//																								viewTitle:[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_Title_Key] 
//																								viewImage:[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_Header_Image_Key] 
//																								  content:[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_DetailPage_Key] ];
//			[self.navigationController pushViewController:detailPage animated:YES];
//			[detailPage release];
			

			
		}

	}
	else 
	{
		RSListViewNode *nextNode = [[RSListViewNode alloc]initWithTitle:[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_Title_Key] 
												HeaderImage:[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_Header_Image_Key]
												  IConImage:[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_Thumbnail_Image_Key]
												  NodeArray:[[dictionaryArray objectAtIndex:indexPath.section]objectForKey:Plist_DictionaryArray_Key] ];
		
		RSListViewController * nextListController = [[RSListViewController alloc]initViewWithNode:nextNode];
		[self.navigationController pushViewController:nextListController animated:YES];
		[nextListController release];
		[nextNode release];
			
		
	}


}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[viewTitle release];
	[headerImage release];
	[dictionaryArray release];
    [super dealloc];
}


@end
