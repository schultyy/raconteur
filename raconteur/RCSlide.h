//
// Created by Jan Schulte on 25/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RCSlideOptions;


@interface RCSlide : NSObject

@property (strong) NSString *text;

@property (readonly, nonatomic, strong) RCSlideOptions *options;

+(RCSlide *) fromFile: (NSString *) filename;

-(NSString *) textWithFrontmatter;

@end
