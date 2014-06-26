//
// Created by Jan Schulte on 25/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RCProject;
@class RCExportOptions;


@interface RCPresentationBuilder : NSObject

-(id) initWithProject: (RCProject *) project;

-(NSString *)processAllSlides: (RCExportOptions *) options;

@end
