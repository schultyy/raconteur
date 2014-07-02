//
// Created by Jan Schulte on 01/07/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCPresentationBuilder.h"
#import "RCProject.h"
#import "Underscore.h"
#import "RCSlide.h"


@implementation RCPresentationBuilder

-(NSString *) renderSlides {

    /*
    Slides cannot render their styles into the main style region.

    Option 1:
    Create custom class like `slide-01` and paste all related styles there

    Option 2:
    Write all styles on the corresponding div element for a slide like:
    <div style="<styles here>" class='slide'>
    </div>

     */
    NSString *slidesHtml = [Underscore.arrayMap(self.project.slides, ^(RCSlide *slide) {
        return [self renderSlide:slide];
    }) componentsJoinedByString:@"\n"];
    return [self.template stringByReplacingOccurrencesOfString:@"{{CONTENT}}" withString:slidesHtml];
}

@end
