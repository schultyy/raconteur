//
// Created by Jan Schulte on 23/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RCSlide;


@interface RCProject : NSObject

@property (nonatomic, strong) NSArray *slides;

@property (strong) NSString *filePath;

-(id) initWithSlides: (NSArray *) slides andPath: (NSString *) path;

-(void) addSlide;

-(void) removeSlide: (RCSlide *) slide;

@end
