//
// Created by Jan Schulte on 23/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCMainController.h"
#import "RCProject.h"

@interface RCMainController()
@property (readwrite, nonatomic, strong) RCProject *project;
@end

@implementation RCMainController

-(id) init {
    self = [super initWithWindowNibName:@"RCMainWindow"];
    if(self) {
        [self setProject:[[RCProject alloc] init]];
    }
    return self;
}

-(void) addSlide {
    [[self project] addSlide];
}

@end
