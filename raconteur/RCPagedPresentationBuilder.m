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

@interface RCPagedPresentationBuilder(){
    NSUInteger currentPage;
}

@property (nonatomic, assign) RCProject *project;

@end

@implementation RCPagedPresentationBuilder

-(id)initWithProject:(RCProject *)project {
    self = [super init];
    if(self) {
        currentPage = 0;
        [self setProject:project];
    }
    return self;
}

#pragma mark - Slide navigation

-(NSString *)previousSlide {
    if(currentPage > 0) {
        RCSlide *slide = [[[self project] slides] objectAtIndex:--currentPage];
        return [slide preview];
    }
    return nil;
}

-(NSString *)nextSlide {
    if(currentPage + 1 < self.project.slides.count) {
        RCSlide *slide = [[[self project] slides] objectAtIndex:++currentPage];
        return [slide preview];
    }
    return nil;
}

-(NSString *) firstSlide {
    RCSlide *slide = [[[self project] slides] objectAtIndex:0];
    return [slide preview];
}

@end
