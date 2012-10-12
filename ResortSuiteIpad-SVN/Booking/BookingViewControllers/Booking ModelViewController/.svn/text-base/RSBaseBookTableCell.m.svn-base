//
//  RSDateselectionTableCell.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/27/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSBaseBookTableCell.h"

@implementation RSBaseBookTableCell

#define CELL_FONT_SIZE               13

@synthesize cellText;
@synthesize menuDetailText;


-(void)dealloc
{

    [cellText release];
    [menuDetailText release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.cellText.backgroundColor = [UIColor clearColor];
    self.cellText.font = [UIFont boldSystemFontOfSize:CELL_FONT_SIZE];
    self.cellText.highlightedTextColor = [UIColor blackColor];
    
    self.menuDetailText.textColor = [UIColor blackColor];
    self.menuDetailText.highlightedTextColor = [UIColor blackColor];
    self.menuDetailText.font = [UIFont systemFontOfSize:CELL_FONT_SIZE];
    [self.menuDetailText setTextAlignment:UITextAlignmentRight];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void) setAccessoryViewImage:(BOOL) isAccessoryImage
{
	self.accessoryType = UITableViewCellAccessoryNone;
	UIImageView* cellAccessoryImageView = [[UIImageView alloc] initWithFrame:CellAccessoryImageRect];
	if(isAccessoryImage)
	{
		cellAccessoryImageView.image = [UIImage imageNamed:CellAccessoryImage];
	}
	else {
		cellAccessoryImageView.image = [UIImage imageNamed:accessoryBlankImage];
	}
	cellAccessoryImageView.backgroundColor = [UIColor clearColor];
	self.accessoryView = cellAccessoryImageView;
	[cellAccessoryImageView release];
}


- (void) setBgForSelectedCell:(UITableView *) tableView forIndex:(NSIndexPath *) indexPath
{
	//Image setting for selected tableviewcell		
	UIImageView *selectionBackground = [[UIImageView alloc] init];
	NSInteger sectionRows = [tableView numberOfRowsInSection:[indexPath section]];
	NSInteger row = [indexPath row];
	
	if (row == 0 && row == sectionRows - 1)
	{
		selectionBackground.image = [UIImage imageNamed:option_arrow_image];
	}
	else if (row == 0)
	{
		selectionBackground.image = [UIImage imageNamed:top_arrow_image];
	}
	else if (row == sectionRows - 1)
	{
		selectionBackground.image = [UIImage imageNamed:bottom_arrow_image];
	}
	else
	{
		selectionBackground.image = [UIImage imageNamed:mid_arrow_image];
	}
	
	self.selectedBackgroundView = selectionBackground;
	[selectionBackground release];
}


@end
