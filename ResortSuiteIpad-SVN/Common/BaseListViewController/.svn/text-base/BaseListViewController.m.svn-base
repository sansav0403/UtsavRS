//
//  BaseListViewController.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/15/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "BaseListViewController.h"


@implementation BaseListViewController
#define footerheight        20
#define NumberOfSection     3
@synthesize listTableView;
@synthesize headerImageView;
@synthesize headerOverlayImageView;
@synthesize serviceActivity;
-(void)dealloc
{
    [headerImageView release];
    [headerOverlayImageView release];
    [listTableView release];
    [serviceActivity release];
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
    [baseView.baseBGOverlayImageView removeFromSuperview];  //to remove the extra white overly
    [self.listTableView setBackgroundColor:[UIColor clearColor]];
    [self.serviceActivity stopAnimating];
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

    return [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];  
}

#pragma mark - TableView Delegate Method

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];//unseslected-imgPlaceholder
    if ([cell isKindOfClass:[BaseListTableViewCell class]]) {
        BaseListTableViewCell * cell1 = (BaseListTableViewCell *)cell;
        cell1.cellOverlayImageView.image = [UIImage imageNamed:ListCellUnselectedImageHolder];
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"table row selected");
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
        UIImageView *seelctedBG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:ListCellSelectedBG]];
        cell.selectedBackgroundView = seelctedBG;
        [seelctedBG release];
        
        
        for (id currerntObject in customCellArray) {
            if ([currerntObject isKindOfClass:[BaseListTableViewCell class]]) {
                cell = (BaseListTableViewCell *)currerntObject;
                break;
            }
        }

    }
    cell.cellText.text = @"base listVC cell";   //this is a test text only
    return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, footerheight )];
    footerView.backgroundColor = [UIColor clearColor];
    return [footerView autorelease];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, footerheight )];
    footerView.backgroundColor = [UIColor clearColor];
    return [footerView autorelease];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return NumberOfSection;
}
@end
