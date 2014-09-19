//
// Created by Jan Schulte on 23/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RCSlide;


@interface RCProject : NSObject

@property (nonatomic, strong) NSMutableArray *slides;

@property (strong) NSString *projectDirectoryPath;

@property (strong) NSString *filename;

-(id) initWithSlides: (NSArray *) slides;

-(id) initWithSlides: (NSArray *) slides directory: (NSString *) directory andFilename: (NSString *) filename;

-(RCSlide *) addSlide;

-(void) addSlide: (RCSlide *) newSlide;

-(void) removeSlide: (RCSlide *) slide;

@end
