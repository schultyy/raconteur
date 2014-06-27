//
// Created by Jan Schulte on 26/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCPresentationWindowController.h"
#import "RCProject.h"
#import "RCSlideOptions.h"
#import "RCPagedPresentationBuilder.h"

@interface RCPresentationWindowController()
@property (readwrite, nonatomic, assign) RCProject *project;
@property (strong) RCPagedPresentationBuilder *presentationBuilder;
@end

@implementation RCPresentationWindowController

-(id)initWithProject:(RCProject *)project {
    self = [super initWithWindowNibName:@"RCPresentationWindow"];
    if(self) {
        [self setProject:project];
        [self setPresentationBuilder:[[RCPagedPresentationBuilder alloc] initWithProject:self.project]];
    }
    return self;
}

-(void) start {
    NSString *html = [[self presentationBuilder] firstSlide];

    [[[self webView] mainFrame] loadHTMLString:html baseURL:nil];
}

-(void) nextSlide {
    NSString *html = [[self presentationBuilder] nextSlide];
    if(!html) {
        return;
    }
    
    [[[self webView] mainFrame] loadHTMLString:html baseURL:nil];
}

-(void) previousSlide {
    NSString *html = [[self presentationBuilder] previousSlide];
    if(!html) {
        return;
    }
    
    [[[self webView] mainFrame] loadHTMLString:html baseURL:nil];
}
@end
