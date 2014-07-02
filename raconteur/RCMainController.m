//
// Created by Jan Schulte on 23/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCMainController.h"
#import "RCProject.h"
#import "RCSlideEditorViewController.h"
#import "RCSlide.h"
#import "RCProjectSerializer.h"
#import "RCPresentationWindowController.h"
#import "RCPresentationBuilder.h"
#import "RCMasterSlideWindowController.h"

#define BasicTableViewDragAndDropDataType @"BasicTableViewDragAndDropDataType"

@interface RCMainController()<NSWindowDelegate>
@property (readwrite, nonatomic, strong) RCProject *project;
@property (readwrite, nonatomic, strong) RCSlideEditorViewController *slideEditorController;
@property (readwrite, nonatomic, strong) RCPresentationWindowController *presentationController;
@property (readwrite, nonatomic, strong) RCMasterSlideWindowController *masterSlideController;
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
        [self setMasterSlideController:[[RCMasterSlideWindowController alloc] init]];
        [self setSelectionIndex:[[NSIndexSet alloc] init]];
    }
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];

    [[self detailView] setContentView:self.slideEditorController.view];
    [[self slideList] setTarget:self];
    [[self slideList] setDoubleAction:@selector(addSlide)];

    [[self slideList] setDataSource:self];
    [[self slideList] registerForDraggedTypes: [NSArray arrayWithObject:BasicTableViewDragAndDropDataType]];

    [self addObserver:self
           forKeyPath:NSStringFromSelector(@selector(selectionIndex))
              options:NSKeyValueObservingOptionNew
              context:NULL];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:NSStringFromSelector(@selector(selectionIndex))]) {
        [[self slideEditorController] setCurrentSlide: self.selectedSlide];
    }
}

-(RCSlide *) selectedSlide {
    NSUInteger selectedIndex = [[self selectionIndex] firstIndex];

    if(selectedIndex == NSNotFound) {
        return nil;
    }

    return [[[self slideArrayController] arrangedObjects] objectAtIndex: selectedIndex];
}

#pragma mark - Menu actions

-(void) addSlide {
    RCSlide *slide = [[self project] addSlide];
    NSIndexSet *newIndex = [[NSIndexSet alloc] initWithIndex:self.project.slides.count - 1];
    [self setSelectionIndex:newIndex];
    [[self slideEditorController] setCurrentSlide: slide];
}

-(void) removeSelectedSlide {
    if(self.selectedSlide) {
        [[self project] removeSlide: self.selectedSlide];
    }
}

-(void) saveProject {
    if([[[self project] filePath] length] == 0) {
        [self saveProjectAs];
    }
    else {
        [RCProjectSerializer serializeObject:self.project toFile: self.project.filePath];
    }
}

-(void) saveProjectAs {
    NSSavePanel *savePanel = [NSSavePanel savePanel];
    [savePanel setCanCreateDirectories:YES];

    [savePanel setAllowedFileTypes: [NSArray arrayWithObject:@"json"]];


    if([savePanel runModal] == NSOKButton) {
        [RCProjectSerializer serializeObject:self.project toFile: savePanel.URL.path];
        [[self project] setFilePath:savePanel.URL.path];
    }
}

-(void) exportSlides {
    //Sucess
    NSSavePanel *savePanel = [NSSavePanel savePanel];
    [savePanel setCanCreateDirectories:YES];
    [savePanel setPrompt:@"Export"];
    [savePanel setAllowedFileTypes:[NSArray arrayWithObject: @"html"]];

    if([savePanel runModal] == NSOKButton) {
        RCPresentationBuilder *builder = [[RCPresentationBuilder alloc] initWithProject:self.project];
        [builder export:savePanel.URL.path];
    }
}

-(void) startPresentation{
    [self setPresentationController:[[RCPresentationWindowController alloc] initWithProject:self.project]];
    [[self presentationController] showWindow:self];
    [[[self presentationController] window] setDelegate:self];
    [[self presentationController] start];
}

-(void) editMasterSlide {
    [NSApp beginSheet:self.masterSlideController.window
       modalForWindow:self.window
        modalDelegate:self
       didEndSelector:@selector(editMasterSlideDidEndSheet:returnCode:contextInfo:)
          contextInfo:NULL];
}

- (void) editMasterSlideDidEndSheet:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo {
}

#pragma mark - NSTableViewDataSource

-(BOOL)tableView:(NSTableView *)tableView acceptDrop:(id <NSDraggingInfo>)info row:(NSInteger)row dropOperation:(NSTableViewDropOperation)dropOperation {
    NSData *data = [[info draggingPasteboard] dataForType:BasicTableViewDragAndDropDataType];
    NSArray *slides = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    RCSlide *slide = [slides objectAtIndex:0];
    if(row >= self.project.slides.count) {
        [[[self project] slides] addObject:slide];
    }
    else {
        [[[self project] slides] insertObject:slide atIndex:(NSUInteger) row];
    }
    [[self slideArrayController] setContent:self.project.slides];
    return YES;
}

-(NSDragOperation)tableView:(NSTableView *)tableView validateDrop:(id <NSDraggingInfo>)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)dropOperation {
    return NSDragOperationMove;
}

-(BOOL)tableView:(NSTableView *)tableView writeRowsWithIndexes:(NSIndexSet *)rowIndexes toPasteboard:(NSPasteboard *)pboard {
    if([rowIndexes firstIndex] >= 0 && [rowIndexes firstIndex] < self.project.slides.count) {
        [pboard declareTypes:[NSArray arrayWithObject:BasicTableViewDragAndDropDataType] owner:self];

        [[self slideEditorController] setCurrentSlide:nil];
        NSMutableArray *rows = [NSMutableArray array];
        NSArray * selectedObjects = [[[self project] slides] objectsAtIndexes:rowIndexes];

        for (RCSlide * o in selectedObjects) {
            [rows addObject: o];
            [[[self project] slides] removeObject:o];
        }
        NSData * encodedObjects = [NSKeyedArchiver archivedDataWithRootObject:rows];
        [pboard setData:encodedObjects forType:BasicTableViewDragAndDropDataType];

        return YES;
    }
    return NO;
}

-(void)windowWillClose:(NSNotification *)notification {
    [self setPresentationController:nil];
}

@end
