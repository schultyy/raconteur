//
// Created by Jan Schulte on 26/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCExportOptions.h"


@implementation RCExportOptions

+(RCExportOptions *) defaultOptions {
    RCExportOptions *opts = [[RCExportOptions alloc] init];
    [opts setTextColor: [NSColor blackColor]];
    [opts setBackgroundColor: [NSColor whiteColor]];
    [opts setFontFamily:@"Arial"];
    return opts;
}

@end