//
//  RCAppDelegate.m
//  raconteur
//
//  Created by Jan Schulte on 23/06/14.
//  Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCAppDelegate.h"
#import "RCMainController.h"
#import "RCProjectSerializer.h"

@implementation RCAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
}

#pragma mark - Actions

-(IBAction)newProject:(id)sender {
    [self setMainController:[[RCMainController alloc] init]];
    [[self mainController] showWindow:self];
}

-(IBAction) openProject: (id) sender {
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];
    [openDlg setCanChooseFiles:NO];
    [openDlg setCanChooseDirectories:YES];
    [openDlg setCanCreateDirectories:YES];
    [openDlg setPrompt:@"Select"];

    if([openDlg runModal] == NSOKButton) {
        RCProject *project = [RCProjectSerializer loadFromDirectory:openDlg.URL.path];
        [self setMainController:[[RCMainController alloc] initWithProject: project]];
        [[self mainController] showWindow:self];
    }
}

-(IBAction) addSlide:(id)sender {
    [[self mainController] addSlide];
}

-(IBAction) removeSelectedSlide: (id) sender {
    [[self mainController] removeSelectedSlide];
}

-(IBAction) saveProject:(id)sender {
    [[self mainController] saveProject];
}

-(IBAction) saveProjectAs: (id) sender {
    [[self mainController] saveProjectAs];
}

-(IBAction)exportSlides:(id)sender {
    [[self mainController] exportSlides];
}

-(IBAction)startPresentation:(id)sender {
    [[self mainController] startPresentation];
}
@end
