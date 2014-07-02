//
// Created by Jan Schulte on 25/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RCSlideOptions;


@interface RCSlide : NSObject<NSCoding>

@property (strong) NSString *text;

@property (nonatomic, strong) RCSlideOptions *options;

-(id) initWithCoder: (NSCoder *) coder;

+(RCSlide *) fromFile: (NSString *) filename;

-(NSString *) textWithFrontmatter;

-(void) encodeWithCoder: (NSCoder *) coder;

-(void) setOptions: (RCSlideOptions *) newOptions;

-(NSArray *) styles;

-(NSString *) html;

@end
