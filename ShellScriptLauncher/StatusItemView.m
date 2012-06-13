//
//  StatusItemView.m
//  ShellScriptLauncher
//
//  Created by Lloyd Hooson on 03/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StatusItemView.h"
 
@implementation StatusItemView

@synthesize statusItem = _statusItem;
@synthesize image = _image;
@synthesize alternateImage = _alternateImage;
@synthesize isHighlighted = _isHighlighted;
@synthesize leftaction = _leftaction;
@synthesize target = _target;
@synthesize rightAction = _rightAction;
@synthesize noAction = _noAction;

#pragma mark -

- (id)initWithStatusItem:(NSStatusItem *)statusItem
{
    CGFloat itemWidth = [statusItem length];
    CGFloat itemHeight = [[NSStatusBar systemStatusBar] thickness];
    NSRect itemRect = NSMakeRect(0.0, 0.0, itemWidth, itemHeight);
    self = [super initWithFrame:itemRect];
    
    if (self != nil)
    {
        _statusItem = [statusItem retain];
        _statusItem.view = self;
    }
    
    return self;
}

- (void)dealloc
{
    [_statusItem release];
    [_image release];
    [_alternateImage release];
    
    [super dealloc];
}

#pragma mark -

- (void)drawRect:(NSRect)dirtyRect
{
	[self.statusItem drawStatusBarBackgroundInRect:dirtyRect withHighlight:self.isHighlighted];
    NSImage *icon = self.isHighlighted ? self.alternateImage : self.image;
    NSSize iconSize = [icon size];
    NSRect bounds = self.bounds;
    CGFloat iconX = roundf((NSWidth(bounds) - iconSize.width) / 2);
    CGFloat iconY = roundf((NSHeight(bounds) - iconSize.height) / 2);
    NSPoint iconPoint = NSMakePoint(iconX, iconY);
    [icon compositeToPoint:iconPoint operation:NSCompositeSourceOver];
}

#pragma mark -
#pragma mark Mouse tracking

- (void)mouseDown:(NSEvent *)theEvent
{
    [NSApp sendAction:self.leftaction to:self.target from:self];
}


- (void)mouseUp:(NSEvent *)event {
    
    if([event modifierFlags] & NSControlKeyMask) {
        [NSApp sendAction:self.rightAction to:self.target from:self];
    }
    else if([event modifierFlags] & NSCommandKeyMask) {
        [NSApp sendAction:self.rightAction to:self.target from:self];  
    }
    else {
        [NSApp sendAction:self.noAction to:self.target from:self];
        
    }
}

- (void)rightMouseUp:(NSEvent *)event {
    [NSApp sendAction:self.rightAction to:self.target from:self];
}


- (void)rightMouseDown:(NSEvent *)event {
    [NSApp sendAction:self.rightAction to:self.target from:self];
}

 

#pragma mark -
#pragma mark Accessors

- (void)setHighlighted:(BOOL)newFlag
{
    if (_isHighlighted == newFlag) return;
    _isHighlighted = newFlag;
    [self setNeedsDisplay:YES];
}



@end
