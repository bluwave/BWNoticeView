//
//  BWNoticeView.h
//  BWNoticeView
//
//  Created by Garrett Richards on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NoticeViewColorCartridge:NSObject

@property(nonatomic, retain) UIColor *gradientTop;

@property(nonatomic, retain) UIColor *gradientBottom;

@property(nonatomic, retain) UIColor * border1;

@property(nonatomic, retain) UIColor * border2;

@property(nonatomic, retain) UIColor * border3;

@property(nonatomic, retain) UIColor * border4;

@end


typedef enum DefaultCartridgeType {NOTICE, ERROR} DefaultCartridgeType;

@interface BWNoticeView : UIView

@property(nonatomic) BOOL canBeDismissed;

@property(nonatomic, retain) UIImageView *icon;

@property(nonatomic) BOOL showActivityIndicator;

@property(nonatomic, copy) NSString *title;

@property(nonatomic, copy) NSString *message;

//  set the colors of the gradient and the different border colors
//  border 1 is top first border line
//  border 2 is top second border line
//  border 3 is bottom first border line
//  border 4 is bottom second border line
@property(nonatomic, retain) NoticeViewColorCartridge *colorCartridge;

//  2 defaults are provided for use
//      * NOTICE    - this is blue
//      * ERROR     - this is red
-(void) setDefaultCartridgeType:(DefaultCartridgeType) cartridgeType;

-(void) show;

-(void) showAndDismissAfterDelay:(float) delay;

-(void) dismiss;

-(void) dismissAfterDelay:(float) delay;



@end
