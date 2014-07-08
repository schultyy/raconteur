//
// Created by Jan Schulte on 02/07/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCMasterSlideWindowController.h"
#import "RCSlideOptions.h"
#import "RCColorPickerViewController.h"
#import "RCConstants.h"

@interface RCMasterSlideWindowController()
@property (nonatomic, strong, readwrite) RCColorPickerViewController *foregroundPicker;
@property (nonatomic, strong, readwrite) RCColorPickerViewController *backgroundPicker;
@property (nonatomic, strong, readwrite) NSDictionary *horizontalTextAlignmentOptions;
@end

@implementation RCMasterSlideWindowController

-(id) init {
    self = [super initWithWindowNibName:@"RCMasterSlideWindow"];
    if(self) {
        [self setDefaultOptions: [RCSlideOptions defaultOptions]];
        [self setForegroundPicker:[[RCColorPickerViewController alloc] initWithColor:self.defaultOptions.foregroundColor]];
        [self setBackgroundPicker:[[RCColorPickerViewController alloc] initWithColor:self.defaultOptions.backgroundColor]];

        NSMutableDictionary *horizontalDict = [NSMutableDictionary dictionary];
        [horizontalDict setValue: RCHorizontalTextAlignmentCenterValue forKey:RCHorizontalTextAlignmentCenterKey];
        [horizontalDict setValue: RCHorizontalTextAlignmentLeftValue forKey:RCHorizontalTextAlignmentLeftKey];
        [horizontalDict setValue: RCHorizontalTextAlignmentRightValue forKey:RCHorizontalTextAlignmentRightKey];
        [self setHorizontalTextAlignmentOptions:horizontalDict];
    }
    return self;
}

-(void)awakeFromNib {
    [self addObserver:self forKeyPath:NSStringFromSelector(@selector(defaultOptions)) options:NSKeyValueObservingOptionNew context:NULL];
    [self.foregroundPicker addObserver:self forKeyPath:NSStringFromSelector(@selector(pickedColor)) options:NSKeyValueObservingOptionNew context:NULL];
    [self.backgroundPicker addObserver:self forKeyPath:NSStringFromSelector(@selector(pickedColor)) options:NSKeyValueObservingOptionNew context:NULL];

    [[self foregroundPickerView] setContentView:self.foregroundPicker.view];
    [[self backgroundPickerView] setContentView:self.backgroundPicker.view];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:NSStringFromSelector(@selector(pickedColor))]) {
        if([object isEqual:self.foregroundPicker]) {
            [self.defaultOptions setForegroundColor:self.foregroundPicker.pickedColor];
        }
        else if([object isEqual:self.backgroundPicker]) {
            [self.defaultOptions setBackgroundColor:self.backgroundPicker.pickedColor];
        }
    }
    else if([keyPath isEqualToString:NSStringFromSelector(@selector(defaultOptions))]) {
        [[self foregroundPicker] setPickedColor:self.defaultOptions.foregroundColor];
        [[self backgroundPicker] setPickedColor:self.defaultOptions.backgroundColor];
    }
}

-(IBAction) discard: (id) sender {
    [self setDefaultOptions:[RCSlideOptions defaultOptions]];
    [[self window] orderOut:self];
    [NSApp endSheet:self.window returnCode:-1];
}

-(IBAction) save: (id) sender {
    [[self window] orderOut:self];
    [NSApp endSheet:self.window returnCode:+1];
}

@end
