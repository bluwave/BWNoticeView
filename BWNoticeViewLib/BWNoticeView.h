//
//  BWNoticeView.h
//  BWNoticeView
//
//  Created by Garrett Richards on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum Style {NOTICE, ERROR} visualStyle;

@interface BWNoticeView : UIView

@property(nonatomic, copy) UIColor *backgroundGradientTop;

@property(nonatomic, copy) UIColor *backgroundGradientBottom;

@property(nonatomic) BOOL canBeDismissed;

@property(nonatomic, retain) UILabel *titleLabel;

@property(nonatomic, retain) UIImageView *icon;

@property(nonatomic) BOOL showActivityIndicator;

@property(nonatomic) Style style;

-(void) show;

-(void) showAndDismissAfterDelay:(float) delay;

-(void) dismiss;

-(void) dismissAfterDelay:(float) delay;



@end
