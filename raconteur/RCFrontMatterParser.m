//
// Created by Jan Schulte on 29/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCFrontMatterParser.h"


@implementation RCFrontMatterParser

-(id) initWithFilepath: (NSString *) filePath {
    self = [super init];
    if(self) {
        fileContent = [self extractFrontmatter: filePath];
        current = 0;
    }
    return self;
}

-(NSString *) extractFrontmatter: (NSString *) filePath {
    NSError *error = nil;
    NSString * content = [NSString stringWithContentsOfFile:filePath
                                                       encoding:NSUTF8StringEncoding
                                                          error:&error];
    if(error) {
        NSLog(@"ERROR WHILE READING FILE: %@", [error localizedDescription]);
        return nil;
    }

    NSRange limRange = [content rangeOfString:@"---" options:NSBackwardsSearch];
    NSRange frontMatterRange = NSMakeRange(0, limRange.location + 3);
    return [content substringWithRange:frontMatterRange];
}

-(NSDictionary *) parse:(NSError **)error {
    [self consume];

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    NSMutableString *buffer = [NSMutableString string];
    NSString *tempKey = nil;
    while([self canConsume]) {
        if(!allowDash && currentChar == '-') {
            if([self lookahead] == '\n') {
                [self consume];
                [self consume];
                allowDash = YES;
            }
            [self consume];
            continue;
        }
        if(!allowColon && currentChar == ':') {
            tempKey = [[NSString alloc] initWithString:buffer];
            [buffer setString:@""];
            allowColon = YES;
        }
        else if(currentChar == '\n') {
            NSString *tempValue = [[NSString alloc] initWithString: buffer];
            [buffer setString:@""];
            allowColon = NO;
            [dictionary setObject: [tempValue stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]]
                           forKey: [tempKey stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];

        }
        else {
            [buffer appendString: [NSString stringWithCharacters:&currentChar length:1]];
        }

        [self consume];
    }
    return dictionary;
}

-(unichar) lookahead {
    if(current + 1 < [fileContent length]) {
        return [fileContent characterAtIndex: current + 1];
    }
    return EOF;
}

-(void) consume {
    if([self canConsume]) {
        currentChar = [fileContent characterAtIndex:current++];
    }
}

-(BOOL) canConsume {
    return current < [fileContent length];
}

@end
