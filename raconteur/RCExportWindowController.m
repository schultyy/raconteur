//
// Created by Jan Schulte on 25/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCExportWindowController.h"


@implementation RCExportWindowController

-(id) init {
    self = [super initWithWindowNibName:@"RCExportWindow"];
    return self;
}

-(IBAction)discard:(id)sender {
    [[self window] orderOut:self];
    [NSApp endSheet:self.window returnCode:-1];
}

-(IBAction)export:(id)sender {
    [[self window] orderOut:self];
    [NSApp endSheet:self.window returnCode:1];
}

@end
