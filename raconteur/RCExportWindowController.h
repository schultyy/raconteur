//
// Created by Jan Schulte on 25/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RCExportWindowController : NSWindowController

@property (nonatomic, strong) NSString *fontFamily;

@property (nonatomic, strong) NSNumber *fontSize;

@property (nonatomic, strong) NSColor *foreground;

@property (nonatomic, strong) NSColor *background;

-(IBAction) export: (id) sender;

@end
