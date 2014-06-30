//
// Created by Jan Schulte on 26/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCSlideOptions.h"
#import "RCConstants.h"
#import "NSColor+RCHexValue.h"


@implementation RCSlideOptions

-(id) initWithCoder: (NSCoder *) coder {
    self = [super init];
    if(self) {
        [self setTextAlignment:   [coder decodeObjectForKey:NSStringFromSelector(@selector(textAlignment))]];
        [self setFontFamily:      [coder decodeObjectForKey:NSStringFromSelector(@selector(fontFamily))]];
        [self setBackgroundColor: [coder decodeObjectForKey:NSStringFromSelector(@selector(backgroundColor))]];
        [self setForegroundColor:       [coder decodeObjectForKey:NSStringFromSelector(@selector(foregroundColor))]];
    }
    return self;
}

+(RCSlideOptions *) defaultOptions {
    RCSlideOptions *opts = [[RCSlideOptions alloc] init];
    [opts setForegroundColor: [NSColor blackColor]];
    [opts setBackgroundColor: [NSColor whiteColor]];
    [opts setTextAlignment:RCAlignmentLeftValue];
    [opts setFontFamily:@"Arial"];
    return opts;
}

+(RCSlideOptions *) fromFrontmatter: (NSDictionary *) frontmatter {
    RCSlideOptions *opts = [[RCSlideOptions alloc] init];

    NSColor *backgroundColor = [NSColor colorWithHexColorString: [frontmatter valueForKey: RCBackgroundColor]];
    NSColor *textColor = [NSColor colorWithHexColorString:[frontmatter valueForKey: RCTextColor]];

    [opts setBackgroundColor: backgroundColor];
    [opts setForegroundColor: textColor];
    [opts setFontFamily:[frontmatter valueForKey: RCFontFamily]];
    [opts setTextAlignment: [frontmatter valueForKey:RCTextAlignment]];
    return opts;
}

#pragma mark - NSCoder

-(void) encodeWithCoder: (NSCoder *) coder {
    [coder encodeObject:self.foregroundColor forKey:NSStringFromSelector(@selector(foregroundColor))];
    [coder encodeObject: self.textAlignment forKey:NSStringFromSelector(@selector(textAlignment))];
    [coder encodeObject: self.backgroundColor forKey:NSStringFromSelector(@selector(backgroundColor))];
    [coder encodeObject:self.foregroundColor forKey:NSStringFromSelector(@selector(foregroundColor))];
}

@end
