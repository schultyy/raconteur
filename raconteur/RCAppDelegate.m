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
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseDirectories:YES];
    [panel setCanChooseFiles:NO];
    [panel setCanCreateDirectories:YES];

    if([panel runModal] == NSOKButton) {
        NSString *cwd = [[panel directoryURL] path];
        [self setMainController:[[RCMainController alloc] initWithWorkingDirectory: cwd]];
        [[self mainController] showWindow:self];
    }
}

-(IBAction)addFile:(id)sender {
    [[self mainController] addFile];
}

@end
