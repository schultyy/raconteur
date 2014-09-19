//
// Created by Jan Schulte on 19/09/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCProjectContext.h"
#import "RCProject.h"
#import "RCProjectSerializer.h"


@implementation RCProjectContext

-(RCProject *)loadProject:(NSString *)projectPath {
    RCProject *project = [RCProjectSerializer load: projectPath];
    NSString *filename = [projectPath lastPathComponent];
    NSString *src = [projectPath stringByDeletingLastPathComponent];

    [project setProjectDirectoryPath:[self basePath:src]];
    [project setFilename:filename];

    return project;
}

-(void) saveProject: (RCProject *) project {
    NSString *srcPath = [self srcPathForProject:project.projectDirectoryPath];
    NSString *slidePath = [srcPath stringByAppendingPathComponent:project.filename];
    [RCProjectSerializer serializeObject:project toFile: slidePath];
}

-(RCProject *)saveNewProject:(RCProject *)project atPath:(NSString *)rootPath {
    NSString *basePath = [self basePath:rootPath];
    [[NSFileManager defaultManager] createDirectoryAtPath: [self srcPathForProject:basePath] withIntermediateDirectories:NO
                                               attributes:nil error:NULL];
    [[NSFileManager defaultManager] createDirectoryAtPath:[self buildPathForProject:basePath] withIntermediateDirectories:NO
                                               attributes:nil error:NULL];
    [[NSFileManager defaultManager] createDirectoryAtPath:[self assetPathForProject:basePath] withIntermediateDirectories:NO
                                               attributes:nil error:NULL];

    NSString *filename = [rootPath lastPathComponent];
    RCProject *newProject = [[RCProject alloc] initWithSlides:project.slides
                                                    directory:[self basePath:rootPath]
                                                  andFilename:filename];
    [self saveProject:newProject];
    return newProject;
}

-(NSString *) assetPathForProject: (NSString *) projectPath {
    return [projectPath stringByAppendingPathComponent:@"assets"];
}

-(NSString *) buildPathForProject: (NSString *) projectPath {
    return [projectPath stringByAppendingPathComponent:@"build"];
}

-(NSString *) srcPathForProject: (NSString *) projectPath {
    return [projectPath stringByAppendingPathComponent:@"src"];
}

-(NSString *) basePath: (NSString *) projectPath {
    return [projectPath stringByDeletingLastPathComponent];
}

@end
