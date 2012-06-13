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



@implementation NoticeViewColorCartridge

@synthesize gradientBottom , gradientTop, border1, border2, border3, border4;

-(void)dealloc
{
    [gradientBottom release];
    [gradientTop release];
    [border1 release];
    [border2 release];
    [border3 release];
    [border4 release];
    [super dealloc];
}

@end

@interface UIColor (BWNoticeViewColors)
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

+(UIColor*) ErrorRedMessageTextColor
{
    return [UIColor colorWithRed:239.0/255.0 green:167.0/255.0 blue:163.0/255.0 alpha:1.0];
}


@end


@interface BWNoticeView()
@property(nonatomic, retain) UIButton *btnClickToDismiss;

@property(nonatomic, retain) UIActivityIndicatorView *activityIndicatorView;

@property(nonatomic, retain) CAGradientLayer *gradientLayer;

@property(nonatomic, retain) NoticeViewColorCartridge *noticeBlueCartridge;

@property(nonatomic, retain) NoticeViewColorCartridge *errorRedCartridge;

@end

@implementation BWNoticeView
@synthesize colorCartridge, btnClickToDismiss, canBeDismissed, titleLabel, icon , showActivityIndicator;
@synthesize activityIndicatorView,  gradientLayer;
@synthesize noticeBlueCartridge, errorRedCartridge;

-(void)dealloc
{
    [gradientLayer release];
    [activityIndicatorView release];
    [icon release];
    [titleLabel release];
    [btnClickToDismiss release];
    [colorCartridge release];
    [noticeBlueCartridge release];
    [errorRedCartridge release];
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

    [self __initDefaultCartridges];
    self.colorCartridge = noticeBlueCartridge;

    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.canBeDismissed = YES;


    // add button to help dismiss view when clicked
    self.btnClickToDismiss = [UIButton buttonWithType:UIButtonTypeCustom];
    btnClickToDismiss.frame = self.frame;
    [btnClickToDismiss addTarget:self action:@selector(dismissClicked:) forControlEvents:UIControlEventTouchUpInside];
    btnClickToDismiss.autoresizingMask = UIViewAutoresizingFlexibleWidth;
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


    // add gradient
    self.gradientLayer = [CAGradientLayer layer];
    [self.layer insertSublayer:gradientLayer atIndex:0];
    
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

    gradientLayer.frame = rect;
    gradientLayer.colors = [NSArray arrayWithObjects:(id) colorCartridge.gradientTop.CGColor, (id) colorCartridge.gradientTop.CGColor, nil];
    gradientLayer.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0f], [NSNumber numberWithFloat:0.7], nil];


    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.bounds.size.width, 1.0)];
    v.backgroundColor = colorCartridge.border1;
    [self addSubview:v];
    [v release];

    v = [[UIView alloc] initWithFrame:CGRectMake(0.0, 1.0, self.bounds.size.width, 1.0)];
    v.backgroundColor = colorCartridge.border2;
    [self addSubview:v];
    [v release];

    v = [[UIView alloc] initWithFrame:CGRectMake(0.0, self.bounds.size.height - 1, self.frame.size.width, 1.0)];
    v.backgroundColor = colorCartridge.border3;
    [self addSubview:v];
    [v release];


    v = [[UIView alloc] initWithFrame:CGRectMake(0.0, self.bounds.size.height - 1, self.frame.size.width, 1.0)];
    v.backgroundColor = colorCartridge.border4;
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
    frame.origin.y = 0;
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


-(void) setDefaultCartridgeType:(DefaultCartridgeType) cartridgeType
{

    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"BWNoticeView.bundle"];
    NSString *iconPath = nil;

    switch (cartridgeType)
    {
        case NOTICE:
            iconPath = [path stringByAppendingPathComponent:@"success.png"];
            self.icon.image = [UIImage imageWithContentsOfFile:iconPath];

            self.colorCartridge = noticeBlueCartridge;
            break;
        case ERROR:
            // set icon
            iconPath = [path stringByAppendingPathComponent:@"error.png"];
            self.icon.image = [UIImage imageWithContentsOfFile:iconPath];

            self.colorCartridge = errorRedCartridge;
            break;
    }
}


-(void)setColorCartridge:(NoticeViewColorCartridge *)aColorCartridge
{
    if (colorCartridge != aColorCartridge)
    {
        [colorCartridge release];
        colorCartridge = [aColorCartridge retain];
        [self setNeedsDisplay];
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




-(void) __initDefaultCartridges
{
    self.errorRedCartridge = [[[NoticeViewColorCartridge alloc] init] autorelease];
    errorRedCartridge.gradientTop = [UIColor ErrorRedGradientTop];
    errorRedCartridge.gradientBottom = [UIColor ErrorRedGradientBottom];
    errorRedCartridge.border1 = [UIColor ErrorRedBorder1];
    errorRedCartridge.border2 = [UIColor ErrorRedBorder2];
    errorRedCartridge.border3 = [UIColor ErrorRedBorder3];
    errorRedCartridge.border4 = [UIColor ErrorRedBorder4];

    self.noticeBlueCartridge = [[[NoticeViewColorCartridge alloc] init] autorelease];
    noticeBlueCartridge.gradientTop = [UIColor NoticeBlueGradientTop];
    noticeBlueCartridge.gradientBottom = [UIColor NoticeBlueGradientBottom];
    noticeBlueCartridge.border1 = [UIColor NoticeBlueBorder1];
    noticeBlueCartridge.border2 = [UIColor NoticeBlueBorder2];
    noticeBlueCartridge.border3 = [UIColor NoticeBlueBorder3];
    noticeBlueCartridge.border4 = [UIColor NoticeBlueBorder4];

}

@end
