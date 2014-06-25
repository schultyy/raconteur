//
// Created by Jan Schulte on 23/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCMainController.h"
#import "RCProject.h"
#import "RCSlideEditorViewController.h"
#import "RCSlide.h"

@interface RCMainController()
@property (readwrite, nonatomic, strong) RCProject *project;
@property (readwrite, nonatomic, strong) RCSlideEditorViewController *slideEditorController;
@end

@implementation RCMainController

-(id) init {
    self = [super initWithWindowNibName:@"RCMainWindow"];
    if(self) {
        [self setProject:[[RCProject alloc] init]];
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

    RCSlide *selectedSlide = [[[self slideArrayController] arrangedObjects] objectAtIndex: selectedIndex];

    [[self slideEditorController] setCurrentSlide:selectedSlide];
}

-(void) addSlide {
    [[self project] addSlide];
}

@end
