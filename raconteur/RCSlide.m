//
// Created by Jan Schulte on 25/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCSlide.h"
#import "RCConstants.h"
#import "RCSlideOptions.h"
#import "NSColor+RCHexValue.h"
#import "RCFrontMatterParser.h"

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

    RCFrontMatterParser *parser = [[RCFrontMatterParser alloc] initWithFilepath:filename];
    NSDictionary *frontMatter = [parser parse:nil];
    [slide setOptions:[RCSlideOptions fromFrontmatter:frontMatter]];

    [slide setText:[self parseSlide:filename]];
    return slide;
}

+(NSString *) parseSlide: (NSString *) filename {
    NSString *fileContent = [NSString stringWithContentsOfFile:filename encoding:NSUTF8StringEncoding error:nil];
    NSRange limRange = [fileContent rangeOfString:@"---\n" options:NSBackwardsSearch];
    NSUInteger startPosition = limRange.location + limRange.length;
    NSRange frontMatterRange = NSMakeRange(startPosition, [fileContent length] - startPosition);
    return [fileContent substringWithRange:frontMatterRange];
}

-(id)description {
    return self.text;
}

-(NSString *) textWithFrontmatter {
    RCSlideOptions *opts = [self options];
    NSString *frontMatter = [NSString stringWithFormat:
            @"---\n" \
            "%@: %@\n" \
            "%@: %@\n" \
            "%@: %@\n"
            "---",
                    RCFontFamily, opts.fontFamily,
                    RCTextColor, opts.textColor.hexColor,
                    RCBackgroundColor, opts.backgroundColor.hexColor];
    return [NSString stringWithFormat:@"%@\n%@", frontMatter, self.text];
}

@end
