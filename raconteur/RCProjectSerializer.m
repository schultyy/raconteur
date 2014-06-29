//
// Created by Jan Schulte on 25/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCProjectSerializer.h"
#import "RCProject.h"
#import "Underscore.h"
#import "RCSlide.h"
#import "RCFrontMatterParser.h"


@implementation RCProjectSerializer

+(void) serializeObject: (RCProject *) obj toFile: (NSString *) filePath {

    NSArray *slideContents = Underscore.arrayMap(obj.slides, ^(RCSlide *slide) {
       return [slide textWithFrontmatter];
    });

    NSArray *filenames = [NSArray array];

    NSString *directory = [filePath stringByDeletingLastPathComponent];

    NSString *projectName = [[filePath lastPathComponent] stringByDeletingPathExtension];

    for(NSUInteger i = 0; i < [slideContents count]; i++) {
        NSString *filename = [directory stringByAppendingPathComponent: [NSString stringWithFormat: @"%@-%d.md", projectName, (int) i]];
        NSString *slideContent = [slideContents objectAtIndex:i];
        [slideContent writeToFile:filename atomically:NO encoding:NSUTF8StringEncoding error:nil];
        filenames = [filenames arrayByAddingObject:filename];
    }

    [[NSJSONSerialization dataWithJSONObject:filenames options:0 error:nil] writeToFile: filePath atomically:NO];
}

+(RCProject *) load: (NSString *) projectFilePath {
    NSData *json = [NSData dataWithContentsOfFile:projectFilePath];
    NSArray *slideFilenames = [NSJSONSerialization JSONObjectWithData:json options:0 error:nil];
    NSArray *slides = Underscore.arrayMap(slideFilenames, ^(NSString *filename){
        return [RCSlide fromFile: filename];
    });
    return [[RCProject alloc] initWithSlides: slides andPath: projectFilePath];
}

@end
