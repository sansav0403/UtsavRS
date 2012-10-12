//
//  RSDateTimeSelectionVC.m
//  Ipad-ResortSuite
//
//  Created by Cybage on 2/29/12.
//  Copyright (c) 2012 ResortSuite. All rights reserved.
//

#import "RSDateTimeSelectionVC.h"

#import "RSSelectedGolfLocation.h"
#import "RSSelectedSpaLocation.h"
#import "RSBaseBookTableCell.h"
#import "DateManager.h"
@implementation RSDateTimeSelectionVC
@synthesize dateTable;
@synthesize datePicker;
@synthesize instructionLbl;
@synthesize searchButton;

@synthesize pickerType;
@synthesize dateString;
@synthesize timeString;
@synthesize isGolf;

-(void)dealloc
{
    [subFieldArray release];        
    [mainFieldArray release];
    
    [dateString release];
    [timeString release];
    
    [dateTable release];
    [datePicker release];
    [searchButton release];
    [instructionLbl release];

    [dayTimes release];
    
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
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withSection:(int) section dateString:(NSString *) dateStr
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        pickerType = section;
        
        DLog(@"DATE STRING : %@",dateStr);
        if(pickerType == DatePicker )
        {
            self.dateString = dateStr;
        }
        else if(pickerType == TimePicker)
        {
            self.timeString = dateStr;
        }

    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withSection:(int) section dateString:(NSString *) dateStr timeString:(NSString *) timeStr
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        pickerType = section;
        
        DLog(@"DATE STRING : %@",dateStr);
        DLog(@"TIME STRING : %@",timeStr);
        
        self.dateString = dateStr;
        if(pickerType == TimePicker)
        {
//            self.dateString = dateStr;
            self.timeString = timeStr;
        }

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
    if (mainFieldArray) {
		[mainFieldArray removeAllObjects];
		[mainFieldArray release];
        mainFieldArray = nil;
	}
	if (pickerType == DatePicker) {
		mainFieldArray = [[NSMutableArray alloc] initWithObjects:kDateTitle,nil];	
	}
	else if (pickerType == TimePicker) {
		mainFieldArray = [[NSMutableArray alloc] initWithObjects:kTimeTitle,nil];
	}
	
	if (subFieldArray) {
		[subFieldArray removeAllObjects];
		[subFieldArray release];
        subFieldArray = nil;
	}
    dayTimes = [[NSMutableArray alloc]initWithObjects:@"",@"", nil]; //place emty string for start/end time
    // alloc befre callin addcontrols function
    //Add UI controls to the view-----------------
    [self setControllers];
   // --------------------------------- ---------------------------------   ---------------------------------
    
	if (pickerType == DatePicker && ![self.dateString isEqualToString:NONE])    //if none set the array with current time
    {
        subFieldArray = [[NSMutableArray alloc] initWithObjects:self.dateString, nil];
	}
	else if (pickerType == TimePicker && ![self.timeString isEqualToString:NONE])
    { 
        subFieldArray = [[NSMutableArray alloc] initWithObjects:self.timeString, nil];
	}
    //if time / date string sent are none then get the date/time from picker and update subarray
	else  if (pickerType == TimePicker )    
    {
		subFieldArray = [[NSMutableArray alloc] initWithObjects:NONE, nil];
        //-------------------------
        NSDate *pickerDate = datePicker.date;
        DLog(@"time before: %@",datePicker.date);
       
        
        [subFieldArray removeObjectAtIndex:indexZero];
        [subFieldArray insertObject:[DateManager stringFromDate:pickerDate withDateFormat:hh_mm_aFormat] atIndex:indexZero];

        //-------------------------
	}	
    else if(pickerType == DatePicker)
    {
        subFieldArray = [[NSMutableArray alloc] initWithObjects:NONE, nil];
        //------------------------                
        NSDate *pickerDate = datePicker.date;
        DLog(@"date before: %@",datePicker.date);

        [subFieldArray removeObjectAtIndex:indexZero];
        [subFieldArray insertObject:[DateManager stringFromDate:pickerDate withDateFormat:MMMM_dd_yyyyFormat] atIndex:indexZero];

        
        [self setMinimumAndMaximumTimeForTheSelectedDate: pickerDate];  //to set the start and end tiem of the day
        //-------------------------------
    }
}

