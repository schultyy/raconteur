//
// Created by Jan Schulte on 25/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RCSlideOptions;


@interface RCExportWindowController : NSWindowController

@property (readonly, nonatomic, strong) RCSlideOptions *exportOptions;

-(IBAction) discard: (id) sender;

-(IBAction) export: (id) sender;

@end
