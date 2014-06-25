//
//  RCAppDelegate.m
//  raconteur
//
//  Created by Jan Schulte on 23/06/14.
//  Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCAppDelegate.h"
#import "RCMainController.h"

@implementation RCAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
}

#pragma mark - Actions

-(IBAction)newProject:(id)sender {
    [self setMainController:[[RCMainController alloc] init]];
    [[self mainController] showWindow:self];
}

-(IBAction)addSlide:(id)sender {
    [[self mainController] addSlide];
}

@end
