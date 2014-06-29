//
// Created by Jan Schulte on 25/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCSlideEditorViewController.h"
#import "RCConstants.h"
#import "RCSlide.h"
#import "RCSlideOptions.h"


@interface RCSlideEditorViewController()
@property (nonatomic, strong, readwrite) NSDictionary *alignmentOptions;
@end

@implementation RCSlideEditorViewController

-(id) init {
    self = [super initWithNibName:@"RCSlideEditorView" bundle:nil];
    if(self) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue: RCAlignmentCenterValue forKey:RCAlignmentCenterKey];
        [dict setValue: RCAlignmentLeftValue forKey:RCAlignmentLeftKey];
        [dict setValue: RCAlignmentRightValue forKey:RCAlignmentRightKey];

        [self setAlignmentOptions:dict];
    }
    return self;
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
