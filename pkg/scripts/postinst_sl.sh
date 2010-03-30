#!/bin/sh
# Cache system fonts
/opt/X11/bin/font_cache --force --system

[[ -f /etc/paths.d/XQuartz ]] && rm /etc/paths.d/XQuartz 
[[ -f /etc/manpaths.d/XQuartz ]] && rm /etc/manpaths.d/XQuartz 

exit 0
