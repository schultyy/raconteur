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

-(IBAction) openProject: (id) sender;

-(IBAction) addSlide: (id) sender;

-(IBAction) addExistingSlide: (id) sender;

-(IBAction) removeSelectedSlide: (id) sender;

-(IBAction) saveProject: (id) sender;

-(IBAction) saveProjectAs: (id) sender;

-(IBAction)exportSlides:(id)sender;

-(IBAction)startPresentation:(id)sender;

-(IBAction)nextSlide:(id)sender;

-(IBAction)previousSlide:(id)sender;

-(IBAction) editMasterSlide: (id) sender;

@end
