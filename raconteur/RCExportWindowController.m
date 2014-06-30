//
// Created by Jan Schulte on 25/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCExportWindowController.h"
#import "RCSlideOptions.h"

@interface RCExportWindowController()
@property (readwrite, nonatomic, strong) RCSlideOptions *exportOptions;
@end

@implementation RCExportWindowController

-(id) init {
    self = [super initWithWindowNibName:@"RCExportWindow"];
    [self setExportOptions:[[RCSlideOptions alloc] init]];
    [[self exportOptions] setForegroundColor: [NSColor blackColor]];
    [[self exportOptions] setBackgroundColor: [NSColor whiteColor]];
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
