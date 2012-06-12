//
// Created by slim on 6/12/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface GradientView : UIView
@property(nonatomic, retain) UIColor *topColor;
@property(nonatomic, retain) UIColor *bottomColor;

-(id) initWithWithFrame:(CGRect) frame topGradientColor:(UIColor *) top_ bottomGradientColor:(UIColor *) bottom_;
@end