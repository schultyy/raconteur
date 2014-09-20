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
        [self setFontSize:                [coder decodeObjectForKey:NSStringFromSelector(@selector(fontSize))]];
    }
    return self;
}

-(id)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if(self) {
        NSColor *backgroundColor = [NSColor colorWithHex: [dict valueForKey: RCBackgroundColor]];
        NSColor *textColor = [NSColor colorWithHex:[dict valueForKey: RCTextColor]];

        [self setBackgroundColor: backgroundColor];
        [self setForegroundColor: textColor];
        [self setFontFamily:[dict valueForKey: RCFontFamily]];
        [self setHorizontalTextAlignment:[dict valueForKey:RCHorizontalTextAlignment]];
        [self setVerticalTextAlignment: [dict valueForKey:RCVerticalTextAlignment]];
        [self setFontSize:[dict valueForKey:RCFontsize]];
    }
    return self;
}

-(NSDictionary *) toDictionary {
    return @{
            RCHorizontalTextAlignment: self.horizontalTextAlignment,
            RCVerticalTextAlignment: self.verticalTextAlignment,
            RCFontFamily: self.fontFamily,
            RCBackgroundColor: self.backgroundColor.hexColor,
            RCTextColor: self.foregroundColor.hexColor,
            RCFontsize: self.fontSize
    };
}

+(RCSlideOptions *) defaultOptions {
    if(!defaultOptions) {
        RCSlideOptions *opts = [[RCSlideOptions alloc] init];
        [opts setForegroundColor:[NSColor blackColor]];
        [opts setBackgroundColor:[NSColor whiteColor]];
        [opts setHorizontalTextAlignment:RCHorizontalTextAlignmentLeftValue];
        [opts setVerticalTextAlignment:RCVerticalTextAlignmentTopValue];
        [opts setFontFamily:@"Arial"];
        [opts setFontSize:[NSNumber numberWithInt:40]];
        defaultOptions = opts;
    }
    return [defaultOptions copy];
}

+(void) setDefaultOptions: (RCSlideOptions *) newOptions {
    defaultOptions = newOptions;
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
        [copy setFontSize:[self.fontSize copyWithZone:zone]];
    }
    return copy;
}

#pragma mark - NSCoder

-(void) encodeWithCoder: (NSCoder *) coder {
    [coder encodeObject:self.foregroundColor forKey:NSStringFromSelector(@selector(foregroundColor))];
    [coder encodeObject: self.horizontalTextAlignment forKey:NSStringFromSelector(@selector(horizontalTextAlignment))];
    [coder encodeObject: self.backgroundColor forKey:NSStringFromSelector(@selector(backgroundColor))];
    [coder encodeObject:self.fontFamily forKey:NSStringFromSelector(@selector(fontFamily))];
    [coder encodeObject:self.fontSize forKey:NSStringFromSelector(@selector(fontSize))];
}

@end
