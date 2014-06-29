//
// Created by Jan Schulte on 25/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCPresentationBuilder.h"
#import "MMMarkdown.h"
#import "RCProject.h"
#import "Underscore.h"
#import "RCSlide.h"
#import "RCSlideOptions.h"
#import "NSColor+RCHexValue.h"

@interface RCPresentationBuilder()
@property (readwrite, assign) RCProject *project;
@end

@implementation RCPresentationBuilder

-(id)initWithProject:(RCProject *)project {
    self = [super init];
    if(self) {
        [self setProject:project];
    }
    return self;
}

-(NSString *) generateStyles: (RCSlideOptions *) options {
    NSString *fontFamily = [NSString stringWithFormat:@"font-family: %@;", options.fontFamily];
    NSString *backgroundColor = [NSString stringWithFormat:@"background-color:%@;", options.backgroundColor.hexColor];
    NSString *foregroundColor = [NSString stringWithFormat:@"color:%@;", options.textColor.hexColor];
    NSString *textAlignment = [NSString stringWithFormat:@"text-align: %@", options.textAlignment];

    return [NSString stringWithFormat:@"body {\n" \
                                "%@\n" \
                                "%@\n" \
                                "%@\n" \
                                "%@\n}", fontFamily, backgroundColor, foregroundColor, textAlignment];
}

-(NSString *) renderContent: (NSString *) content withOptions: (RCSlideOptions *) options {

    NSString *path = [[NSBundle mainBundle] pathForResource:@"basic-template" ofType:@"html"];
    NSString *template = [NSString stringWithContentsOfFile:path
                                                   encoding:NSUTF8StringEncoding
                                                      error:nil];

    return [[template stringByReplacingOccurrencesOfString:@"{{CONTENT}}" withString:content]
            stringByReplacingOccurrencesOfString:@"{{STYLES}}" withString:[self generateStyles:options]];
}

-(NSString *)processAllSlides: (RCSlideOptions *) options {
    NSArray *htmlSlides = Underscore.arrayMap([[self project] slides], ^NSString *(RCSlide *slide) {
        NSError  *error;
        NSString *html = [MMMarkdown HTMLStringWithMarkdown:slide.text
                                     error:&error];
        if(error) {
            return nil;
        }
        return [NSString stringWithFormat:@"<section class='slide'>%@</section>", html];
    });

    return [self renderContent: [htmlSlides componentsJoinedByString:@"\n"]
                   withOptions:options];
}

@end
