//
// Created by Jan Schulte on 26/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RCSlideOptions : NSObject

@property (nonatomic, strong) NSString *fontFamily;

@property (nonatomic, strong) NSColor *textColor;

@property (nonatomic, strong) NSColor *backgroundColor;

+(RCSlideOptions *) defaultOptions;

+(RCSlideOptions *) fromFrontmatter: (NSDictionary *) frontmatter;

@end
