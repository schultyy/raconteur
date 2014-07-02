//
// Created by Jan Schulte on 02/07/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RCProject;
@class RCSlide;


@interface RCBuilderBase : NSObject

@property (assign) RCProject *project;

-(id) initWithProject: (RCProject *) project;

-(NSString *) renderSlide: (RCSlide *) slide;

-(NSString *) template;

@end
