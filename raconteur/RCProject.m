//
// Created by Jan Schulte on 23/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCProject.h"
#import "RCSlide.h"


@implementation RCProject

-(id) init {
    self = [super init];
    if(self) {
        [self setSlides:[NSArray array]];
    }
    return self;
}

-(id) initWithSlides: (NSArray *) slides {
    self = [super init];
    if(self) {
        [self setSlides:slides];
    }
    return self;
}

-(void) addSlide {
    RCSlide *slide = [[RCSlide alloc] init];
    [slide setText:@"text"];
    [self willChangeValueForKey:NSStringFromSelector(@selector(slides))];
    [self setSlides:[[self slides] arrayByAddingObject:slide]];
    [self didChangeValueForKey:NSStringFromSelector(@selector(slides))];
}

@end
