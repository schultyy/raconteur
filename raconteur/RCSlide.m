//
// Created by Jan Schulte on 25/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCSlide.h"
#import "RCSlideOptions.h"
#import "NSColor+RCHexValue.h"

@interface RCSlide()
@property (readwrite, nonatomic, strong) RCSlideOptions *options;
@end

@implementation RCSlide

-(id) init {
    self = [super init];
    if(self) {
        [self setOptions:[RCSlideOptions defaultOptions]];
    }
    return self;
}

+(RCSlide *) fromFile: (NSString *) filename {
    RCSlide *slide = [[RCSlide alloc] init];

    [slide setText:[NSString stringWithContentsOfFile:filename encoding:NSUTF8StringEncoding error:nil]];
    return slide;
}

-(id)description {
    return self.text;
}

-(NSString *) textWithFrontmatter {
    RCSlideOptions *opts = [self options];
    NSString *frontMatter = [NSString stringWithFormat:
            @"---\n" \
            "FontFamily: %@\n" \
            "TextColor: %@\n" \
            "BackgroundColor: %@\n"
            "---", opts.fontFamily,
                    opts.textColor.hexColor,
                    opts.backgroundColor.hexColor];
    return [NSString stringWithFormat:@"%@\n%@", frontMatter, self.text];
}

@end
