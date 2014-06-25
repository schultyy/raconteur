//
// Created by Jan Schulte on 23/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCMainController.h"
#import "RCProject.h"
#import "RCSlideEditorViewController.h"
#import "RCSlide.h"
#import "RCProjectSerializer.h"

@interface RCMainController()
@property (readwrite, nonatomic, strong) RCProject *project;
@property (readwrite, nonatomic, strong) RCSlideEditorViewController *slideEditorController;
@end

@implementation RCMainController

-(id) init {
    self = [self initWithProject:[[RCProject alloc] init]];
    return self;
}

-(id)initWithProject:(RCProject *)project {
    self = [super initWithWindowNibName:@"RCMainWindow"];
    if(self) {
        [self setProject: project];
        [self setSlideEditorController:[[RCSlideEditorViewController alloc] init]];
        [self setSelectionIndex:[[NSIndexSet alloc] init]];
    }
    return self;
}

-(void)awakeFromNib {
    [[self detailView] setContentView:self.slideEditorController.view];
    [[self slideList] setTarget:self];
    [[self slideList] setDoubleAction:@selector(slideListDoubleClick:)];
}

-(void) slideListDoubleClick: (id) sender {

    NSUInteger selectedIndex = [[self selectionIndex] firstIndex];

    if(selectedIndex == NSNotFound) {
        return;
    }

    RCSlide *selectedSlide = [[[self slideArrayController] arrangedObjects] objectAtIndex: selectedIndex];
    [[self slideEditorController] setCurrentSlide:selectedSlide];
}

-(void) addSlide {
    [[self project] addSlide];
}

-(void) saveProject {
    if([[[self project] directory] length] == 0) {
        [self saveProjectAs];
    }
    else {
        [RCProjectSerializer serializeObject:self.project toFile: self.project.directory];
    }
}

-(void) saveProjectAs {
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];
    [openDlg setCanChooseFiles:NO];
    [openDlg setCanChooseDirectories:YES];
    [openDlg setCanCreateDirectories:YES];
    [openDlg setPrompt:@"Select"];

    if([openDlg runModal] == NSOKButton) {
        [RCProjectSerializer serializeObject:self.project toFile:openDlg.URL.path];
        [[self project] setDirectory:openDlg.URL.path];
    }
}

@end
