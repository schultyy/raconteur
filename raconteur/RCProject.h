//
// Created by Jan Schulte on 23/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RCProject : NSObject

@property (nonatomic, strong) NSArray *slides;

@property (strong) NSString *directory;

-(void) addSlide;

@end
