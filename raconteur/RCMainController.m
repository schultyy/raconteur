//
// Created by Jan Schulte on 23/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "RCMainController.h"
#import "RCProject.h"
#import "RCSlideEditorViewController.h"
#import "RCSlide.h"
#import "RCProjectSerializer.h"
#import "RCPresentationBuilder.h"
#import "RCExportWindowController.h"
#import "RCPresentationWindowController.h"

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
    [[self detailView] setContentView:self.slideEditorController.view];
    [[self slideList] setTarget:self];
    [[self slideList] setDoubleAction:@selector(slideListDoubleClick:)];
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

-(void) exportSlides {
    [self setExportWindowController:[[RCExportWindowController alloc] init]];

    [NSApp beginSheet:self.exportWindowController.window
       modalForWindow:self.window
        modalDelegate:self
       didEndSelector:@selector(didEndSheet:returnCode:contextInfo:)
          contextInfo:NULL];
}

-(void) startPresentation{
    [self setPresentationController:[[RCPresentationWindowController alloc] initWithProject:self.project]];
    [[self presentationController] showWindow:self];
    [[self presentationController] start];
}

#pragma mark - ExportSheet delegate methods

- (void)didEndSheet:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo {
    if(returnCode == 1) {
        //Sucess
        NSSavePanel *savePanel = [NSSavePanel savePanel];
        [savePanel setCanCreateDirectories:YES];
        [savePanel setPrompt:@"Export"];
        [savePanel setAllowedFileTypes:[NSArray arrayWithObject: @"html"]];

        if([savePanel runModal] == NSOKButton) {
            RCPresentationBuilder *builder = [[RCPresentationBuilder alloc] initWithProject:self.project];
            NSString *html = [builder processAllSlides:self.exportWindowController.exportOptions];
            [html writeToFile:savePanel.URL.path
                   atomically:NO
                     encoding:NSUTF8StringEncoding
                        error:nil];
        }
    }
}

@end
