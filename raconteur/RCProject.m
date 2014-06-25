//
// Created by Jan Schulte on 23/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCProject.h"
#import "RCSlide.h"


@implementation RCProject

-(id) init {
    self = [self initWithSlides:[NSArray array] andPath: nil];
    return self;
}

-(id)initWithSlides:(NSArray *)slides andPath:(NSString *)path {
    self = [super init];
    if(self) {
        [self setSlides:slides];
        [self setDirectory:path];
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

-(void) removeSlide: (RCSlide *) slide {
    NSMutableArray *tmp = [NSMutableArray arrayWithArray:self.slides];
    [tmp removeObject:slide];
    [self willChangeValueForKey:NSStringFromSelector(@selector(slides))];
    [self setSlides: tmp];
    [self didChangeValueForKey:NSStringFromSelector(@selector(slides))];
}

@end
