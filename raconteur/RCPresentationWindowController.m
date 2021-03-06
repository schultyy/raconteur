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

-(void)windowDidLoad {
    [[self webView] setPolicyDelegate:self];
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

#pragma mark - WebViewDelegate

- (void)webView:(WebView *)webView
        decidePolicyForNavigationAction:(NSDictionary *)actionInformation
        request:(NSURLRequest *)request
        frame:(WebFrame *)frame
        decisionListener:(id <WebPolicyDecisionListener>)listener
{
    NSString *host = [[request URL] host];
    if (host) {
        [[NSWorkspace sharedWorkspace] openURL:[request URL]];
    } else {
        [listener use];
    }
}

@end
