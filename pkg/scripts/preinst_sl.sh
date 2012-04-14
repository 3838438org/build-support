#!/bin/sh

[[ -e /Library/LaunchDaemons/org.macosforge.xquartz.privileged_startx.plist ]] || touch /tmp/.xquartz_first_time

exit 0
