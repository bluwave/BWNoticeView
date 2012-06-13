//
//  ViewController.m
//  BWNoticeView
//
//  Created by Garrett Richards on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "BWNoticeView.h"

@interface ViewController ()
@property(nonatomic, retain) BWNoticeView *bwView;
@end

@implementation ViewController
@synthesize bwView;
-(void)dealloc
{
    [bwView release];
    [super dealloc];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect f = self.view.frame;
    f.size.height = 60;

    self.bwView = [[[BWNoticeView alloc] initWithFrame:f] autorelease];
    bwView.showActivityIndicator = NO;
    [bwView setStyle:ERROR];

    [self.view addSubview:bwView];
    [bwView release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [bwView setNeedsDisplay];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

-(IBAction) showNoticeView:(id) sender
{
    [self.bwView setStyle:NOTICE];
    bwView.showActivityIndicator = YES;
    [bwView show];
}

-(IBAction) showNoticeViewError:(id) sender
{
    [self.bwView setStyle:ERROR];
    [bwView showAndDismissAfterDelay:0.8];
}


@end
