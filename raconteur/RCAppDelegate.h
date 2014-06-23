//
//  RCAppDelegate.h
//  raconteur
//
//  Created by Jan Schulte on 23/06/14.
//  Copyright (c) 2014 schultyy. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class RCMainController;

@interface RCAppDelegate : NSObject <NSApplicationDelegate>

@property (retain) RCMainController *mainController;

-(IBAction) newProject: (id) sender;

@end
