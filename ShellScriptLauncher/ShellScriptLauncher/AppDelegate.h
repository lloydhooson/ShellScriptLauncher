//
//  AppDelegate.h
//  ShellScriptLauncher
//
//  Created by Lloyd Hooson on 03/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MenubarController.h"


@interface AppDelegate : NSObject <NSApplicationDelegate> {

@private
    MenubarController *_menubarController;

}

@property (nonatomic, retain) MenubarController *menubarController;

@end
