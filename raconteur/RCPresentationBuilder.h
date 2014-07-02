//
// Created by Jan Schulte on 01/07/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCBuilderBase.h"

@class RCProject;


@interface RCPresentationBuilder : RCBuilderBase

-(NSString *) renderSlides;

-(void) export: (NSString *) filePath;

@end
