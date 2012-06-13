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
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>



@interface UIColor (BWNoticeViewColors)

+(UIColor*) NoticeBlueGradientTop;

+(UIColor*) NoticeBlueGradientBottom;

@end

@implementation UIColor (BWNoticeViewColors)

+(UIColor*) NoticeBlueGradientTop
{
    return [UIColor colorWithRed:37 / 255.0f green:122 / 255.0f blue:185 / 255.0f alpha:1.0];
}

+(UIColor*) NoticeBlueGradientBottom
{
    return [UIColor colorWithRed:18 / 255.0f green:96 / 255.0f blue:154 / 255.0f alpha:1.0];
}

+(UIColor*) NoticeBlueBorder1
{
    return [UIColor colorWithRed:105 / 255.0f green:163 / 255.0f blue:208 / 255.0f alpha:1.0];
}

+(UIColor*) NoticeBlueBorder2
{
    return [UIColor colorWithRed:46 / 255.0f green:126 / 255.0f blue:188 / 255.0f alpha:1.0];
}

+(UIColor*) NoticeBlueBorder3
{
    return [UIColor colorWithRed:18 / 255.0f green:92 / 255.0f blue:149 / 255.0f alpha:1.0];
}

+(UIColor*) NoticeBlueBorder4
{
    return [UIColor colorWithRed:4 / 255.0f green:45 / 255.0f blue:75 / 255.0f alpha:1.0];
}


+(UIColor*) ErrorRedGradientTop
{
    return [UIColor colorWithRed:167/255.0f green:26/255.0f blue:20/255.0f alpha:1.0];
}

+(UIColor*) ErrorRedGradientBottom
{
    return [UIColor colorWithRed:134/255.0f green:9/255.0f blue:7/255.0f alpha:1.0];
}


+(UIColor*) ErrorRedBorder1
{
    return [UIColor colorWithRed:211/255.0f green:82/255.0f blue:80/255.0f alpha:1.0];
}

+(UIColor*) ErrorRedBorder2
{
    return [UIColor colorWithRed:193/255.0f green:30/255.0f blue:23/255.0f alpha:1.0];
}

+(UIColor*) ErrorRedBorder3
{
    return [UIColor colorWithRed:134/255.0f green:9/255.0f blue:7/255.0f alpha:1.0];
}

+(UIColor*) ErrorRedBorder4
{
    return [UIColor colorWithRed:52/255.0f green:4/255.0f blue:3/255.0f alpha:1.0];
}


@end


@interface BWNoticeView()
@property(nonatomic, retain) UIButton *btnClickToDismiss;

@property(nonatomic, retain) UIActivityIndicatorView *activityIndicatorView;

@property(nonatomic, retain) UIColor *border1;

@property(nonatomic, retain) UIColor *border2;

@property(nonatomic, retain) UIColor *border3;

@property(nonatomic, retain) UIColor *border4;

@end

@implementation BWNoticeView
@synthesize backgroundGradientBottom, backgroundGradientTop, btnClickToDismiss, canBeDismissed, titleLabel, icon , showActivityIndicator;
@synthesize activityIndicatorView, style;
@synthesize border1, border2, border3, border4;

-(void)dealloc
{
    [activityIndicatorView release];
    [icon release];
    [titleLabel release];
    [btnClickToDismiss release];
    [backgroundGradientBottom release];
    [backgroundGradientTop release];
    [super dealloc];
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
    [self setStyle:NOTICE];

    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.canBeDismissed = YES;
    self.style = NOTICE;

    // add button to help dismiss view when clicked
    self.btnClickToDismiss = [UIButton buttonWithType:UIButtonTypeCustom];
    btnClickToDismiss.frame = self.frame;
    [btnClickToDismiss addTarget:self action:@selector(dismissClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnClickToDismiss];


    float titleYOrigin = 18.0;

    // titleLabel
    self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(55.0, titleYOrigin, self.frame.size.width - 70.0, 16.0)] autorelease];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.shadowOffset = CGSizeMake(0.0, -1.0);
    self.titleLabel.shadowColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.text = @"hello world";
    [self addSubview:titleLabel];


    //default icon image
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"BWNoticeView.bundle"];
    NSString *iconPath = [path stringByAppendingPathComponent:@"success.png"];
    self.icon = [[[UIImageView alloc] initWithFrame:CGRectMake(10.0, 10.0, 20.0, 30.0)] autorelease];
    icon.image = [UIImage imageWithContentsOfFile:iconPath];
    icon.contentMode = UIViewContentModeScaleAspectFit;
    icon.alpha = 0.8;
    [self addSubview:icon];

    // activity indicator
    self.activityIndicatorView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite] autorelease];
    self.activityIndicatorView.frame = CGRectMake(10, 10, 30, 30);
    [self.activityIndicatorView startAnimating];
    self.activityIndicatorView.hidden = YES;
    [self addSubview:activityIndicatorView];


    // add shadow
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOffset = CGSizeMake(0.0, 3);
    self.layer.shadowOpacity = 0.50;
    self.layer.masksToBounds = NO;
    self.layer.shouldRasterize = YES;


}

