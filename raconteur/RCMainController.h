//
// Created by Jan Schulte on 23/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RCProject;


@interface RCMainController : NSWindowController

@property (readonly, nonatomic, strong) NSString *currentWorkingDirectory;

@property (readonly, nonatomic, strong) RCProject *project;

-(id) initWithWorkingDirectory: (NSString *) cwd;

-(void) addFile;

@end
