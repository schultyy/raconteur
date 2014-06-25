//
// Created by Jan Schulte on 23/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RCProject;
@class RCSlideEditorViewController;


@interface RCMainController : NSWindowController

@property (readonly, nonatomic, strong) RCProject *project;

@property (strong) NSIndexSet *selectionIndex;

@property (readonly, nonatomic, strong) RCSlideEditorViewController *slideEditorController;

@property IBOutlet NSBox *detailView;

@property IBOutlet NSTableView *slideList;

@property IBOutlet NSArrayController *slideArrayController;

-(id) initWithProject: (RCProject *) project;

-(void) addSlide;

-(void) removeSelectedSlide;

-(void) saveProject;

-(void) saveProjectAs;

-(void) exportSlides;

@end
