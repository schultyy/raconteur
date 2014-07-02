//
// Created by Jan Schulte on 27/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCPagedPresentationBuilder.h"
#import "RCSlide.h"
#import "MMMarkdown.h"
#import "RCSlideOptions.h"
#import "RCProject.h"
#import "RCProject.h"
#import "RCBuilderBase.h"

@interface RCPagedPresentationBuilder(){
    NSUInteger currentPage;
}

@end

@implementation RCPagedPresentationBuilder

-(id)initWithProject:(RCProject *)project {
    self = [super initWithProject:project];
    if(self) {
        currentPage = 0;
    }
    return self;
}

-(NSString *) slideWithTemplate: (RCSlide *) slide {
    return [[self template] stringByReplacingOccurrencesOfString: @"{{CONTENT}}" withString: [self renderSlide:slide]];
}

#pragma mark - Slide navigation

-(NSString *)previousSlide {
    if(currentPage > 0) {
        RCSlide *slide = [[[self project] slides] objectAtIndex:--currentPage];
        return [self slideWithTemplate:slide];
    }
    return nil;
}

-(NSString *)nextSlide {
    if(currentPage + 1 < self.project.slides.count) {
        RCSlide *slide = [[[self project] slides] objectAtIndex:++currentPage];
        return [self slideWithTemplate:slide];
    }
    return nil;
}

-(NSString *) firstSlide {
    RCSlide *slide = [[[self project] slides] objectAtIndex:0];
    return [self slideWithTemplate:slide];
}

@end
