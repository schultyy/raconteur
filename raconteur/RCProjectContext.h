//
// Created by Jan Schulte on 19/09/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RCProject;


@interface RCProjectContext : NSObject

-(RCProject *) loadProject: (NSString *) projectPath;

-(void) saveProject: (RCProject *) project;
-(RCProject *) saveNewProject: (RCProject *) project atPath: (NSString *) path;

@end
