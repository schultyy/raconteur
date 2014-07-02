//
// Created by Jan Schulte on 27/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCPresentationBuilder.h"
#import "RCBuilderBase.h"

@class RCProject;

@interface RCPagedPresentationBuilder : RCBuilderBase

-(id)initWithProject:(RCProject *)project;
-(NSString *) previousSlide;
-(NSString *) nextSlide;
-(NSString *) firstSlide;

@end
