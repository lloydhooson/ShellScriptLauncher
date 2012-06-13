#!/bin/sh

#  HideHiddenFiles.sh
#  Shellscript lanuncher
#
#  Created by Lloyd Hooson on 03/06/2012.
#  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
# 

#echo "SH SCRIPT - Start HideHiddenFiles.sh"

defaults write com.apple.finder AppleShowAllFiles FALSE


osascript -e 'tell app "Finder" to quit'

sleep 1

open /System/Library/CoreServices/Finder.app

#echo "SH SCRIPT - END HideHiddenFiles.sh"