//
// Created by Jan Schulte on 23/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RCProject;
@class RCSlideEditorViewController;
@class RCPresentationWindowController;
@class RCMasterSlideWindowController;


@interface RCMainController : NSWindowController<NSTableViewDataSource>

@property (readonly, nonatomic, strong) RCProject *project;

@property (strong) NSIndexSet *selectionIndex;

@property (readonly, nonatomic, strong) RCPresentationWindowController *presentationController;

@property (readonly, nonatomic, strong) RCSlideEditorViewController *slideEditorController;

@property (readonly, nonatomic, strong) RCMasterSlideWindowController *masterSlideController;

@property IBOutlet NSBox *detailView;

@property IBOutlet NSTableView *slideList;

@property IBOutlet NSArrayController *slideArrayController;

-(id) initWithProject: (RCProject *) project;

-(void) addSlide;

-(void) addExistingSlide;

-(void) removeSelectedSlide;

-(void) editMasterSlide;

-(void) saveProject;

-(void) saveProjectAs;

-(void) exportSlides;

-(void) startPresentation;

@end
