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
    
    showHideFilesAndFolders = NO;
    enableDisAbleTimemachineSnapshotUtil = YES;
    
    //make sure the callbacks for the menu are working
    [statusMenu setDelegate:self];
    

}


- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender
{
    //hide the files back to MAC OSX defualt 
    if(showHideFilesAndFolders){
        [self runScript: @"HideHiddenFiles"];
    }
    
    //if the timemachine snapshot is on we need to turn it off on Quit! 
    if(enableDisAbleTimemachineSnapshotUtil == NO)
    {
        //turn off the timemachine snapshot util
       [self runScriptCommand: @"do shell script \"tmutil disablelocal > /tmp/me\" with administrator privileges"""];
    }
    
    // Explicitly remove the icon from the menu bar
    self.menubarController = nil;
    
    return NSTerminateNow;
}




#pragma mark -Actions

- (IBAction)leftClickAction:(id)sender
{
    //Highlight the Icon for USER feedback
    self.menubarController.hasActiveIcon = YES;
    
    //call the script for eject all
    [self runScript: @"EjectAll"];

}

- (IBAction)toggleRightClickPanel:(id)sender
{
    //activate the highlight
    self.menubarController.hasActiveIcon = YES;
    //make the window apper
    [self.menubarController.statusItem popUpStatusItemMenu:statusMenu ];
    [self.menubarController.statusItem setMenu:statusMenu ];
    [self.menubarController.statusItem.menu setDelegate: statusMenu.delegate];
    
    
}

-(IBAction) noActionRequired:(id)sender
{
    //DE- HIGHTLIGHT the icon to give usr feedback they they o slecting the control anymore 
    [self DeHighlight];
    
}
-(void) DeHighlight
{
    //DE- HIGHTLIGHT the icon to give usr feedback 
    self.menubarController.hasActiveIcon = NO;
    
}


#pragma mark - Rightclick Change Name

- (BOOL)validateMenuItem:(NSMenuItem *)item {
    
    //SHOW HIDE
   if ([item action] == @selector(ShowHideFoldersandFiles:)) {
       //NSLog(@"ShowHideFoldersandFiles");
       if (showHideFilesAndFolders) {
           [item setTitle:NSLocalizedString(@"Hide Hidden Files",nil)];
       } 
       else {
           [item setTitle:NSLocalizedString(@"Show Hidden Files",nil)];
       }
       
   } 
   else if ([item action] == @selector(enableDisableTimemachineSnapShot:)) 
   {
        //NSLog(@"enableDisableTimemachineSnapShot");
        if (enableDisAbleTimemachineSnapshotUtil) {
            [item setTitle:NSLocalizedString(@"Enable Time Machine",nil)];
        } 
        else {
            [item setTitle:NSLocalizedString(@"Disable Time Machine",nil)];
        }
   }
    return YES;
}

- (void)menuDidClose:(NSMenu *)menu {

    [self DeHighlight];
    
}


#pragma mark - Rightclick Members


- (IBAction)doSomething:(id)sender 
{
    [self DeHighlight];

}


- (IBAction)ShowHideFoldersandFiles:(id)sender 
{
    if(showHideFilesAndFolders)
    {
        showHideFilesAndFolders = NO;
        //call the script for eject all
        [self runScript: @"HideHiddenFiles"];
    }
    else {
        showHideFilesAndFolders  = YES;
        //call the script for eject all
        [self runScript: @"ShowHiddenFiles"];
        
    }
    //dehighlight the status bar app
    [self DeHighlight];
}


- (IBAction)tidyHTML:(id)sender 
{
    [self DeHighlight];
    [self runScript: @"TidyHTML"];
}


- (IBAction)enableDisableTimemachineSnapShot:(id)sender 
{
    [self DeHighlight];
    if(enableDisAbleTimemachineSnapshotUtil)
    {
        if ([self runScriptCommand: @"do shell script \"tmutil enablelocal > /tmp/me\" with administrator privileges"""]) {
            enableDisAbleTimemachineSnapshotUtil = NO;
            
        }
    }
    else {
        if ([self runScriptCommand: @"do shell script \"tmutil disablelocal > /tmp/me\" with administrator privileges"""]) {
            enableDisAbleTimemachineSnapshotUtil = YES;        
        }
    }
}


#pragma mark - Functions

-(BOOL) runScriptCommand:(NSString *)scriptCommand{
    
    NSDictionary *error = [NSDictionary new]; 
    NSString *script =  scriptCommand ; 
    NSAppleScript *appleScript = [[NSAppleScript new] initWithSource:script]; 
    
    if ([appleScript executeAndReturnError:&error]) {
        return YES; 
    } else {
        return NO;
    }
    
    //never should get here
    return NO;
}

//Run Shell Scripts
//------------------------------------------------------
-(void) runScript:(NSString*)scriptName
{
    NSTask *task;
    task = [[NSTask alloc] init];
    [task setLaunchPath: @"/bin/sh/"]; //path for the SH in terminal
    NSString *pathtoScript = [[NSBundle mainBundle] pathForResource:scriptName ofType:@"sh" inDirectory:@"Scripts/"];
    //NSLog(@"shell script path: %@",pathtoScript);
    NSArray *arguments;
    arguments = [NSArray arrayWithObjects:pathtoScript, nil];
    [task setArguments: arguments];
    
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    //The magic line that keeps your log where it belongs
    [task setStandardInput:[NSPipe pipe]];
    
    NSFileHandle *file;
    file = [pipe fileHandleForReading];
    
    [task launch];
    
    NSData *data;
    data = [file readDataToEndOfFile];
    
    NSString *string;
    string = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
    //NSLog (@"script returned:\n%@", string);    
}
//------------------------------------------------------

@end
