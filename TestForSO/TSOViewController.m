//
//  TSOViewController.m
//  TestForSO
//
//  Created by Brian Cooley on 3/2/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import "TSOViewController.h"

@interface TSOViewController()
{
    float tdv;
}
@end
@implementation TSOViewController
@synthesize label;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

-(void)updateMeters
{   int i = 0;
    if ([NSThread isMainThread]) { //this evaluates to FALSE, as it's supposed to
        NSLog(@"Running on main, that's wrong!");
    }
    while (i < 10) {
        [self performSelectorOnMainThread:@selector(updateUI) withObject:nil waitUntilDone:NO];
        //The code below yields the same result
        //        dispatch_async(dispatch_get_main_queue(), ^{
        //            [self updateUI];
        //        });
        [NSThread sleepForTimeInterval: 1.05];
        ++i;
        tdv = tdv + 1.0;
    }
}

- (void) updateUI
{
    if ([NSThread isMainThread]) { //Evaluates to TRUE; it's indeed on the main thread!
        NSLog(@"main thread!");
    } else {
        NSLog(@"not main thread!");
    }
    
    self.label.text = [NSString stringWithFormat:@"%f", tdv];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    tdv = 0;
	[self performSelectorInBackground:@selector(updateMeters) withObject:self];
}

- (void)viewDidUnload
{
    [self setLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
