//
// Created by Jan Schulte on 26/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RCSlideOptions : NSObject<NSCoding, NSCopying>

@property (nonatomic, strong) NSString *fontFamily;

@property (nonatomic, strong) NSColor *foregroundColor;

@property (nonatomic, strong) NSColor *backgroundColor;

@property (nonatomic, strong) NSString *horizontalTextAlignment;

@property (nonatomic, strong) NSString *verticalTextAlignment;

-(id) initWithCoder: (NSCoder *) coder;

+(RCSlideOptions *) defaultOptions;

+(void) setDefaultOptions: (RCSlideOptions *) newOptions;

+(RCSlideOptions *) fromFrontmatter: (NSDictionary *) frontmatter;

@end
