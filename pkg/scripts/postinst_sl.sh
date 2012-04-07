#!/bin/sh

[[ -f /etc/paths.d/XQuartz ]] && rm /etc/paths.d/XQuartz 
[[ -f /etc/manpaths.d/XQuartz ]] && rm /etc/manpaths.d/XQuartz 

[[ -d /opt/X11/include/libpng12 ]] && rm -rf /opt/X11/include/libpng12
[[ -f /opt/X11/bin/libpng12-config ]] && rm /opt/X11/bin/libpng12-config

[[ -d /opt/X11/include/libpng14 ]] && rm -rf /opt/X11/include/libpng14
[[ -f /opt/X11/bin/libpng14-config ]] && rm /opt/X11/bin/libpng14-config

# Load the privileged_startx daemon
/bin/launchctl unload -w /Library/LaunchDaemons/org.macosforge.xquartz.privileged_startx.plist
/bin/launchctl load -w /Library/LaunchDaemons/org.macosforge.xquartz.privileged_startx.plist

# Cache system fonts
/opt/X11/bin/font_cache --force --system

# Hook for the system X11 if it wants to do something after XQuartz installs
[[ -x /usr/X11/libexec/xquartz_postinst.sh ]] && /usr/X11/libexec/xquartz_postinst.sh

[[ -e /usr/X11 ]] || ln -s /opt/X11 /usr/X11
[[ -e /usr/X11R6 ]] || ln -s /opt/X11 /usr/X11R6

/usr/bin/osascript <<EOF
        tell application "System Events"
            activate
            display dialog "If this is your first time installing XQuartz, you may want to log out and log back in to make it your default X11 server." buttons {"OK"}
        end tell
EOF

exit 0
