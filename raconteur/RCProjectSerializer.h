//
// Created by Jan Schulte on 25/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RCProject;


@interface RCProjectSerializer : NSObject

+(void) serializeObject: (RCProject *) obj toFile: (NSString *) filePath;
+(RCProject *) load: (NSString *) projectFilePath;

@end
