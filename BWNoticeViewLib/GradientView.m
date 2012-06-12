//
// Created by slim on 6/12/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <QuartzCore/QuartzCore.h>
#import "GradientView.h"


@implementation GradientView

static UIColor * defaultBackgroundGradientTop;
static UIColor * defaultBackgroundGradientBottom;

@synthesize topColor, bottomColor;

-(void)dealloc
{
    [topColor release];
    [bottomColor release];
    [super dealloc];
}


-(id) initWithWithFrame:(CGRect) frame topGradientColor:(UIColor *) top_ bottomGradientColor:(UIColor *) bottom_
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self sizeToFit];
        self.topColor = top_;
        self.bottomColor = bottom_;
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.topColor = defaultBackgroundGradientTop;
        self.bottomColor = defaultBackgroundGradientBottom;
    }
    return self;
}


+(void)initialize
{
    defaultBackgroundGradientTop = [[UIColor colorWithRed:37 / 255.0f green:122 / 255.0f blue:185 / 255.0f alpha:1.0] retain];
    defaultBackgroundGradientBottom = [[UIColor colorWithRed:18 / 255.0f green:96 / 255.0f blue:154 / 255.0f alpha:1.0] retain];
}

- (void)drawRect:(CGRect)rect
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id) topColor.CGColor, (id) bottomColor.CGColor, nil];
    gradient.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0f], [NSNumber numberWithFloat:0.7], nil];

    [self.layer insertSublayer:gradient atIndex:0];
}
@end