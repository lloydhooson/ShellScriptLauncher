#!/bin/sh

#  EjectAll.sh
#  EjectAll
#
#  Created by Lloyd Hooson on 03/06/2012.
#  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
# 

#echo "SH SCRIPT - Start EjectAll.sh"

osascript -e 'tell application "Finder" to eject (every disk whose ejectable is true)'

#echo "SH SCRIPT - END EjectAll.sh"