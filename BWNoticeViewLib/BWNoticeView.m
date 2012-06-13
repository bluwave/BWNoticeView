//
//  BWNoticeView.m
//  BWNoticeView
//
//  Created by Garrett Richards on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//  Pieces of this code have been taken from  https://github.com/tciuro/NoticeView
//
//

#import "BWNoticeView.h"
#import "GradientView.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

@interface BWNoticeView()
@property(nonatomic, retain) UIView *gradientView;
@property(nonatomic, retain) UIButton *btnClickToDismiss;
@end

@implementation BWNoticeView
@synthesize backgroundGradientBottom, backgroundGradientTop, gradientView, btnClickToDismiss, canBeDismissed;


static UIColor * defaultBackgroundGradientTop;
static UIColor * defaultBackgroundGradientBottom;

static UIColor * firstTopLine;
static UIColor * secondTopLine;
static UIColor * firstBottomLine;
static UIColor * secondBottomLine;

-(void)dealloc
{
    [btnClickToDismiss release];
    [gradientView release];
    [backgroundGradientBottom release];
    [backgroundGradientTop release];
    [super dealloc];
}

+(void)initialize
{
    defaultBackgroundGradientTop = [[UIColor colorWithRed:37 / 255.0f green:122 / 255.0f blue:185 / 255.0f alpha:1.0] retain];
    defaultBackgroundGradientBottom = [[UIColor colorWithRed:18 / 255.0f green:96 / 255.0f blue:154 / 255.0f alpha:1.0] retain];

    firstTopLine = [[UIColor colorWithRed:105 / 255.0f green:163 / 255.0f blue:208 / 255.0f alpha:1.0] retain];
    secondTopLine = [[UIColor colorWithRed:46 / 255.0f green:126 / 255.0f blue:188 / 255.0f alpha:1.0] retain];
    firstBottomLine = [[UIColor colorWithRed:18 / 255.0f green:92 / 255.0f blue:149 / 255.0f alpha:1.0] retain];
    secondBottomLine = [[UIColor colorWithRed:4 / 255.0f green:45 / 255.0f blue:75 / 255.0f alpha:1.0] retain];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self __init];
    }
    return self;
}

-(void) __init
{
    self.backgroundGradientTop = defaultBackgroundGradientTop;
    self.backgroundGradientBottom = defaultBackgroundGradientBottom;

    self.btnClickToDismiss = [UIButton buttonWithType:UIButtonTypeCustom];
    btnClickToDismiss.frame = self.frame;
    [btnClickToDismiss addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnClickToDismiss];

    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.gradientView = [[[GradientView alloc] initWithWithFrame:self.frame topGradientColor:backgroundGradientTop bottomGradientColor:backgroundGradientBottom] autorelease];
    gradientView.userInteractionEnabled = NO;
    [self addSubview:gradientView];


}

-(void)setNeedsDisplay
{
    [super setNeedsDisplay];
    [gradientView setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{

    [super drawRect:rect];

    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.bounds.size.width, 1.0)];
    v.backgroundColor = firstTopLine;
    [self addSubview:v];
    [v release];

    v = [[UIView alloc] initWithFrame:CGRectMake(0.0, 1.0, self.bounds.size.width, 1.0)];
    v.backgroundColor = secondTopLine;
    [self addSubview:v];
    [v release];

    v = [[UIView alloc] initWithFrame:CGRectMake(0.0, self.bounds.size.height - 1, self.frame.size.width, 1.0)];
    v.backgroundColor = firstBottomLine;
    [self addSubview:v];
    [v release];


    v = [[UIView alloc] initWithFrame:CGRectMake(0.0, self.bounds.size.height - 1, self.frame.size.width, 1.0)];
    v.backgroundColor = secondBottomLine;
    [self addSubview:v];
    [v release];


}

-(void) dismiss:(id) sender
{
    if (canBeDismissed)
    {
        CGRect frame = self.frame;
        frame.origin.y -= self.frame.size.height + self.frame.origin.y + 5;
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationCurveEaseOut animations:^(){
            self.frame = frame;
        } completion:^(BOOL complete) {

        }];
    }
}

@end
