//
// Created by Jan Schulte on 02/07/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCBuilderBase.h"
#import "RCProject.h"
#import "RCSlide.h"


@implementation RCBuilderBase

-(id)initWithProject:(RCProject *)project {
    self = [super init];
    if(self) {
        [self setProject:project];
    }
    return self;
}

-(NSString *) renderSlide: (RCSlide *) slide {
    NSString *styles = [[slide styles] componentsJoinedByString:@""];
    NSString *html = [slide html];
    return [NSString stringWithFormat:@"<div class='slide' style='%@'>%@</div>", styles, html];
}

-(NSString *) template {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"basic-template" ofType:@"html"];
    return [NSString stringWithContentsOfFile:path
                                     encoding:NSUTF8StringEncoding
                                        error:nil];
}

@end
