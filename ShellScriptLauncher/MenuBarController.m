//
//  MenuBarController.m
//  ShellScriptLauncher
//
//  Created by Lloyd Hooson on 03/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//



#import "MenubarController.h"
#import "StatusItemView.h"

@implementation MenubarController

@synthesize singleStatusItemView = _singleStatusItemView;
@synthesize statusItem = _statusItem;


#pragma mark -

- (id)init
{
    self = [super init];
    
    if (self != nil)
    {
        // Install status item into the menu bar
        statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:STATUS_ITEM_VIEW_WIDTH];
        
        //make the statusItem view 
        _singleStatusItemView = [[StatusItemView alloc] initWithStatusItem:statusItem];
        _singleStatusItemView.image = [NSImage imageNamed:@"Eject"];
        _singleStatusItemView.alternateImage = [NSImage imageNamed:@"Eject_Highlight"];
        
        //Set Call backs to the app delegate 
        _singleStatusItemView.leftaction = @selector(leftClickAction:); //this is the left click action call back  
        _singleStatusItemView.rightAction = @selector(toggleRightClickPanel:); //this activates the menu 
        _singleStatusItemView.noAction = @selector(noActionRequired:); //this is for reseting the icon 
        
    }
    
    return self;
}




- (void)dealloc
{
    [[NSStatusBar systemStatusBar] removeStatusItem:self.statusItem];
    [_singleStatusItemView release];
    [super dealloc];
}


#pragma mark -
#pragma mark Public accessors

- (NSStatusItem *)statusItem
{
    return self.singleStatusItemView.statusItem;
}

- (BOOL)hasActiveIcon
{
    return self.singleStatusItemView.isHighlighted;
}

- (void)setHasActiveIcon:(BOOL)flag
{
    self.singleStatusItemView.isHighlighted = flag;
}

#pragma mark -




@end