-(void)setMinimumAndMaximumTimeForTheSelectedDate:(NSDate *)selectedDate
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];    
    NSDateComponents *weekdayComponents =[gregorian components:NSWeekdayCalendarUnit fromDate:selectedDate];    
    NSInteger weekday = [weekdayComponents weekday];
	[gregorian release];
	
    if(isGolf)
    {
        [self createStartAndEndTimeForGolfWithWeekday:weekday];
    }
    else
    {
        [self createStartAndEndTimeForSpaWithWeekday:weekday];
	}
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

-(void)createStartAndEndTimeForGolfWithWeekday:(NSInteger )weekday
{   
    RSSelectedGolfLocation *location = [RSSelectedGolfLocation sharedInstance];
    
    // weekday 1 = Sunday for Gregorian calendar
	switch (weekday)
    {
       	case SUNDAY:
        { 
            [self createSelectedDateTime:location.golfLocation.sundayOpen withEndTime:location.golfLocation.sundayClose];
        }            
            break;
        case MONDAY:
        {
            [self createSelectedDateTime:location.golfLocation.mondayOpen withEndTime:location.golfLocation.mondayClose];
        }
            break;
        case TUESDAY:
        {
            [self createSelectedDateTime:location.golfLocation.tuesdayOpen withEndTime:location.golfLocation.tuesdayClose];
        }
            break;
        case WEDNESDAY:
        {
            [self createSelectedDateTime:location.golfLocation.wednesdayOpen withEndTime:location.golfLocation.wednesdayClose];
        }
            break;
        case THRUSDAY:
        {			
            [self createSelectedDateTime:location.golfLocation.thursdayOpen withEndTime:location.golfLocation.thursdayClose];
            
        }
            break;
        case FRIDAY:
        {
            [self createSelectedDateTime:location.golfLocation.fridayOpen withEndTime:location.golfLocation.fridayClose];
        }
            break;
        case SATURDAY:
        {
            [self createSelectedDateTime:location.golfLocation.saturdayOpen withEndTime:location.golfLocation.saturdayClose];
        }
            break;
        default:
            break;
    }
    
}
-(void)createStartAndEndTimeForSpaWithWeekday:(NSInteger )weekday
{   
    //Get the selected Spa location from the shared instance
	RSSelectedSpaLocation *location = [RSSelectedSpaLocation sharedInstance];
	
	// weekday 1 = Sunday for Gregorian calendar
	switch (weekday)
    {
       	case SUNDAY:
        {
            [self createSelectedDateTime:location.spaLocation.sundayStart withEndTime:location.spaLocation.sundayEnd];
        }            
            break;
        case MONDAY:
        {
            [self createSelectedDateTime:location.spaLocation.mondayStart withEndTime:location.spaLocation.mondayEnd];
        }
            break;
        case TUESDAY:
        {
            [self createSelectedDateTime:location.spaLocation.tuesdayStart withEndTime:location.spaLocation.tuesdayEnd];
        }
            break;
        case WEDNESDAY:
        {
            [self createSelectedDateTime:location.spaLocation.wednesdayStart withEndTime:location.spaLocation.wednesdayEnd];
        }
            break;
        case THRUSDAY:
        {			
            [self createSelectedDateTime:location.spaLocation.thrusdayStart withEndTime:location.spaLocation.thrusdayEnd];
			
        }
            break;
        case FRIDAY:
        {
            [self createSelectedDateTime:location.spaLocation.fridayStart withEndTime:location.spaLocation.fridayEnd];
        }
            break;
        case SATURDAY:
        {
            [self createSelectedDateTime:location.spaLocation.saturdayStart withEndTime:location.spaLocation.saturdayEnd];
        }
            break;
        default:
            break;
    }
    
}

