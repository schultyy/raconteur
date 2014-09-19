//
// Created by Jan Schulte on 19/09/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCProjectContext.h"
#import "RCProject.h"
#import "RCProjectSerializer.h"


@implementation RCProjectContext

-(NSString *)saveProject: (RCProject *) project atPath:(NSString *) rootPath {
    NSString *filename = [rootPath lastPathComponent];
    NSString *slidePath = [[self srcPathForProject:rootPath] stringByAppendingPathComponent:filename];
    [RCProjectSerializer serializeObject:project toFile: slidePath];
    return slidePath;
}

-(NSString *)saveNewProject:(RCProject *)project atPath:(NSString *)rootPath {
    [[NSFileManager defaultManager] createDirectoryAtPath: [self srcPathForProject:rootPath] withIntermediateDirectories:NO
                                               attributes:nil error:NULL];
    [[NSFileManager defaultManager] createDirectoryAtPath:[self buildPathForProject:rootPath] withIntermediateDirectories:NO
                                               attributes:nil error:NULL];
    [[NSFileManager defaultManager] createDirectoryAtPath:[self assetPathForProject:rootPath] withIntermediateDirectories:NO
                                               attributes:nil error:NULL];

    return [self saveProject:project atPath:rootPath];
}

-(NSString *) assetPathForProject: (NSString *) projectPath {
    NSString *root = [self basePath:projectPath];
    return [root stringByAppendingPathComponent:@"assets"];
}

-(NSString *) buildPathForProject: (NSString *) projectPath {
    NSString *root = [self basePath:projectPath];
    return [root stringByAppendingPathComponent:@"build"];
}

-(NSString *) srcPathForProject: (NSString *) projectPath {
    NSString *root = [self basePath:projectPath];
    return [root stringByAppendingPathComponent:@"src"];
}

-(NSString *) basePath: (NSString *) projectPath {
    return [projectPath stringByDeletingLastPathComponent];
}

@end
