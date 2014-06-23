//
// Created by Jan Schulte on 23/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCMainController.h"
#import "RCProject.h"

@interface RCMainController()
@property (readwrite, nonatomic, strong) NSString *workingDirectory;
@property (readwrite, nonatomic, strong) RCProject *project;
@end

@implementation RCMainController

-(id) initWithWorkingDirectory: (NSString *) cwd {
    self = [super initWithWindowNibName:@"RCMainWindow"];
    if(self) {
        [self setWorkingDirectory:cwd];
        [self setProject:[[RCProject alloc] init]];
    }
    return self;
}

-(void)addFile {
    
}

@end
