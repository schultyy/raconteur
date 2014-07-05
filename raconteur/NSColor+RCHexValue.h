//
// Created by Jan Schulte on 26/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
// Originally from https://github.com/faceleg/CINSColor-Hex
//

#import <Foundation/Foundation.h>

@interface NSColor (RCHexValue)
- (NSString *) hexColor;
+ (NSColor *) colorWithHex:(NSString *)hexColor;
@end
