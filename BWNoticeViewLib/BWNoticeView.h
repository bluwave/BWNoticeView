//
//  BWNoticeView.h
//  BWNoticeView
//
//  Created by Garrett Richards on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BWNoticeView : UIView

@property(nonatomic, retain) UIColor *backgroundGradientTop;

@property(nonatomic, retain) UIColor *backgroundGradientBottom;

@property(nonatomic) BOOL canBeDismissed;

@property(nonatomic, retain) UILabel *titleLabel;

@property(nonatomic, retain) UIImageView *icon;

-(void) show;

-(void) showAndDismissAfterDelay:(float) delay;

-(void) dismiss;

-(void) dismissAfterDelay:(float) delay;

@end
