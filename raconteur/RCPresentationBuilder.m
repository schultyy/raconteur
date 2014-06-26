//
// Created by Jan Schulte on 25/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCPresentationBuilder.h"
#import "MMMarkdown.h"
#import "RCProject.h"
#import "Underscore.h"
#import "RCSlide.h"

@interface RCPresentationBuilder()
@property (assign) RCProject *project;
@end

@implementation RCPresentationBuilder

-(id)initWithProject:(RCProject *)project {
    self = [super init];
    if(self) {
        [self setProject:project];
    }
    return self;
}

-(NSString *) embedd: (NSString *) content {

    NSString *path = [[NSBundle mainBundle] pathForResource:@"basic-template" ofType:@"html"];
    NSString *template = [NSString stringWithContentsOfFile:path
                                                   encoding:NSUTF8StringEncoding
                                                      error:nil];
    return [template stringByReplacingOccurrencesOfString:@"{{CONTENT}}" withString:content];
}

-(NSString *) processSlides {
    NSArray *htmlSlides = Underscore.arrayMap([[self project] slides], ^NSString *(RCSlide *slide) {
        NSError  *error;
        NSString *html = [MMMarkdown HTMLStringWithMarkdown:slide.text
                                     error:&error];
        if(error) {
            return nil;
        }
        return html;
    });
    return [self embedd:[htmlSlides componentsJoinedByString:@"\n"]];
}

@end
