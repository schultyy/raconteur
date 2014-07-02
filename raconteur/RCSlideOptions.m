//
// Created by Jan Schulte on 26/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "RCSlideOptions.h"
#import "RCConstants.h"
#import "NSColor+RCHexValue.h"


@implementation RCSlideOptions

static RCSlideOptions *defaultOptions;

-(id) initWithCoder: (NSCoder *) coder {
    self = [super init];
    if(self) {
        [self setHorizontalTextAlignment: [coder decodeObjectForKey:NSStringFromSelector(@selector(horizontalTextAlignment))]];
        [self setVerticalTextAlignment:   [coder decodeObjectForKey:NSStringFromSelector(@selector(verticalTextAlignment))]];
        [self setFontFamily:              [coder decodeObjectForKey:NSStringFromSelector(@selector(fontFamily))]];
        [self setBackgroundColor:         [coder decodeObjectForKey:NSStringFromSelector(@selector(backgroundColor))]];
        [self setForegroundColor:         [coder decodeObjectForKey:NSStringFromSelector(@selector(foregroundColor))]];
    }
    return self;
}

+(RCSlideOptions *) defaultOptions {
    if(!defaultOptions) {
        RCSlideOptions *opts = [[RCSlideOptions alloc] init];
        [opts setForegroundColor:[NSColor blackColor]];
        [opts setBackgroundColor:[NSColor whiteColor]];
        [opts setHorizontalTextAlignment:RCHorizontalTextAlignmentLeftValue];
        [opts setVerticalTextAlignment:RCVerticalTextAlignmentTopValue];
        [opts setFontFamily:@"Arial"];
        defaultOptions = opts;
    }
    return defaultOptions;
}

+(void) setDefaultOptions: (RCSlideOptions *) newOptions {
    defaultOptions = newOptions;
}

+(RCSlideOptions *) fromFrontmatter: (NSDictionary *) frontmatter {
    RCSlideOptions *opts = [[RCSlideOptions alloc] init];

    NSColor *backgroundColor = [NSColor colorWithHexColorString: [frontmatter valueForKey: RCBackgroundColor]];
    NSColor *textColor = [NSColor colorWithHexColorString:[frontmatter valueForKey: RCTextColor]];

    [opts setBackgroundColor: backgroundColor];
    [opts setForegroundColor: textColor];
    [opts setFontFamily:[frontmatter valueForKey: RCFontFamily]];
    [opts setHorizontalTextAlignment:[frontmatter valueForKey:RCHorizontalTextAlignment]];
    [opts setVerticalTextAlignment: [frontmatter valueForKey:RCVerticalTextAlignment]];
    return opts;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    id copy = [[[self class] alloc] init];
    if(copy) {
        [copy setBackgroundColor:[self.backgroundColor copyWithZone:zone]];
        [copy setForegroundColor:[self.foregroundColor copyWithZone:zone]];
        [copy setFontFamily:[self.fontFamily copyWithZone:zone]];
        [copy setHorizontalTextAlignment:[self.horizontalTextAlignment copyWithZone:zone]];
        [copy setVerticalTextAlignment:[self.verticalTextAlignment copyWithZone:zone]];
    }
    return copy;
}

#pragma mark - NSCoder

-(void) encodeWithCoder: (NSCoder *) coder {
    [coder encodeObject:self.foregroundColor forKey:NSStringFromSelector(@selector(foregroundColor))];
    [coder encodeObject: self.horizontalTextAlignment forKey:NSStringFromSelector(@selector(horizontalTextAlignment))];
    [coder encodeObject: self.backgroundColor forKey:NSStringFromSelector(@selector(backgroundColor))];
    [coder encodeObject:self.foregroundColor forKey:NSStringFromSelector(@selector(foregroundColor))];
}

@end
