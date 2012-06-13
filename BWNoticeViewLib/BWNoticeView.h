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

@property(nonatomic, retain) UILabel *titleLabel;

@property(nonatomic, retain) UIImageView *icon;

@property(nonatomic) BOOL showActivityIndicator;

@property(nonatomic, retain) NoticeViewColorCartridge *colorCartridge;


-(void) setDefaultCartridgeType:(DefaultCartridgeType) cartridgeType;

-(void) show;

-(void) showAndDismissAfterDelay:(float) delay;

-(void) dismiss;

-(void) dismissAfterDelay:(float) delay;



@end
