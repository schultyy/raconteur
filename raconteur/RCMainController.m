//
// Created by Jan Schulte on 23/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCMainController.h"
#import "RCProject.h"
#import "RCSlideEditorViewController.h"
#import "RCSlide.h"
#import "RCProjectSerializer.h"
#import "RCExportWindowController.h"
#import "RCPresentationWindowController.h"
#import "RCPagedPresentationBuilder.h"

#define BasicTableViewDragAndDropDataType @"BasicTableViewDragAndDropDataType"

@interface RCMainController()
@property (readwrite, nonatomic, strong) RCProject *project;
@property (readwrite, nonatomic, strong) RCSlideEditorViewController *slideEditorController;
@property (readwrite, nonatomic, strong) RCPresentationWindowController *presentationController;
@property (readwrite, nonatomic, strong) RCExportWindowController *exportWindowController;
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
    [super awakeFromNib];

    [[self detailView] setContentView:self.slideEditorController.view];
    [[self slideList] setTarget:self];
    [[self slideList] setDoubleAction:@selector(slideListDoubleClick:)];

    [[self slideList] setDataSource:self];
    [[self slideList] registerForDraggedTypes: [NSArray arrayWithObject:BasicTableViewDragAndDropDataType]];
}

-(RCSlide *) selectedSlide {
    NSUInteger selectedIndex = [[self selectionIndex] firstIndex];

    if(selectedIndex == NSNotFound) {
        return nil;
    }

    return [[[self slideArrayController] arrangedObjects] objectAtIndex: selectedIndex];
}

-(void) slideListDoubleClick: (id) sender {
    [[self slideEditorController] setCurrentSlide: self.selectedSlide];
}

#pragma mark - Menu actions

-(void) addSlide {
    [[self project] addSlide];
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
//    [self setExportWindowController:[[RCExportWindowController alloc] init]];
//
//    [NSApp beginSheet:self.exportWindowController.window
//       modalForWindow:self.window
//        modalDelegate:self
//       didEndSelector:@selector(didEndSheet:returnCode:contextInfo:)
//          contextInfo:NULL];
}

-(void) startPresentation{
    [self setPresentationController:[[RCPresentationWindowController alloc] initWithProject:self.project]];
    [[self presentationController] showWindow:self];
    [[self presentationController] start];
}

#pragma mark - ExportSheet delegate methods

- (void)didEndSheet:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo {
//    if(returnCode == 1) {
//        //Sucess
//        NSSavePanel *savePanel = [NSSavePanel savePanel];
//        [savePanel setCanCreateDirectories:YES];
//        [savePanel setPrompt:@"Export"];
//        [savePanel setAllowedFileTypes:[NSArray arrayWithObject: @"html"]];
//
//        if([savePanel runModal] == NSOKButton) {
//            RCPresentationBuilder *builder = [[RCPresentationBuilder alloc] initWithProject:self.project];
//            NSString *html = [builder processAllSlides:self.exportWindowController.exportOptions];
//            [html writeToFile:savePanel.URL.path
//                   atomically:NO
//                     encoding:NSUTF8StringEncoding
//                        error:nil];
//        }
//    }
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


@end
