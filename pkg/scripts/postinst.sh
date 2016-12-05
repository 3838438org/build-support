#!/bin/sh

[[ -e /etc/sshd_config ]] && SSHD_CONFIG=/etc/sshd_config
[[ -e /etc/ssh/sshd_config ]] && SSHD_CONFIG=/etc/ssh/sshd_config

[[ -e /etc/ssh_config ]] && SSH_CONFIG=/etc/ssh_config
[[ -e /etc/ssh/ssh_config ]] && SSH_CONFIG=/etc/ssh/ssh_config

if [[ -n "${SSHD_CONFIG}" ]] ; then
    if ! cat ${SSHD_CONFIG} | grep -v '^#' | egrep -q '^(Match|XAuthLocation)' ; then
    {
        echo ""
        echo "# XAuthLocation added by XQuartz (https://www.xquartz.org)"
        echo "XAuthLocation /opt/X11/bin/xauth"
    } >> ${SSHD_CONFIG}
    fi
fi

if [[ -n "${SSH_CONFIG}" ]] ; then
    if ! cat ${SSH_CONFIG} | grep -v '^#' | grep -q 'XAuthLocation' ; then
    {
        echo ""
        echo "# XAuthLocation added by XQuartz (https://www.xquartz.org)"
        echo "Host *"
        echo "    XAuthLocation /opt/X11/bin/xauth"
    } >> ${SSH_CONFIG}
    fi
fi

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

# Setup /usr/X11* symlinks
[[ -x /usr/libexec/x11-select ]] && /usr/libexec/x11-select /opt/X11
[[ -e /usr/X11 ]] || ln -s /opt/X11 /usr/X11
[[ -e /usr/X11R6 ]] || ln -s /opt/X11 /usr/X11R6

if [[ -z "${COMMAND_LINE_INSTALL}" && -e /tmp/.xquartz_first_time ]] ; then
    /usr/bin/osascript <<EOF
        tell application "System Events"
            activate
            display dialog "You will need to log out and log back in to make XQuartz your default X11 server." buttons {"OK"}
        end tell
EOF
rm /tmp/.xquartz_first_time
fi

exit 0
