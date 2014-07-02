//
// Created by Jan Schulte on 01/07/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCPresentationBuilder.h"
#import "RCProject.h"
#import "Underscore.h"
#import "RCSlide.h"


@implementation RCPresentationBuilder

-(void)export:(NSString *) filePath {
    NSMutableString *html = [[self renderSlides] mutableCopy];
    NSRange styleRange = [html rangeOfString:@"</style>"];
    NSString *includes = @"<script type='text/javascript' src='jquery-2.1.1.min.js'></script>\n" \
                         "<script type='text/javascript' src='slideManager.js'></script>";
    [html insertString:includes atIndex: styleRange.location + styleRange.length + 1];
    [html writeToFile: filePath
           atomically:NO
             encoding:NSUTF8StringEncoding
                error:nil];
    [self exportDependencies:filePath];
}

-(void) exportDependencies: (NSString *) filePath {
    NSString *directory = [filePath stringByDeletingLastPathComponent];

    Underscore.arrayEach(@[@"jquery-2.1.1.min", @"slideManager"], ^(NSString *file){
        NSString *path = [[NSBundle mainBundle] pathForResource:file ofType:@"js"];
        NSString *fileContent = [NSString stringWithContentsOfFile:path
                                                          encoding:NSUTF8StringEncoding
                                                             error:nil];
        NSString *filename = [NSString stringWithFormat:@"%@.js", file];

        [fileContent writeToFile:[directory stringByAppendingPathComponent:filename] atomically:NO encoding:NSUTF8StringEncoding error:nil];
    });
}

-(NSString *) renderSlides {

    /*
    Slides cannot render their styles into the main style region.

    Option 1:
    Create custom class like `slide-01` and paste all related styles there

    Option 2:
    Write all styles on the corresponding div element for a slide like:
    <div style="<styles here>" class='slide'>
    </div>

     */
    NSString *slidesHtml = [Underscore.arrayMap(self.project.slides, ^(RCSlide *slide) {
        return [self renderSlide:slide];
    }) componentsJoinedByString:@"\n"];
    return [self.template stringByReplacingOccurrencesOfString:@"{{CONTENT}}" withString:slidesHtml];
}

@end
