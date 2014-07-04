//
// Created by Jan Schulte on 25/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCSlideEditorViewController.h"
#import "RCConstants.h"
#import "NSColor+RCHexValue.h"
#import "RCSlide.h"
#import "RCSlideOptions.h"


@interface RCSlideEditorViewController()
@property (nonatomic, strong, readwrite) NSDictionary *horizontalAlignmentOptions;
@property (nonatomic, strong, readwrite) NSDictionary *verticalAlignmentOptions;
@end

@implementation RCSlideEditorViewController

-(id) init {
    self = [super initWithNibName:@"RCSlideEditorView" bundle:nil];
    if(self) {
        NSMutableDictionary *horizontalDict = [NSMutableDictionary dictionary];
        [horizontalDict setValue: RCHorizontalTextAlignmentCenterValue forKey:RCHorizontalTextAlignmentCenterKey];
        [horizontalDict setValue: RCHorizontalTextAlignmentLeftValue forKey:RCHorizontalTextAlignmentLeftKey];
        [horizontalDict setValue: RCHorizontalTextAlignmentRightValue forKey:RCHorizontalTextAlignmentRightKey];

        NSMutableDictionary *verticalDict = [NSMutableDictionary dictionary];
        [verticalDict setValue:RCVerticalTextAlignmentTopValue forKey:RCVerticalTextAlignmentTopKey];
        [verticalDict setValue:RCVerticalTextAlignmentCenterValue forKey:RCVerticalTextAlignmentCenterKey];
        [verticalDict setValue:RCVerticalTextAlignmentBottomValue forKey:RCVerticalTextAlignmentBottomKey];

        [self setHorizontalAlignmentOptions:horizontalDict];
        [self setVerticalAlignmentOptions:verticalDict];
    }
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];

    [self addObserver:self forKeyPath:NSStringFromSelector(@selector(foregroundHexColor)) options:NSKeyValueObservingOptionNew context:NULL];
    [self addObserver:self forKeyPath:NSStringFromSelector(@selector(backgroundHexColor)) options:NSKeyValueObservingOptionNew context:NULL];
    [self addObserver:self forKeyPath:NSStringFromSelector(@selector(currentSlide)) options:NSKeyValueObservingOptionNew context:NULL];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:NSStringFromSelector(@selector(foregroundHexColor))]) {
        [[[self currentSlide] options] setForegroundColor: [NSColor colorWithHexColorString:self.foregroundHexColor]];
    }
    else if([keyPath isEqualToString:NSStringFromSelector(@selector(backgroundHexColor))]) {
        [[[self currentSlide] options] setBackgroundColor: [NSColor colorWithHexColorString:self.backgroundHexColor]];
    }
    else if([keyPath isEqualToString:NSStringFromSelector(@selector(currentSlide))]) {
        RCSlideOptions *options = [[self currentSlide] options];
        [self setForegroundHexColor:options.foregroundColor.hexColor];
        [self setBackgroundHexColor:options.backgroundColor.hexColor];
    }
}

/*
 From https://developer.apple.com/library/mac/qa/qa1454/_index.html
 */
- (BOOL)control:(NSControl*)control textView:(NSTextView*)textView doCommandBySelector:(SEL)commandSelector
{
    BOOL result = NO;
    
    if (commandSelector == @selector(insertNewline:))
    {
        // new line action:
        // always insert a line-break character and don’t cause the receiver to end editing
        [textView insertNewlineIgnoringFieldEditor:self];
        result = YES;
    }
    else if (commandSelector == @selector(insertTab:))
    {
        // tab action:
        // always insert a tab character and don’t cause the receiver to end editing
        [textView insertTabIgnoringFieldEditor:self];
        result = YES;
    }
    
    return result;
}

@end
