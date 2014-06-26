//
// Created by Jan Schulte on 26/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCPresentationWindowController.h"
#import "RCProject.h"
#import "RCPresentationBuilder.h"
#import "RCExportOptions.h"

@interface RCPresentationWindowController()
@property (readwrite, nonatomic, assign) RCProject *project;
@end

@implementation RCPresentationWindowController

-(id)initWithProject:(RCProject *)project {
    self = [super initWithWindowNibName:@"RCPresentationWindow"];
    if(self) {
        [self setProject:project];
    }
    return self;
}

-(void) start {
    RCPresentationBuilder *builder = [[RCPresentationBuilder alloc] initWithProject:self.project];
    NSString *html = [builder processAllSlides:[RCExportOptions defaultOptions]];
    //[[tempWebView mainFrame] loadHTMLString:htmlContent baseURL:url];
    [[[self webView] mainFrame] loadHTMLString:html baseURL:nil];
}

@end
