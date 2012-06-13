//
//  StatusItemView.h
//  ShellScriptLauncher
//
//  Created by Lloyd Hooson on 03/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface StatusItemView : NSView   {

    NSImage *_image;
    NSImage *_alternateImage;
    BOOL _isHighlighted;
    SEL _leftaction, _rightAction, _noAction;
    id _target;
    
}

- (id)initWithStatusItem:(NSStatusItem *)statusItem;


@property (nonatomic, readonly) NSStatusItem *statusItem;
@property (nonatomic, retain) NSImage *image;
@property (nonatomic, retain) NSImage *alternateImage;
@property (nonatomic, setter = setHighlighted:) BOOL isHighlighted;
@property (nonatomic) SEL leftaction, rightAction, noAction;
@property (nonatomic, assign) id target;

@end