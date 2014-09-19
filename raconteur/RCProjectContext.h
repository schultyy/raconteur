//
// Created by Jan Schulte on 19/09/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RCProject;


@interface RCProjectContext : NSObject
-(NSString *) saveProject: (RCProject *) project atPath:(NSString *) rootPath;
-(NSString *) saveNewProject: (RCProject *) project atPath: (NSString *) path;

@end