-(void) createSelectedDateTime:(NSString *)startTimeOfDay withEndTime:(NSString *)endTimeOfDay
{
    DLog(@"Start date %@ and EndDate %@",startTimeOfDay, endTimeOfDay );
    
    [dayTimes replaceObjectAtIndex:indexZero withObject:startTimeOfDay];
    [dayTimes replaceObjectAtIndex:indexOne withObject:endTimeOfDay];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DayTimesAccordingToDate" 
														object:dayTimes];
    //[dayTimes release];   //now released in dealloc
    
    selectedDateStartTime = [startTimeOfDay intValue];
    selectedDateEndTime = [endTimeOfDay intValue];
    
    if ([startTimeOfDay hasSuffix:PM_CAPITAL]) {
        selectedDateStartTime = [self convertTimeIn24Hour:selectedDateStartTime];				
    }			
    if ([endTimeOfDay hasSuffix:PM_CAPITAL]) {
        selectedDateEndTime = [self convertTimeIn24Hour:selectedDateEndTime]; 
    }
}

-(NSDate *)dateFromString:(NSString *)stringDate {
    DLog(@"DAte string Picker from string %@", stringDate);
    
//	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//	[dateFormatter setDateFormat:MMMM_dd_yyyyFormat];		
    
//	NSDate *Date = [dateFormatter dateFromString:stringDate];
    

//	[dateFormatter release];
    NSDate *Date = [DateManager dateFromString:stringDate withDateFormat:MMMM_dd_yyyyFormat];
    DLog(@"DAte Picker from string %@", Date);
	return Date;
	
}

//Convert the time in 24 hr clock time if time > 12 PM
#define timeformat 12
-(int) convertTimeIn24Hour: (int) time
{
	return (time + timeformat);
}

