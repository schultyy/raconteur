//
// Created by Jan Schulte on 29/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RCFrontMatterParser : NSObject {
    NSString *fileContent;
    NSUInteger current;
    unichar currentChar;
    BOOL allowDash;
    BOOL allowColon;
}

-(id) initWithFilepath: (NSString *) filePath;

-(NSDictionary *) parse:(NSError **)error;

@end
