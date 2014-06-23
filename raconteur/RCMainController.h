//
// Created by Jan Schulte on 23/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RCMainController : NSWindowController

@property (readonly, nonatomic, strong) NSString *currentWorkingDirectory;

-(id) initWithWorkingDirectory: (NSString *) cwd;
@end