-(void) setControllers
{
    self.dateTable.backgroundView = nil;
    self.instructionLbl.text =pleaseSelectText;
	[self.instructionLbl setFont:[UIFont boldSystemFontOfSize:FontOfSize17]];
	self.instructionLbl.textColor = [UIColor colorWithRed:FontColor_Red green:FontColor_Green blue:FontColor_Blue alpha:1.0];
	
    
    //search button
    [self.searchButton setBackgroundColor:[UIColor clearColor]];
	//searchButton.enabled = NO;
    self.searchButton.enabled = YES;
	
	
	UIImage *btnImageDisabled  = [UIImage imageNamed:kDisabled_Button_img];
	
	UIImage *btnImageenabled  = [UIImage imageNamed:kEnabled_Button_img];
	
	[self.searchButton setBackgroundImage:btnImageDisabled forState:UIControlStateDisabled];
    [self.searchButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
	[self.searchButton setBackgroundImage:btnImageenabled forState:UIControlStateNormal];
    [self.searchButton setTitle:kSelect_Title forState:UIControlStateNormal];
    [self.searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.searchButton.titleLabel setFont:[UIFont boldSystemFontOfSize:kLabelTextFontSize]];
    [self.searchButton titleLabel].shadowOffset = CGSizeMake(0, 1);
    
    //Action for fetching the Spa Classes
	[self.searchButton addTarget:self action:@selector(selectDateOrTime:) 
                forControlEvents:UIControlEventTouchUpInside];
    
    
    
    self.datePicker.datePickerMode = UIDatePickerModeDate;
	
	if (pickerType == DatePicker) {     
        NSDate *minDate;
        
		if ([self.dateString isEqualToString:NONE]) {			//put a boolean to check if we dont want the picker  to start from today's date.
			self.datePicker.date = [NSDate date];    //booking start for today onwards
            DLog(@"Date Picker Date : %@",datePicker.date);	
        }
		else {			
			self.datePicker.date = [self dateFromString:self.dateString];
            DLog(@"Date Picker Date : %@",self.datePicker.date);
		}
		
		minDate = [NSDate dateWithTimeInterval:0 sinceDate: [NSDate date]];
		self.datePicker.minimumDate = minDate;
        
	}
	else if (pickerType == TimePicker) { //2,1
		NSDate *currentSelectedDate = [self dateFromString:self.dateString];
		
		[self setMinimumAndMaximumTimeForTheSelectedDate: currentSelectedDate];
		
		self.datePicker.minuteInterval = TIME_INTERVAL;
		self.datePicker.datePickerMode = UIDatePickerModeTime;
		self.datePicker.timeZone = [NSTimeZone localTimeZone];
		NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
		NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
		
		//set the date using setDate: setMonth: setYear:
		[dateComponents setHour:selectedDateStartTime]; // Lower bound as per 24 hrs Clock  
		NSDate *targetDate = [gregorian dateFromComponents:dateComponents];
		self.datePicker.minimumDate = targetDate;		
		
        if (![self.timeString isEqualToString:NONE])
        {			
            DLog(@"self time string = %@",self.timeString);
            NSString* forMinute = [self.timeString substringWithRange:NSMakeRange(3, 2)];
            
            if ([self.timeString hasSuffix:PM_CAPITAL] || [self.timeString hasSuffix:PM])
            {
                [dateComponents setHour:[self convertTimeIn24Hour:[self.timeString intValue] ]];  // Upper bound as per 24 hrs Clock    
            }
            else
            {
                [dateComponents setHour:[self.timeString intValue] ];  // Upper bound as per 24 hrs Clock    
            }
            [dateComponents setMinute:[forMinute intValue] ];  // Upper bound as per 24 hrs Clock    
            targetDate = [gregorian dateFromComponents:dateComponents];
            
//            [self.datePicker setDate:targetDate animated:YES];
		}
//        else
//        {
            [self.datePicker setDate:targetDate animated:YES];
//        }
		
		//set the date using setDate: setMonth: setYear:
		[dateComponents setHour:selectedDateEndTime];  // Upper bound as per 24 hrs Clock    
		targetDate = [gregorian dateFromComponents:dateComponents];
		self.datePicker.maximumDate = targetDate;
		
		[gregorian release];
		[dateComponents release];
	}
	
	[self.datePicker addTarget:self action:@selector(selectValueFromPicker:) forControlEvents:UIControlEventValueChanged];
	
}

-(void) selectDateOrTime: (id) sender
{
    
    //if selected for the first time then take todas date and send the notice. else take from array.
	[[NSNotificationCenter defaultCenter] postNotificationName:@"DatePickerValueChanged" 
														object:[subFieldArray objectAtIndex:0]];
	
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -  Date and Time picker selection methods

-(void)selectValueFromPicker:(id)sender
{
    UIDatePicker *tempPicker = (UIDatePicker *)sender;
    NSDate *pickerDate = tempPicker.date;
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	//[dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
	if (pickerType == DatePicker ) {
        
        //To set the start time for the selected date
		[self setMinimumAndMaximumTimeForTheSelectedDate: pickerDate];
        
		[dateFormatter setDateFormat:MMMM_dd_yyyyFormat];
	}
	else if (pickerType == TimePicker) {
		[dateFormatter setDateFormat:hh_mm_aFormat];
	}	
	
	[subFieldArray removeObjectAtIndex:indexZero];
	[subFieldArray insertObject:[dateFormatter stringFromDate:pickerDate] atIndex:indexZero];
	
	[self.dateTable reloadData];
	
	[dateFormatter release];
    searchButton.enabled = YES;
    
}

#pragma mark - TableView Delegate Method
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
    static NSString *CellIdentifier = @"Cell";
    
	//Create a custom cell to display content on the screen
    RSBaseBookTableCell *cell = (RSBaseBookTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *customCellArray = [[NSBundle mainBundle]loadNibNamed:@"RSBaseBookTableCell" owner:nil options:nil];
        
        
        cell = (RSBaseBookTableCell*)[customCellArray objectAtIndex:indexZero];
    }
    cell.cellText.text = [mainFieldArray objectAtIndex:indexPath.row];
    cell.menuDetailText.text = [subFieldArray objectAtIndex:indexPath.row];
    [cell setBgForSelectedCell:tableView forIndex:indexPath];
    [cell setAccessoryViewImage:NO];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
