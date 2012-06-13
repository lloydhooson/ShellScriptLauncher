//
//  AppDelegate.m
//  ShellScriptLauncher
//
//  Created by Lloyd Hooson on 03/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate


@synthesize menubarController = _menubarController;


#pragma mark -

- (void)dealloc
{
    [super dealloc];
}

#pragma mark -NSApplicationDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Install icon into the menu bar
    [self.menubarController = [[MenubarController alloc] init] release];
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender
{
    // Explicitly remove the icon from the menu bar
    self.menubarController = nil;
    
    return NSTerminateNow;
}

@end
