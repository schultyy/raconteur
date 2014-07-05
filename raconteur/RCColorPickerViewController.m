//
// Created by Jan Schulte on 05/07/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCColorPickerViewController.h"
#import "NSColor+RCHexValue.h"

@implementation RCColorPickerViewController

-(id) init {
    self = [super initWithNibName:@"RCColorPickerView" bundle:nil];
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self addObserver:self forKeyPath:NSStringFromSelector(@selector(pickedColor)) options:NSKeyValueObservingOptionNew context:NULL];
    [self addObserver:self forKeyPath:NSStringFromSelector(@selector(hexColor)) options:NSKeyValueObservingOptionNew context:NULL];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:NSStringFromSelector(@selector(pickedColor))]) {
        [self setHexColor:self.pickedColor.hexColor];
    }
    else if([keyPath isEqualToString:NSStringFromSelector(@selector(hexColor))]) {
        if([self.hexColor isEqualToString:self.pickedColor.hexColor]) {
            return;
        }
        [self setPickedColor:[NSColor colorWithHex:self.hexColor]];
    }
}

@end
