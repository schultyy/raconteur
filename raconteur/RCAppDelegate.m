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
#import "RCPresentationWindowController.h"

@implementation RCAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
}

#pragma mark - Actions

-(IBAction)newProject:(id)sender {
    if(self.mainController) {
        [[self mainController] removeObservers];
        [self setMainController:nil];
    }
    [self setMainController:[[RCMainController alloc] init]];
    [[self mainController] showWindow:self];
}

-(IBAction) openProject: (id) sender {
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];
    [openDlg setCanChooseFiles:YES];
    [openDlg setCanChooseDirectories:NO];
    [openDlg setCanCreateDirectories:NO];
    [openDlg setAllowedFileTypes:[NSArray arrayWithObject:@"json"]];
    [openDlg setPrompt:@"Select"];

    if([openDlg runModal] == NSOKButton) {
        RCProject *project = [RCProjectSerializer load:openDlg.URL.path];
        if(self.mainController) {
            [[self mainController] removeObservers];
            [self setMainController:nil];
        }
        [self setMainController:[[RCMainController alloc] initWithProject: project]];
        [[self mainController] showWindow:self];
    }
}

-(IBAction) addSlide:(id)sender {
    [[self mainController] addSlide];
}

-(IBAction) addExistingSlide: (id) sender {
    [[self mainController] addExistingSlide];
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

-(IBAction)nextSlide:(id)sender {
    [[[self mainController] presentationController] nextSlide];
}

-(IBAction)previousSlide:(id)sender {
    [[[self mainController] presentationController] previousSlide];
}

-(IBAction) editMasterSlide: (id) sender {
    [[self mainController] editMasterSlide];
}
@end
