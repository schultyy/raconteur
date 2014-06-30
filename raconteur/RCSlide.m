//
// Created by Jan Schulte on 25/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCSlide.h"
#import "RCConstants.h"
#import "RCSlideOptions.h"
#import "NSColor+RCHexValue.h"
#import "RCFrontMatterParser.h"
#import "MMMarkdown.h"

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

-(id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if(self) {
        [self setOptions: [coder decodeObjectForKey:NSStringFromSelector(@selector(options))]];
        [self setText:[coder decodeObjectForKey:NSStringFromSelector(@selector(text))]];
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
            "%@: %@\n" \
            "%@: %@\n" \
            "%@: %@\n"
            "---",
                    RCFontFamily, opts.fontFamily,
                    RCTextColor, opts.foregroundColor.hexColor,
                    RCBackgroundColor, opts.backgroundColor.hexColor,
                    RCHorizontalTextAlignment, opts.horizontalTextAlignment,
                    RCVerticalTextAlignment, opts.verticalTextAlignment];
    return [NSString stringWithFormat:@"%@\n%@", frontMatter, self.text];
}

#pragma mark - HTML

-(NSString *) verticalTextAlign {

    NSString *valign = self.options.verticalTextAlignment;
    NSMutableString *style = [NSMutableString string];
    [style appendString:@"margin-top: 50%"];

//    if ([valign isEqualToString:RCVerticalTextAlignmentCenterValue]) {
//        [style appendString:@".container { padding: 5% 0; }"];
//        [style appendString:@".slide { padding: 10% 0; }"];
//    }

//    if([valign isEqualToString:RCVerticalTextAlignmentCenterValue]) {
//        [style appendString:@"vertical-align: middle;"];
//    }

//    if([valign isEqualToString:RCVerticalTextAlignmentTopValue]) {
//        [style appendString:@"top: 0%;\n"];
//        [style appendString:@"transform: translateY(0%);\n"];
//    }
//    else if([valign isEqualToString:RCVerticalTextAlignmentCenterValue]) {
//        [style appendString:@"top: 50%;\n"];
//        [style appendString:@"transform: translateY(50%);\n"];
//    }
//    else if([valign isEqualToString:RCVerticalTextAlignmentBottomValue]) {
//        [style appendString:@"top: 100%;\n"];
//        [style appendString:@"transform: translateY(0%);\n"];
//    }

    return style;
}

-(NSString *) styles {
    NSString *fontFamily = [NSString stringWithFormat:@"font-family: %@;", self.options.fontFamily];
    NSString *backgroundColor = [NSString stringWithFormat:@"background-color:%@;", self.options.backgroundColor.hexColor];
    NSString *foregroundColor = [NSString stringWithFormat:@"color:%@;", self.options.foregroundColor.hexColor];
    NSString *horizontalTextAlignment = [NSString stringWithFormat:@"text-align: %@;", self.options.horizontalTextAlignment];


    return [NSString stringWithFormat:@".slide {\n" \
                                "%@\n" \
                                "%@\n" \
                                "%@\n" \
                                "%@\n" \
                                "%@\n}", fontFamily, backgroundColor, foregroundColor, horizontalTextAlignment, self.verticalTextAlign];
}

-(NSString *)preview {
    NSString *slideHtml =
            [NSString stringWithFormat:@"<section class='slide'>%@</section>",
                                       [MMMarkdown HTMLStringWithMarkdown:self.text error:nil]];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"basic-template" ofType:@"html"];
    NSString *template = [NSString stringWithContentsOfFile:path
                                                   encoding:NSUTF8StringEncoding
                                                      error:nil];

    return [[template stringByReplacingOccurrencesOfString:@"{{CONTENT}}" withString:slideHtml]
            stringByReplacingOccurrencesOfString:@"{{STYLES}}" withString: self.styles];
}

#pragma mark - NSCoding

-(void) encodeWithCoder: (NSCoder *) coder {
    [coder encodeObject:self.text forKey:NSStringFromSelector(@selector(text))];
    [coder encodeObject:self.options forKey:NSStringFromSelector(@selector(options))];
}

@end
