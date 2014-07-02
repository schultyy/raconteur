//
// Created by Jan Schulte on 02/07/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCMasterSlideWindowController.h"
#import "RCSlideOptions.h"


@implementation RCMasterSlideWindowController

-(id) init {
    self = [super initWithWindowNibName:@"RCMasterSlideWindow"];
    if(self) {
        [self setDefaultOptions: [[RCSlideOptions defaultOptions] copy]];
    }
    return self;
}

-(IBAction) discard: (id) sender {
    [[self window] orderOut:self];
    [NSApp endSheet:self.window returnCode:-1];
}

-(IBAction) save: (id) sender {
    [[self window] orderOut:self];
    [NSApp endSheet:self.window returnCode:+1];
}

@end
