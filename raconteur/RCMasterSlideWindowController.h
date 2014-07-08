//
// Created by Jan Schulte on 02/07/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RCSlideOptions;
@class RCColorPickerViewController;


@interface RCMasterSlideWindowController : NSWindowController

@property (nonatomic, strong) RCSlideOptions *defaultOptions;

@property (nonatomic, strong, readonly) RCColorPickerViewController *foregroundPicker;

@property (nonatomic, strong, readonly) RCColorPickerViewController *backgroundPicker;

@property (nonatomic, strong, readonly) NSDictionary *horizontalTextAlignmentOptions;

@property IBOutlet NSBox *foregroundPickerView;

@property IBOutlet NSBox *backgroundPickerView;

-(IBAction) discard: (id) sender;

-(IBAction) save: (id) sender;

@end
