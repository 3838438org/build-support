== IMPORTANT WARNING ==

If you move /Applications/Utilities/X11.app to another location, you must also update /System/Library/LaunchAgents/org.x.X11.plist !

== Disclaimer ==

This updates is not an official Apple releases. It is a convenient way for users to stay up to date with progress made in the open source community (in which Apple is participating). Official Apple releases will come from Apple (most likely through Apple Update). These updates will likely incorporate many of the changes made in our releases when and if Apple deems them appropriate.

== Changes in 2.1.1 ==
  * All changes in 2.1.0.1 plus:
  * Updated versions of packages:
    * app:
      * lndir git 2007.12.08
        * Properly ignore .DS_Store
      * xinit git 2007.12.10
        * Added package.
      * xterm 229
        * Replace antiquated version (207) with new version from upstream source.
        * Better UTF8 support among other bugfixes
    * proto:
      * x11proto git 2007.12.10
        * Changed references of __DARWIN__ to __APPLE__
  * fc-cache is run during post-install
  * Xquartz fixes from xorg-server-1.2-apple (Up to Xquartz-1.3.0-apple5)
    * Crash and stability fixes
    * Fixed startup to check preferences set in org.x.X11 instead of com.apple.X11
    * Multiple dock-icons bug fixed
    * XDMCP now works
    * Fixed Alt to work right with [wiki:KeyboardMapping#AltvsMode_switch ~/.Xmodmap]
    * Added workaround to support Fink until they update their packages
    * Small updates to Xquartz.man page (still needs a good edit, if you can help, please contact the xquartz-dev mailing list)

== Changes in 2.1.0.1 ==
  * All changes in 2.1.0 plus
  * Fixed package post-install to not error on machines without Xcode.

== Changes in 2.1.0 ==
  * New versions of packages from x.org:
    * app:
      * xfs 1.0.5
        * Fixes CVE-2007-4568
        * Fixes CVE-2007-4990
    * lib:
      * libX11 1.1.3
        * Fixes gtk and related crashes
    * proto:
      * damageproto 1.1.0
      * randrproto 1.2.1
  * Xquartz fixes from xorg-server-1.2-apple (Up to Xquartz-1.3.0-apple2)
    * xserver codebase updated from 1.2.0 to 1.3 branch
      * Fixes CVE-2007-1003
    * Fixed support for multiple displays (Xinerama)
    * Fixed yellow cursor issue on Intel machines
    * Fixed broken 3-button mouse emulation (i.e. option-click to paste)
    * Fixed missing support for Japanese JIS-layout keyboards
    * Improved compatibility with Spaces
    * Fixed the "Xquartz chews up 100% CPU when I run xauth / ssh / xdpyinfo" bug
    * Fixed support for customized Applications items
    * Fixed performance problems (slow drawing in Gimp, etc)
    * Fixed focus issues
    * Fixed stuck modifier key issues
    * Big fix to rootless code, which should eliminate some Xquartz crashes -- big thanks to Ken Thomases of CodeWeavers
    * Motion events are now given to background windows (like xeyes), like they were in Tiger
    * Fixed condition where quickly-exiting programs could cause Xquartz to chew CPU
    * "Fake RandR" support -- Tiger's X11.app didn't actually support the RandR extension (which allows display configuration to be changed while the server is running), but it did copy some code that does part of that. I'd like to actually implement support for RandR, but in the mean time I've copied the "fake" code into Xquartz. I haven't yet managed to scrounge up the hardware to test this, so I would appreciate hearing reports about whether this does or does not work.
    * Fixed spurious "Are you sure you want to quit?" message. This message is supposed to be suppressed if you do not have any X client apps running, but it could show up if you had started the server manually and not started any client (uninitialized variable). BTW, this warning can be disabled entirely with the command "defaults write org.x.X11 no_quit_alert true"
    * Adds support for horizontal scroll-wheels on mice
    * Fixed crashes in Damage code due to Rootless conflict
    * Fixed crashes in QueryFontReply
    * Fixed support for JIS (Japanees keyboards now work)
    * Redraw speed fix for apps such as the Gimp and rdesktop
    * Fixed a SafeAlphaComposite bug that caused some GTK apps to crash with a BadMatch error in 24-bit mode
    * Alt is now mapped to Mod_switch by default (back to Tiger's X11 default)
      * If you want it to be mapped to Alt_L and Alt_R, use ~/.Xmodmap
  * Include Xephyr, Xfake, Xvfb, and Xnest
  * Include missing man pages for Xquartz and other Xservers
  * Updated /usr/X11/include/X11/Xtranssock.c
    * Fix for incorrect processing of recycled launchd socket
  * Updated /A/U/X11.app/C/M/X11 from xorg-server-1.2-apple
    * Fixes proper env setting and command line arguments in app_to_run
  * Updated xauth to work with launchd sockets
  * Unicode support in xterm
  * xfs and fontconfig now include fonts from {,/System}/Library/Fonts
  * Added LaunchAgent (org.x.fontconfig) to run fc-cache on startup
