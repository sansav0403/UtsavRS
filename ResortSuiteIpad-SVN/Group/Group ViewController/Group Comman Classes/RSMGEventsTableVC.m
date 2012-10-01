//
//  RSMIEventsTableVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/24/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSMGEventsTableVC.h"
#import "RSMIEventTableCell.h"
#import "RSGroupEvents.h"
#import "RSMGEventDescVC.h"
#import "customAccesoryButton.h"

@implementation RSMGEventsTableVC

@synthesize FolioTable;
@synthesize folioDateDictionary;

-(void)dealloc
{
    [FolioTable release];
    [folioDateDictionary release];
    [dateKeySortedArray release];
    
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
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withDateDictionary:(NSDictionary *)dateDictionary
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.folioDateDictionary = dateDictionary;
        NSArray *dateKeyArray = [self.folioDateDictionary allKeys];
        dateKeySortedArray = [[NSArray alloc]initWithArray:[dateKeyArray sortedArrayUsingSelector:@selector(compare:)]];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    	GroupEvent *event = (GroupEvent *)[[folioDateDictionary objectForKey:[dateKeySortedArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
    RSMGEventDescVC *groupEventDescVC = [[RSMGEventDescVC alloc]initWithNibName:@"RSMGEventDescVC" bundle:[NSBundle mainBundle] WithGroupEvent:event];
    [self.navigationController pushViewController:groupEventDescVC animated:YES];
    [groupEventDescVC release];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.folioDateDictionary objectForKey:[dateKeySortedArray objectAtIndex:section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RSMIEventTableCell *cell = (RSMIEventTableCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        NSArray *customCellArray = [[NSBundle mainBundle]loadNibNamed:@"RSMIEventTableCell" owner:nil options:nil];
        
        for (id currerntObject in customCellArray) {
            if ([currerntObject isKindOfClass:[RSMIEventTableCell class]]) {
                cell = (RSMIEventTableCell *)currerntObject;
                break;
            }
        }
       
    }

    
    customAccesoryButton *dButton = (customAccesoryButton *)cell.customAccessoryButton;
    dButton.path = indexPath;
	[dButton addTarget:self action:@selector(checkThis:) forControlEvents:UIControlEventTouchDown];
    
    [self setCellDataForCell:cell ForIndexPath:indexPath];
    return cell;
}
-(void)checkThis:(id*)sender{
	customAccesoryButton *btn = (customAccesoryButton *)sender;
	NSIndexPath * indexPath	= btn.path;
	
    GroupEvent *event = (GroupEvent *)[[folioDateDictionary objectForKey:[dateKeySortedArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
    RSMGEventDescVC *groupEventDescVC = [[RSMGEventDescVC alloc]initWithNibName:@"RSMGEventDescVC" bundle:[NSBundle mainBundle] WithGroupEvent:event];
    [self.navigationController pushViewController:groupEventDescVC animated:YES];
    [groupEventDescVC release];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 20 )];
    footerView.backgroundColor = [UIColor clearColor];
    return [footerView autorelease];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
	NSDate *detailedDate = [dateKeySortedArray objectAtIndex:section];
	[dateFormat setDateFormat:EEEE_MMMM_d_yyyyFormat];
	
	UILabel *sectionLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 2, 280, 18)];
	sectionLabel.font = [UIFont boldSystemFontOfSize:FontOfSize18];
	sectionLabel.text = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:detailedDate]];
	sectionLabel.textColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0];
	sectionLabel.backgroundColor = [UIColor whiteColor];
	
	[dateFormat release];
	
	UIView * sectionHeaderView = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 280, 20)]autorelease];
	sectionHeaderView.backgroundColor  = [UIColor colorWithPatternImage:[UIImage imageNamed:DetailPageSectionBG]];
	[sectionHeaderView addSubview:sectionLabel];
	[sectionLabel release];
	return sectionHeaderView;
	
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [dateKeySortedArray count];
}


#pragma mark setting celldata
-(void)setCellDataForCell:(RSMIEventTableCell *)cell ForIndexPath:(NSIndexPath *)indexPath
{
	[self resetDataIn:cell];
	
	GroupEvent *event = (GroupEvent *)[[folioDateDictionary objectForKey:[dateKeySortedArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
	
    
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
	NSDate *detailedDate = [event formatedStartTime];
	[dateFormat setDateFormat:hh_mm_aFormat];
	
	cell.startTimeLabel.text = [NSString stringWithFormat:@" %@",[dateFormat stringFromDate:detailedDate]];//startTime
	
	detailedDate = [event formatedEndTime];
	[dateFormat setDateFormat:hh_mm_aFormat];	
    
	cell.endTimeLabel.text = [NSString stringWithFormat:@" %@",[dateFormat stringFromDate:detailedDate]];
	cell.FolioDetailLabel.text = [NSString stringWithFormat:@" %@ ",[event eventName]];
	
	
	[dateFormat release];	
}
-(void) resetDataIn:(RSMIEventTableCell *)cell
{
    cell.FolioDetailLabel.text = @"";
    cell.startTimeLabel.text = @"";
    cell.endTimeLabel.text = @"";
	
}

@end
