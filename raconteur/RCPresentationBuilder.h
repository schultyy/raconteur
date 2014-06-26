//
// Created by Jan Schulte on 25/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RCProject;
@class RCExportOptions;


@interface RCPresentationBuilder : NSObject

@property (readonly, assign) RCProject *project;

-(id) initWithProject: (RCProject *) project;

-(NSString *)processAllSlides: (RCExportOptions *) options;

-(NSString *) renderContent: (NSString *) content withOptions: (RCExportOptions *) options;

@end
