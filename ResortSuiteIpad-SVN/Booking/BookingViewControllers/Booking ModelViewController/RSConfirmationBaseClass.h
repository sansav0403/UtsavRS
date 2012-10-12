//
//  RSConfirmationBaseClass.h
//  ResortSuite
//
//  Created by Cybage on 9/20/11.
//  Copyright 2011 Resort Suite. All rights reserved.
//
/*
 ===========================================================================
 DESCRIPTION:
 base class to implement the comman function in the confirmation view.
 * Create the dynamic description taking only the space it rewuires on the screen.
 * All the label adjust them self according the label text length.
 
 
 ================================================================================
 */
#import <UIKit/UIKit.h>

enum {
    DefaultValue = 0,
    instructionForSpa= 1,
    instructionForClass = 2
    };

enum titleIndexPostion {
    IndexForFirstTitle = 0,
    instructionIndexForSpa = 4,
    instructionIndexForClass = 6
    };

@interface RSConfirmationBaseClass : BaseViewController{
    //need a val to determine if this is being used for class or for spa service.
    int             valForClassOrService;       
    float           label2Y_cord ;                
    
    UIScrollView    *scrollView;          
    UIButton        *bookButton;
}


/*!
 @method		createDescriptionBody
 @brief			screate Description Body of the confirmation view
 @details		
 @param			(NSArray*)tagsTitle, (NSArray*)tagsValue
 @return		void
 */ 
-(void) createDescriptionBody:(NSArray*)tagsTitle dataArray:(NSArray*)tagsValue;
/*!
 @method		stringFromDate
 @brief			string From Date object
 @details		
 @param			(NSDate *)date
 @return		NSString
 */ 
-(NSString *)stringFromDate:(NSDate *)date;
/*!
 @method		timeStringFromDate
 @brief			get time string from date
 @details		
 @param			(NSDate *)date
 @return		NSString
 */ 
-(NSString *)timeStringFromDate:(NSDate *)date; 
/*!
 @method		createTitleHeader
 @brief			create Title Header at y position
 @details		
 @param			(NSString*)headerTitle, (float)yCoordinate
 @return		void
 */ 
-(void) createTitleHeader:(NSString*)headerTitle yPosition:(float)yCoordinate;
/*!
 @method		createMessage
 @brief			create message string at y position
 @details		
 @param			(NSString *)messageString, (float)yCoordinate
 @return		void
 */ 
-(void) createMessage:(NSString *)messageString yPostion:(float)yCoordinate;
/*!
 @method		drawSeperatorImageAtYCord
 @brief			draw Seperator Image At YCord
 @details		
 @param			(float)ycord
 @return		void
 */ 
-(void)drawSeperatorImageAtYCord:(float)ycord ;
/*!
 @method		calculateNoOfLinesForLineWidth
 @brief			calculate No Of Lines needed For Line Width
 @details		
 @param			(CGFloat)lineWidth,(float)labelWidth
 @return		int
 */ 
-(int)calculateNoOfLinesForLineWidth:(CGFloat)lineWidth forLabelWidth:(float)labelWidth;

@end
