//
// Created by Jan Schulte on 25/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RCSlide;

@interface RCSlideEditorViewController : NSViewController

@property (assign) RCSlide *currentSlide;

@property (nonatomic, strong, readonly) NSDictionary *alignmentOptions;

@end
