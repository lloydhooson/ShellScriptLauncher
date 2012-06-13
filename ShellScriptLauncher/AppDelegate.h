//
//  AppDelegate.h
//  ShellScriptLauncher
//
//  Created by Lloyd Hooson on 03/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MenubarController.h"


@interface AppDelegate : NSObject <NSApplicationDelegate , NSMenuDelegate> {
    
@public 
    IBOutlet NSMenu *statusMenu;
    
@private
    MenubarController *_menubarController;
    BOOL showHideFilesAndFolders;
    BOOL enableDisAbleTimemachineSnapshotUtil;
    NSString *nameTest;

}

@property (nonatomic, retain) MenubarController *menubarController;

- (BOOL) runScriptCommand:(NSString *)scriptCommand;
- (void) runScript:(NSString*)scriptName;
- (void) DeHighlight;

- (IBAction)leftClickAction:(id)sender;
- (IBAction)toggleRightClickPanel:(id)sender;
- (IBAction)noActionRequired:(id)sender;


- (IBAction)doSomething:(id)sender;
- (IBAction)ShowHideFoldersandFiles:(id)sender;
- (IBAction)tidyHTML:(id)sender;
- (IBAction)enableDisableTimemachineSnapShot:(id)sender;

@end
