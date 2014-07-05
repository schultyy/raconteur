//
// Created by Jan Schulte on 25/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCSlideEditorViewController.h"
#import "RCConstants.h"
#import "NSColor+RCHexValue.h"
#import "RCSlide.h"
#import "RCSlideOptions.h"
#import "RCColorPickerViewController.h"


@interface RCSlideEditorViewController()
@property (nonatomic, strong, readwrite) NSDictionary *horizontalAlignmentOptions;
@property (nonatomic, strong, readwrite) NSDictionary *verticalAlignmentOptions;
@property (nonatomic, strong, readwrite) RCColorPickerViewController *foregroundPicker;
@property (nonatomic, strong, readwrite) RCColorPickerViewController *backgroundPicker;
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

        [self setForegroundPicker:[[RCColorPickerViewController alloc] init]];
        [self setBackgroundPicker:[[RCColorPickerViewController alloc] init]];
    }
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self addObserver:self forKeyPath:NSStringFromSelector(@selector(currentSlide)) options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionPrior context:NULL];

    [[self foregroundColorView] setContentView:self.foregroundPicker.view];
    [[self backgroundColorView] setContentView:self.backgroundPicker.view];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([object isEqual:self]) {
        if ([keyPath isEqualToString:NSStringFromSelector(@selector(currentSlide))]) {
            if([change valueForKey:@"notificationIsPrior"] == [NSNumber numberWithBool:YES]) {
                @try {
                    [[self foregroundPicker] removeObserver:self forKeyPath:NSStringFromSelector(@selector(pickedColor))];
                }
                @catch(NSException * __unused exception) {}

                @try {
                    [[self backgroundPicker] removeObserver:self forKeyPath:NSStringFromSelector(@selector(pickedColor))];
                }
                @catch(NSException * __unused exception) {}
            }
            else {
                RCSlideOptions *options = [[self currentSlide] options];
                [[self foregroundPicker] setPickedColor:options.foregroundColor];
                [[self backgroundPicker] setPickedColor:options.backgroundColor];
                [[self foregroundPicker] addObserver:self forKeyPath:NSStringFromSelector(@selector(pickedColor)) options:NSKeyValueObservingOptionNew context:NULL];
                [[self backgroundPicker] addObserver:self forKeyPath:NSStringFromSelector(@selector(pickedColor)) options:NSKeyValueObservingOptionNew context:NULL];
            }
        }
    }
    else if([object isEqual:self.foregroundPicker] &&
        [keyPath isEqualToString:NSStringFromSelector(@selector(pickedColor))]) {
        [[[self currentSlide] options] setForegroundColor:self.foregroundPicker.pickedColor];
    }
    else if([object isEqual:self.backgroundPicker] &&
            [keyPath isEqualToString:NSStringFromSelector(@selector(pickedColor))]) {
        [[[self currentSlide] options] setBackgroundColor:self.backgroundPicker.pickedColor];
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
