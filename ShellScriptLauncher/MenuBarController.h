//
//  MenuBarController.h
//  ShellScriptLauncher
//
//  Created by Lloyd Hooson on 03/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define STATUS_ITEM_VIEW_WIDTH 24.0

#pragma mark -

@class StatusItemView;

@interface MenubarController : NSObject  {

    @public
        StatusItemView *singleStatusItemView;
        NSStatusItem *statusItem;
}


@property (nonatomic, assign) BOOL hasActiveIcon;
@property (nonatomic, assign) NSStatusItem *statusItem;
@property (nonatomic, readonly) StatusItemView *singleStatusItemView;


@end
