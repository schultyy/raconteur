//
// Created by Jan Schulte on 02/07/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RCSlideOptions;


@interface RCMasterSlideWindowController : NSWindowController

@property (nonatomic, strong) RCSlideOptions *defaultOptions;

-(IBAction) discard: (id) sender;

-(IBAction) save: (id) sender;

@end
