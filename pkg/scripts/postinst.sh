#!/bin/sh
# Load the privileged_startx daemon
/bin/launchctl load -w /System/Library/LaunchDaemons/org.x.privileged_startx.plist
exit 0
