//
// Created by Jan Schulte on 23/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCProject.h"


@implementation RCProject

-(id) init {
    self = [super init];
    if(self) {
        [self setFiles:[NSArray array]];
    }
    return self;
}

@end
