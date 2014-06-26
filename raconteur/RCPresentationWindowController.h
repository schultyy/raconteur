//
// Created by Jan Schulte on 26/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@class RCProject;

@interface RCPresentationWindowController : NSWindowController

@property IBOutlet WebView *webView;

@property (readonly, nonatomic, assign) RCProject *project;

-(id) initWithProject: (RCProject *) project;

-(void) start;

@end
