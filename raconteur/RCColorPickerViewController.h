//
// Created by Jan Schulte on 05/07/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RCColorPickerViewController : NSViewController

@property (nonatomic, strong) NSColor *pickedColor;

@property (nonatomic, strong) NSString *hexColor;

-(id) initWithColor: (NSColor *) color;

@end