- (void)drawRect:(CGRect)rect
{

    [super drawRect:rect];

    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = rect;
    gradient.colors = [NSArray arrayWithObjects:(id) backgroundGradientTop.CGColor, (id) backgroundGradientBottom.CGColor, nil];
    gradient.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0f], [NSNumber numberWithFloat:0.7], nil];

    [self.layer insertSublayer:gradient atIndex:0];


    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.bounds.size.width, 1.0)];
    v.backgroundColor = border1;
    [self addSubview:v];
    [v release];

    v = [[UIView alloc] initWithFrame:CGRectMake(0.0, 1.0, self.bounds.size.width, 1.0)];
    v.backgroundColor = border2;
    [self addSubview:v];
    [v release];

    v = [[UIView alloc] initWithFrame:CGRectMake(0.0, self.bounds.size.height - 1, self.frame.size.width, 1.0)];
    v.backgroundColor = border3;
    [self addSubview:v];
    [v release];


    v = [[UIView alloc] initWithFrame:CGRectMake(0.0, self.bounds.size.height - 1, self.frame.size.width, 1.0)];
    v.backgroundColor = border4;
    [self addSubview:v];
    [v release];


}



-(void) show
{
    [self showAndDismissAfterDelay:-1];
}
-(void) showAndDismissAfterDelay:(float) delay
{
    CGRect frame = self.frame;
    frame.origin.y = self.frame.size.height;
    // show
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationCurveEaseOut animations:^() {
        self.frame = frame;
    } completion:^(BOOL complete){

        // hide after delay
        if (delay > -1)
        {
            [self dismissAfterDelay:delay];
        }

    }];
}

-(void) dismiss
{
    [self dismissAfterDelay:0];
}

-(void) dismissAfterDelay:(float) delay
{
    CGRect frame = self.frame;

    frame.origin.y -= self.frame.size.height + self.frame.origin.y + 5;

    [UIView animateWithDuration:0.5 delay:delay options:UIViewAnimationCurveEaseOut animations:^() {

        self.frame = frame;

    } completion:^(BOOL completed) {}];
}

-(void) dismissClicked:(id) sender
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




-(void)setBackgroundGradientBottom:(UIColor *)aBackgroundGradientBottom
{
    if (aBackgroundGradientBottom != backgroundGradientBottom)
    {
        [backgroundGradientBottom release];
        backgroundGradientBottom = [aBackgroundGradientBottom retain];
    }

    [self setNeedsDisplay];
}

-(void)setBackgroundGradientTop:(UIColor *)aBackgroundGradientTop
{
    if (aBackgroundGradientTop != backgroundGradientTop)
    {
        [backgroundGradientTop release];
        backgroundGradientTop = [aBackgroundGradientTop retain];
    }

    [self setNeedsDisplay];
}

-(void)setStyle:(Style)aStyle
{
    style = aStyle;

    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"BWNoticeView.bundle"];
    NSString *iconPath = nil;


    switch(aStyle)
    {
        case NOTICE:
            // set gradient colors
            self.backgroundGradientTop = [UIColor NoticeBlueGradientTop] ;
            self.backgroundGradientBottom = [UIColor NoticeBlueGradientBottom];

            // set borders
            self.border1 = [UIColor NoticeBlueBorder1];
            self.border2 = [UIColor NoticeBlueBorder2];
            self.border3 = [UIColor NoticeBlueBorder3];
            self.border4 = [UIColor NoticeBlueBorder4];

            // set icon
            iconPath = [path stringByAppendingPathComponent:@"success.png"];
            self.icon.image = [UIImage imageWithContentsOfFile:iconPath];

            break;
        case ERROR:
            // set gradient colors
            self.backgroundGradientTop = [UIColor ErrorRedGradientTop];
            self.backgroundGradientBottom = [UIColor ErrorRedGradientBottom];

            // set borders
            self.border1 = [UIColor ErrorRedBorder1];
            self.border2 = [UIColor ErrorRedBorder2];
            self.border3 = [UIColor ErrorRedBorder3];
            self.border4 = [UIColor ErrorRedBorder4];

            // set icon
            iconPath = [path stringByAppendingPathComponent:@"error.png"];
            self.icon.image = [UIImage imageWithContentsOfFile:iconPath];

            break;
    }
}

-(void)setShowActivityIndicator:(BOOL)aShowActivityIndicator
{
    showActivityIndicator = aShowActivityIndicator;
    if (aShowActivityIndicator)
    {
        self.icon.hidden = YES;
        self.activityIndicatorView.hidden = NO;
        [activityIndicatorView startAnimating];
    }
    else
    {
        [activityIndicatorView stopAnimating];
        activityIndicatorView.hidden = YES;
        icon.hidden = NO;
    }
}


@end
