//
// Created by Jan Schulte on 23/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCProject.h"
#import "RCSlide.h"


@implementation RCProject

-(id) init {
    self = [self initWithSlides:[NSMutableArray array] directory: nil andFilename:nil];
    return self;
}

-(id) initWithSlides: (NSArray *) slides {
    return [self initWithSlides:slides directory: nil andFilename:nil];
}

-(id) initWithSlides: (NSArray *) slides directory: (NSString *) directory andFilename: (NSString *) filename {
    self = [super init];
    if(self) {
        [self setSlides:[NSMutableArray arrayWithArray:slides]];
        [self setProjectDirectoryPath:directory];
        [self setFilename:filename];
    }
    return self;
}

-(RCSlide *) addSlide {
    RCSlide *slide = [[RCSlide alloc] init];
    [slide setText:@"text"];
    [self addSlide: slide];
    return slide;
}

-(void) addSlide: (RCSlide *) newSlide {
    [self willChangeValueForKey:NSStringFromSelector(@selector(slides))];
    [[self slides] addObject:newSlide];
    [self didChangeValueForKey:NSStringFromSelector(@selector(slides))];
}

-(void) removeSlide: (RCSlide *) slide {
    [self willChangeValueForKey:NSStringFromSelector(@selector(slides))];
    [[self slides] removeObject:slide];
    [self didChangeValueForKey:NSStringFromSelector(@selector(slides))];
}

@end
