//
// Created by Jan Schulte on 25/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCProjectSerializer.h"
#import "RCProject.h"
#import "Underscore.h"
#import "RCSlide.h"


@implementation RCProjectSerializer

+(void) serializeObject: (RCProject *) obj toFile: (NSString *) directory {

    NSArray *slideContents = Underscore.arrayMap(obj.slides, ^(RCSlide *slide) {
       return slide.text;
    });

    for(NSUInteger i = 0; i < [slideContents count]; i++) {
        NSString *filename = [directory stringByAppendingPathComponent: [NSString stringWithFormat: @"%d.md", (int) i]];
        NSString *slideContent = [slideContents objectAtIndex:i];
        [slideContent writeToFile:filename atomically:NO encoding:NSUTF8StringEncoding error:nil];
    }
}

@end
