//
// Created by Jan Schulte on 25/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCSlide.h"


@implementation RCSlide

+(RCSlide *) fromFile: (NSString *) filename {
    RCSlide *slide = [[RCSlide alloc] init];

    [slide setText:[NSString stringWithContentsOfFile:filename encoding:NSUTF8StringEncoding error:nil]];
    return slide;
}

@end
