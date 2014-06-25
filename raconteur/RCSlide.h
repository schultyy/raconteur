//
// Created by Jan Schulte on 25/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RCSlide : NSObject

@property (strong) NSString *text;

+(RCSlide *) fromFile: (NSString *) filename;

@end
