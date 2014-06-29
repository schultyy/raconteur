//
// Created by Jan Schulte on 26/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCSlideOptions.h"
#import "RCConstants.h"
#import "NSColor+RCHexValue.h"


@implementation RCSlideOptions

+(RCSlideOptions *) defaultOptions {
    RCSlideOptions *opts = [[RCSlideOptions alloc] init];
    [opts setTextColor: [NSColor blackColor]];
    [opts setBackgroundColor: [NSColor whiteColor]];
    [opts setFontFamily:@"Arial"];
    return opts;
}

+(RCSlideOptions *) fromFrontmatter: (NSDictionary *) frontmatter {
    RCSlideOptions *opts = [[RCSlideOptions alloc] init];

    NSColor *backgroundColor = [NSColor colorWithHexColorString: [frontmatter valueForKey: RCBackgroundColor]];
    NSColor *textColor = [NSColor colorWithHexColorString:[frontmatter valueForKey: RCTextColor]];

    [opts setBackgroundColor: backgroundColor];
    [opts setTextColor: textColor];
    [opts setFontFamily:[frontmatter valueForKey: RCFontFamily]];
    [opts setTextAlignment: [frontmatter valueForKey:RCTextAlignment]];
    return opts;
}

@end
