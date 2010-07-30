== Disclaimer ==

This updates is not an official Apple releases. It is a convenient way for users to stay up to date with progress made in the open source community (in which Apple is participating). Official Apple releases will come from Apple (most likely through Apple Update). These updates will likely incorporate many of the changes made in our releases when and if Apple deems them appropriate.

== Important Notices ==

=== OS-X Requirements ===

OS-X 10.5.8, 10.6.3, or later is required to install this package.

=== Mac OS-X Updates (Leopard Only) ===

You will need to re-install this package after future OS, and Security Updates delivered through Apple's Software Update.  Additionally, you should reinstall this package after installing XCode.

=== Default X11 Server (Snow Leopard Only) ===

If this is your first time installing XQuartz on Snow Leopard, you may wish to logout and log back in.  This will update your DISPLAY environment variable to point to XQuartz.app rather than X11.app.  If you would prefer to keep using X11.app as your default server (you can still launch XQuartz.app manually), you'll want to disable /Library/LaunchAgents/org.macosforge.xquartz.startx.plist using launchctl(1).

== Changes in 2.6.0 ==
  * All changes in 2.5.3 plus:
  * server:
    * xorg-server 1.9.0 plus other patches
      * Initial RandR support (#6)

== Changes in 2.5.3 ==
  * All changes in 2.5.2 plus:
  * apps:
      * xmore 1.0.2
      * xrandr 1.3.3
  * server:
    * xorg-server 1.8.2 plus other patches
      * Finish cleanup of /tmp on server quit (#421)
      * Address an indirect GLX regressions introduced in 2.5.1 (#423, #426)

== Changes in 2.5.2 ==
  * All changes in 2.5.1 plus:
  * libs:
      * freetype 2.4.1
        * CVE-2010-2497
        * CVE-2010-2498
        * CVE-2010-2499
        * CVE-2010-2500
        * CVE-2010-2519
        * CVE-2010-2520
      * libXau 1.0.6
      * mesa 7.8.2
  * server:
    * xorg-server 1.8.2 plus other patches
      * Fixed possible memory errors with cursor on ppc (#415)
      * Fixed a crash that can occur when changing to a higher resolution while in fullscreen

== Changes in 2.5.1 ==
  * All changes in 2.5.0 plus:
  * app:
    * luit
      * includes changes from Thomas Dickey's luit-20100601
    * quartz-wm 1.1.1
      * Fixed an issue with focus loss (#370)
      * Fixed an issue dragging windows to other spaces (#375)
    * sessreg 1.0.6
    * xinit
      * Fixed startx to be POSIX compliant for users of non-bash /bin/sh (#399)
    * xinput 1.5.2
    * xlsatoms 1.1.0
    * xlsclients 1.1.0
    * xlsfonts 1.0.3
    * xscope
      * Fixed a wedge by forcing TCP connections
    * xterm 261
  * lib:
    * cairo 1.8.10
    * libpng 1.2.44
      * CVE-2010-1205
    * libpng 1.4.3
      * CVE-2010-1205
    * libX11 1.3.4
      * Now built --with-xcb
    * libXcomposite 0.4.2
    * libXdamage 1.1.3
    * libXext 1.1.2
    * libXfixes 4.0.5
    * libXfont 1.4.2
    * libXrender 0.9.6
    * libxcb 1.6
      * Fixed $DISPLAY parsing (#390)
    * mesa 7.8.1
    * pixman 0.18.2
  * misc:
    * pkg-config 0.25
    * util-macros 1.10.0
    * xkeyboard-config 1.9
    * xorg-sgml-doctools 1.5
  * proto:
    * xproto 7.0.17
  * server:
    * xorg-server 1.8.2 plus other patches
      * Move to the 1.8 branch
      * Fixed shift-arrow keys sending math symbols in wine (#295)
      * Added a preference to toggle between Alt_L, Alt_R and Mode_switch (#374)
      * Fixed possible errors with GLX pixel formats  Bugzilla #27654
      * Worked around another instance of the graphics context clipping bug that was causing border render errors (#290)
      * Fix some misreported pointer coordinates with middle click and scrolling (#389)

== Changes in 2.5.0 ==
  * All changes in 2.4.0 plus:
  * app:
    * bdftopcf 1.0.2
    * bitmap 1.0.4
    * editres 1.0.4
    * font_cache
      * Ensure that only one instance of font_cache can run at a time
    * iceauth 1.0.3
    * listres 1.0.2
    * luit 1.0.5
    * makedepend 1.0.2
    * mkfontscale 1.0.7
    * mkfontdir 1.0.5
    * quartz-wm 1.1.0
      * Fixed a bug (#329) where windows could get lost behind the dock
    * sessreg 1.0.5
    * viewres 1.0.2
    * x11perf 1.5.1
    * xauth 1.0.4
    * xcalc 1.0.3
    * xclipboard 1.1.0
    * xclock 1.0.4
    * xcursorgen 1.0.3
    * xdm 1.1.9
    * xdpyinfo 1.1.0
    * xev 1.0.4
    * xgc 1.0.2
    * xhost 1.0.3
    * xinit 1.2.1
    * xinput 1.5.1
    * xkbcomp 1.1.1
    * xkbevd 1.1.0
    * xkbprint 1.0.2
    * xkbutils 1.0.2
    * xkill 1.0.2
    * xlogo 1.0.2
    * xlsatoms 1.0.2
    * xlsclients 1.0.2
    * xman 1.1.0
    * xmessage 1.0.3
    * xmodmap 1.0.4
    * xpr 1.0.3
    * xprop 1.1.0
    * xrandr 1.3.2
    * xrdb 1.0.6
    * xrefresh 1.0.3
    * xscope 1.2
    * xset 1.1.0
    * xsetroot 1.0.3
    * xterm 256
    * xvinfo 1.1.0
    * xwd 1.0.3
    * xwininfo 1.0.5
    * xwud 1.0.2
  * font:
    * encodings 1.0.3
    * font-adobe-100dpi 1.0.1
    * font-adobe-75dpi 1.0.1
    * font-adobe-utopia-100dpi 1.0.2
    * font-adobe-utopia-75dpi 1.0.2
    * font-adobe-utopia-type1 1.0.2
    * font-alias 1.0.2
    * font-arabic-misc 1.0.1
    * font-bh-100dpi 1.0.1
    * font-bh-75dpi 1.0.1
    * font-bh-lucidatypewriter-100dpi 1.0.1
    * font-bh-lucidatypewriter-75dpi 1.0.1
    * font-bh-ttf 1.0.1
    * font-bh-type1 1.0.1
    * font-bitstream-100dpi 1.0.1
    * font-bitstream-75dpi 1.0.1
    * font-bitstream-speedo 1.0.1
    * font-bitstream-type1 1.0.1
    * font-cronyx-cyrillic 1.0.1
    * font-cursor-misc 1.0.1
    * font-daewoo-misc 1.0.1
    * font-dec-misc 1.0.1
    * font-ibm-type1 1.0.1
    * font-isas-misc 1.0.1
    * font-jis-misc 1.0.1
    * font-micro-misc 1.0.1
    * font-misc-cyrillic 1.0.1
    * font-misc-ethiopic 1.0.1
    * font-misc-meltho 1.0.1
    * font-misc-misc 1.1.0
    * font-mutt-misc 1.0.1
    * font-schumacher-misc 1.1.0
    * font-screen-cyrillic 1.0.2
    * font-sony-misc 1.0.1
    * font-sun-misc 1.0.1
    * font-winitzki-cyrillic 1.0.1
    * font-xfree86-type1 1.0.2
  * lib:
    * fontconfig 2.7.3
    * freetype 2.3.12
    * libAppleWM 1.4.0
    * libICE 1.0.6
    * libdmx 1.1.0
    * libfontenc 1.0.5
    * libpng 1.2.43
    * libX11 1.3.3
    * libXau 1.0.5
    * libXaw 1.0.7
    * libxcb 1.5
    * libXcomposite 0.4.1
    * libXcursor 1.1.10
    * libXdamage 1.1.2
    * libXdmcp 1.0.3
    * libXext 1.1.1
    * libXfixes 4.0.4
    * libXfont 1.4.1
    * libXfontcache 1.0.5
    * libXft 2.1.14
    * libxkbfile 1.0.6
    * libXi 1.3
    * libXinerama 1.1
    * libXmu 1.0.5
    * libXplugin
      * Performance fix for ATI cards in DRI (SnowLeopard)
      * Fix drawing of the window growbox (SnowLeopard)
      * Help quartz-wm claim ownership of existing windows
      * Send notification of display change on display wake
    * libXpm 3.5.8
    * libXrender 0.9.5
    * libXres 1.0.4
    * libXv 1.0.5
    * libXvMC 1.0.5
    * libXScrnSaver 1.2.0
    * libXxf86dga 1.1.1
    * libXxf86misc 1.0.2
    * libXxf86vm 1.1.0
    * libXt 1.0.8
    * libXtst 1.1.0
    * mesa 7.7
      * libGL:
        * Rebased code off of mesa_7_7_branch
        * Fixed ABI for some extensions
    * pixman 0.16.6
    * xcb-util 0.3.6
    * xpyb 1.2
    * xtrans 1.2.5
  * misc:
    * font-util 1.1.1
    * util-macros 1.6.1
    * xbitmaps 1.1.0
    * xorg-sgml-doctools 1.3
    * xkeyboard-config 1.8
  * proto:
    * applewmproto 1.4.1
    * bigreqsproto 1.1.0
    * compositeproto 0.4.1
    * damageproto 1.2.0
    * dmxproto 2.3
    * dri2proto 2.3
    * evieext 1.1.0
    * fixesproto 4.1.1
    * fontcacheproto 0.1.3
    * fontsproto 2.1.0
    * glproto 1.4.11
    * inputproto 2.0
    * kbproto 1.0.4
    * randrproto 1.3.1
    * recordproto 1.14
    * resourceproto 1.1.0
    * scrnsaverproto 1.2.0
    * videoproto 2.3.0
    * xcb-proto 1.6
    * xcmiscproto 1.2.0
    * xextproto 7.1.1
    * xf86bigfontproto 1.2.0
    * xf86dgaproto 2.1
    * xf86driproto 1.2.0
    * xf86miscproto 0.9.3
    * xf86vidmodeproto 2.3
    * xineramaproto 1.2
    * xproto 7.0.16
  * server:
    * xorg-server 1.7.6 plus other patches
      * Move to the 1.7 branch
      * 64bit fixes for pbproxy
      * Add support for side-by-side installation with system X11 (SnowLeopard Only)
      * Allow 16bit accumulation buffers
      * Properly set the key repeat rates in the server rather than relying on xinitrc
      * Partially fixed the "borders don't show up" bug (#290)
      * Fixed the rare stuck mouse pointer bug (#64)

== Changes in 2.4.0 ==
  * All changes in 2.3.3.2 plus:
  * app:
    * font-util 1.0.2
    * quartz-wm 1.0.4
      * Added an option to quit X11 when no more windows are being managed by quartz-wm
        * defaults write org.x.X11 wm_auto_quit -bool true
        * defaults write org.x.X11 wm_auto_quit_timeout -int 3
      * fixed an input bug with fullscreen windows
      * maximizing a window that is partially offscreen will no longer cause it to be behind the Dock
    * setxkbmap 1.1.0
    * Xephyr, Xnest, Xfake, Xvfb 1.6.3
    * xfs 1.1.0
    * xkbcomp 1.1.0
    * xmag 1.0.3
    * xrandr 1.3.1
    * xrx 1.0.3
    * xterm 245
  * lib:
    * cairo 1.8.8
    * fontconfig 2.7.1
    * freetype
      * no longer built --with-old-mac-fonts in order to prevent linking against CoreFoundation. See #280
    * libAppleWM 1.3.0
    * libFS 1.0.2
    * liblbxutil removed
    * liboldX removed
    * libpng 1.2.37
    * libSM 1.1.1
    * libX11 1.2.2
    * libxcb 1.4
    * libXaw 1.0.6
    * libXplugin
      * Fix a possible deadlock when using 8bit visuals
      * Added API for attaching transient windows
    * libXprintAppUtil removed
    * libXprintUtil removed
    * libXt 1.0.6
    * mesa 7.4.4
      * libGLU, libglut, and OSMesa
        * Fixed linking problems with libOSMesa
    * xcb-util 0.3.5
    * xtrans 1.2.4
  * proto:
    * applewmproto 1.3.0
    * dri2proto 2.1
    * fixesproto 4.1
    * glproto 1.4.10
    * inputproto 1.5.1
    * renderproto 0.11
    * xcb-proto 1.5
    * xextproto 7.1.0
  * server:
    * Xquartz fixes from xorg-server-1.5.3-apple14
      * xserver codebase updated to 1.5 branch
      * rewritten AIGLX dispatch code
      * Localization updates
      * Don't zombie "jumpstart" process at launch
      * GLXFBConfigs and GLXVisuals don't contain duplicates when using multiple monitors
      * Automatic updates using Sparkle

== Changes in 2.3.3.2 ==
  * All changes in 2.3.3.1 plus:
  * lib:
    * libXplugin
      * Fixed a bug in the interaction between X11 and Spaces

== Changes in 2.3.3.1 ==
  * All changes in 2.3.3 plus:
  * apps:
    * xinput 1.4.2
  * lib:
    * libXplugin
      * Fixed a possible crash when closing windows
  * proto:
    * dri2proto 2.0

== Changes in 2.3.3 ==
  * All changes in 2.3.2.1 plus:
  * apps:
    * quartz-wm
      * Properly re-enable the close widget when modal windows are destroyed
      * Fixed a bug when the window was told to unmaximize when it was already not maximized.
    * xinput 1.4.1
    * xrandr 1.3.0
    * xterm 243b
    * Xephyr, Xnest, Xfake, Xvfb 1.6.0
  * proto:
    * applewmproto 1.2.0
    * dri2proto 1.99.3
    * randrproto 1.3.0
    * xproto 7.0.15
    * xextproto 7.0.5
    * xcb-proto 1.4
    * xf86rushproto 1.1.2
  * lib:
    * AppleSGLX 57
      * Support the same version of OpenGL as OpenGL.framework (2.1)
        * GLSL and other features now supported
        * Many extensions from OpenGL.framework are now available
      * rewrite of libGL now has support for GLX-1.4
        * GLXPixmap
        * GLXPbuffer
      * Threading support should be more stable
    * fontconfig
      * Avoid rebuilding font caches when switching between archs
    * freetype 2.3.9
    * libAppleWM 1.2.0
    * libICE 1.0.5
    * libpng 1.2.35
      * CVE-2009-0040
    * libxcb 1.2
    * libX11 1.2
    * libXau
      * Avoid lock failures with AFP home directories
    * libXext 1.0.5
    * libXfont 1.4.0
    * libXi 1.2.1
    * libXrandr 1.3.0
    * pixman 0.14.0
    * xtrans 1.2.3
  * server:
    * Xquartz fixes from xorg-server-1.4.2-apple42
      * DRI Updates for new libGL
      * Fix CapsLock
      * Fixed mouse tracking for games like Quake2, Halflife, etc in wine.
      * Fixed the annoying spaces bug resulting from accessing menus in a window that you moved to another space
      * When configured for fullscreen mode, initial apps don't start rootless.
      * Update window levels when changing rootless status
      * Fixed window levels to work with applications that create a desktop (nautilus, etc)
      * Properly send tablet proximity events
      * Localization Updates

== Changes in 2.3.2.1 ==
  * All changes in 2.3.2 plus:
  * lib:
    * fontconfig 2.6.0
      * fixed configuration directory to be /usr/X11/lib/X11/fontconfig

== Changes in 2.3.2 ==
  * All changes in 2.3.1 plus:
  * app:
    * mkfontscale 1.0.6
    * quartz-wm
      * Cleaned up parenting of dialog and utility windows
      * Respond to new AppleWMReloadPreferences notification rather than just SIGHUP
      * space-change shortcuts and dragging work to move windows to other spaces
      * Fixed bug with --no-pasteboard option that didn't completely disable it (it still grabbed PRIMARY in activate/deactivate)
      * defaults to --no-pasteboard when the server uses version 1.1 and greater of applewmproto
      * Cleaned up some memory leaks
      * Support added for window gravity in WM size hints 
      * Support added for WM fullscreen hints
    * xedit 1.1.2
    * xinit 1.1.1
    * xterm 238
        * Addresses CVE-2008-2383
  * lib:
    * cairo 1.8.6
    * fontconfig 2.6.0
    * freetype 2.3.7
    * libpng 1.2.33
      * Note that our previous version was 1.2.26 and was NOT affected by CVE-2008-3964.
    * libxcb 1.1
      * Fixed potential problems with xcb using the launchd socket
    * libXau 1.0.4
    * libXaw 1.0.5
      * libXaw.8.dylib is still provided from libXaw-1.0.4 for compatability
    * libXfont 1.3.4
    * libXi 1.2.0
    * libX11 1.1.5
    * mesa-7.2
      * For libGLU, libglut, glxgears, glxinfo
    * pixman 0.12.0
    * Xplugin
      * Cleaned up parenting of dialog and utility windows
    * xcb-util 0.3.2
    * xtrans 1.2.2
  * misc:
    * util-macros 1.2.1
  * proto:
    * applewmproto 1.1.1
      * AppleWMReloadPreferences notification
    * inputproto 1.5.0
    * xextproto 7.0.4
    * xproto 7.0.14
  * server:
    * Xquartz fixes from xorg-server-1.4.2-apple31
      * Send out AppleWMReloadPreferences notification to tell quartz-wm and xpbproxy to reload preferences
      * Fix a crash in RootlessNativeWindowMoved when compiled for 64bit
      * Fix a possible crash on startup due to TSM not being thread safe
      * Added new preferences UI for xpbproxy options
      * Disabled 8bit visuals while in TrueColor mode since they don't work yet
      * Tablet support improved for GDK-based applications (Gimp, Inkscape, etc)
      * Many updates to GLX support
        * Stereo GLX support detected
        * Accum buffers supported
        * More visuals supported
        * Multisampling now supported
      * Fixed levels for CGWindows
      * Fullscreen-rooted support (same behavior as tiger)
        * Added an option for getting access to the OSX menu bar while in fullscreen
      * Correctly follow system keyboard layout when enabled
      * Tooltips won't display from X11 apps "behind" native apps.
        * Apps like xeyes only get events when the mouse is actually over an X11 window now
      * Default dpi reported is now 96 instead of 75
      * Fixed possible (rare) deadlock in event processing
      * Massive update of proxying between OSX pasteboard and X11 clipboard/primary buffers
        * Image support
        * Unicode support
        * Preference options available in the X11 Preferences window
      * X11.app should exit properly when using another WM
      * Improved support for running X11 without launchd
      * Improved support for running multiple X11 servers
      * Fixed dead-acute with the Czech and Greek layouts
      * Fixed working directory of the initial xterm to be $HOME
      * Ensured that /usr/X11/bin was in the PATH of the initial xterm
      * Added a defaults option to enable DEC-XTRAP, RENDER, and XTEST extensions
        * defaults write org.x.X11 enable_test_extensions -boolean true
      * Fixed the white-rectangles bug
      * Fixed stuck keys when switching to another OSX application
      * Honor system key repeat rate

== Changes in 2.3.1 ==
  * All changes in 2.3.0 plus:
  * app:
    * xedit 1.1.1
    * quartz-wm
      * Added --no-pasteboard command line option
  * lib:
    * mesa 7.1-rc4
      * For libGLU, libglut, glxgears, glxinfo
    * pixman 0.11.8
    * Xplugin
      * Added API for detecting if a Carbon EventRef corresponds to a Mac OSX key-equivalent action
    * xpyb 0.9
    * xtrans 1.2.1-git-2008.08.05
  * proto:
    * randrproto 1.2.2
    * xextproto 7.0.3
    * xproto 7.0.13
  * server:
    * Xquartz fixes from xorg-server-1.4.2-apple17
      * building with mesa 7.0.4
      * X11.app now properly notices button clicks with tablets
      * partially fixed xinitrc / launchd-first-client race condition
      * Re-added old fallback keyboard map detection fallback with extra debugging
      * Capslock "press ignored" bug is fixed.
      * Fixed stuck modifier key bug
      * Fixed 3-button mouse emulation
      * The list of modifiers allowed in the fake_button{2,3} defaults has been expanded:
        * fn,{l,r,}{command,alt,shift,control}
      * Expanded handling of key equivalents beyond just the menu when enabled (such as the input menu, etc)
        * Also added appkit_modifiers defaults option which users can set to certain modifier keys to always be for Appkit in case this is insufficient
      * Added window_item_modifiers defaults item (and option to localization) to change the modifier keys used for the windows menu.
        * Set it to an empty string to disable key equivalents for changing windows.
      * Fixed a possible crash in SwitchCoreKeyboard resulting from the use of tablets (or anything sending NSTabletPoint events)
      * Fixed s possible crash in NewCurrentScreen
      * Fixed a possible crash in RootlessNativeWindowMoved
      * Updated the Xquartz man page
      * Don't warp the pointer on startup
      * Made fd handoff from stub to server more robust
      * Added 256 color mode option to the server (8bit visuals in TrueColor mode are still broken though)

== Changes in 2.3.0 ==
  * All changes in 2.2.3 plus:
  * app:
    * fonttosfnt 1.0.4
    * fslsfonts 1.0.2
    * fstobdf 1.0.3
    * mkfontscale 1.0.5
    * rgb 1.0.3
    * sessreg 1.0.4
    * showfont 1.0.2
    * xdm 1.1.8
    * xdpyinfo 1.0.3
    * xfs 1.0.8
    * xfsinfo 1.0.2
    * xinit 1.0.9
    * xkbcomp 1.0.5
    * xkeyboard-config 1.3
      * replaces old xkbdata
    * xrx 1.0.2
    * xwd 1.0.2
    * xwininfo 1.0.4 
  * lib:
    * libFS 1.0.1
    * libSM 1.1.0
    * libXfont 1.3.3
    * libXft 2.1.13
    * libXrandr 1.2.3
    * libXxf86vm 1.0.2  
    * xtrans 1.2.1
  * proto:
    * randrproto 1.2.2
    * xextproto 7.0.3
    * xproto 7.0.13
  * server:
    * Xquartz fixes from xorg-server-1.4.2-apple5
      * xserver codebase updated to 1.4 branch
      * Support for tablets
      * Threading is more robust
      * Support for new startup model
        * support for adding new $DISPLAY sockets after the server is running
        * server bits are in the bundle now
        * /usr/X11/bin/Xquartz is just a stub that will "do the right thing"

== Changes in 2.2.3 ==
  * All changes in 2.2.2 plus:
  * lib:
    * freetype 2.3.6
      * Note from freetype developers: "A bunch of potential security problems have been found [and fixed] in this release" 
    * pixman 0.11.4 

== Changes in 2.2.2 ==
  * All changes in 2.2.1 plus:
  * server:
    * Xquartz fixes from xorg-server-1.3.0-apple21
      * Support monitor hotplugging
      * CVE-2008-1377
      * CVE-2008-1379
      * CVE-2008-2360
      * CVE-2008-2361
      * CVE-2008-2362 

== Changes in 2.2.1 ==
  * All changes in 2.2.0.1 plus:
  * All packages updated to versions intended to ship as part of X11R7.4 (as of 2008.04.21):
  * app:
    * setxkbmap 1.0.4 
    * xinit 1.0.8-git-2008.04.26
      * Use CFProcessPath instead of argv[0] trick
    * xkbcomp 1.0.4
    * xkbdata 1.0.1
    * xkbevd 1.0.2
    * xkbprint 1.0.1
    * xkbutils 1.0.1
    * xterm 235
  * lib:
    * cairo 1.6.4
    * mesa 7.0.3
      * for libGLU, libglut, libOSMesa, Xfake, and Xephyr
    * libxkbfile 1.0.5
    * libXv 1.0.4
    * pixman 0.10.0
  * proto:
    * dri2proto 1.1
    * xf86driproto 2.0.4
  * quartz-wm:
    * Fixed "closing X11 window swaps spaces" bug
  * server:
    * xorg-server-1.3.0-apple20
      * Fixed multiple crash-causing bugs
      * Fixed cmd-tab to properly move all windows forward when entering X11.app

== Changes in 2.2.0.1 ==
  * All changes in 2.2.0 plus:
    * Updated /usr/X11/lib/X11/xinit/privileged_startx.d/10-tmpdirs to address a potential security risk (privilege escalation):
      * A user could create a symbolic link from /tmp/.X11-unix to /usr/X11/lib/X11/xinit/privileged_startx.d and execute privileged_startx to give himself write permission to /usr/X11/lib/X11/xinit/privileged_startx.d 

== Changes in 2.2.0 ==
  * All changes in 2.1.4 plus:
  * All packages updated to versions intended to ship as part of X11R7.4 (as of 2008.03.14):
  * app:
    * bitmap 1.0.3
    * bdftopcf 1.0.1
    * editres 1.0.3
    * iceauth 1.0.2
    * ico 1.0.2
    * luit 1.0.3
      * Also added Martin's secure tty patch
    * mkfontdir 1.0.4
    * mkfontscale 1.0.4
    * setxkbmap 1.0.4
    * ttmkfdir 3.0.9
    * sessreg 1.0.3
    * twm 1.0.4
    * x11perf 1.5
    * xauth 1.0.3
    * xbacklight 1.1
    * xcalc 1.0.2
    * xclock 1.0.3
    * xconsole 1.0.3
    * xcursorgen 1.0.2
    * xdm 1.1.7
    * xdpyinfo 1.0.2
    * xdriinfo 1.0.2
    * xev 1.0.3
    * xfontsel 1.0.2
    * xfs 1.0.6
    * xgamma 1.0.2
    * xhost 1.0.2
    * xinit 1.0.8-git-2008.04.08
      * Moved font caching logic to startx rather than xinitrc
      * Added support for xinitrc.d directory, so fink, macports, et al won't clobber our xinitrc
      * Moved some stuff out of xinitrc into the xinitrc.d directory
      * Fixed startup to work correctly even with broken .bashrc and .profile ('set <blah>' bug)
      * Fixed "post-crash titlebar missing" bug
      * Fixed /tmp/.X11-unix permission
      * Now cache system font directories at X11.app startup rather than system startup
      * Renamed startx LaunchAgent org.x.startx from org.x.X11
      * System xinitrc now works for users with spaces in $HOME
    * xload 1.0.2
    * xlsfonts 1.0.2
    * xmag 1.0.2
    * xman 1.0.3
    * xmessage 1.0.2
    * xpr 1.0.2
    * xmodmap 1.0.3
    * xprop 1.0.4
    * xrandr 1.2.3
    * xrdb 1.0.5
    * xset 1.0.4
    * xsetpointer 1.0.1
    * xsetroot 1.0.2
    * xvinfo 1.0.2
    * xwininfo 1.0.3
  * font:
    * font-xfree86-type1 1.0.1
  * lib:
    * cairo 1.4.14
    * libICE 1.0.4
    * libSM 1.0.3
    * libX11 1.1.4
    * libXaw 1.0.4
    * libXcomposite 0.4.0
    * libXcursor 1.1.9
    * libXdamage 1.1
    * libXext 1.0.4
    * libXfont 1.3.2
    * libXi 1.1.3
    * libXinerama 1.0.3
    * libXmu 1.0.4
    * libXpm 3.5.7
    * libXrandr 1.2.2
    * libXrender 0.9.4
    * libXt 1.0.5
    * libXtst 1.0.3
    * libXxf86dga 1.0.2
    * libpng 1.2.26
      * Includes fix for CVE-2008-1382
    * xcb 1.1
    * xtrans 1.1
  * proto:
    * inputproto 1.4.3
    * printproto 1.0.4
    * xproto 7.0.12
    * xcb-proto 1.1
  * util:
    * makedepend 1.0.1
    * util-macros 1.1.6
  * quartz-wm:
    * Restores minimized windows when the server crashes
    * Added preference to control moving X11.app into the foreground when a new X11 window is created
    * Added preference to toggle shading of windows
  * server:
    * xorg-server-1.3.0-apple15
      * Added informational output when falling through to failsafe startup in X11.app
      * Unsetenv(DISPLAY) when falling through to failsafe startup in X11.app
      * Fixed "confirm on exit"
      * Exposé now works as expected
      * Disabled rlAccel (suspected of causing some crashes, might not be fixed since plans are to support COMPOSITE)
      * X11 works better with spaces

== Changes in 2.1.4 ==
  * All changes in 2.1.3 plus:
  * app:
    * fontconfig 2.5.0
      * fixes a bunch of compatability issues (including Trolltech QT4)
    * ttmkfdir 3.0.9
      * app was missing
    * xinput 1.3.0
      * app was missing
    * xterm 232
      * fixes tek with wide chars
    * xinit git 2008.02.10
      * fixes fontpath to avoid "big fonts" issue commonly seen in xemacs
      * fix xinitrc to properly process .Xresources if dev tools are not installed
      * update FC cache on X11 start
    * Xvfb, Xnest, Xephyr, Xfake
      * built using xorg-server-1.4-apple (2008.02.14)
    * quartz-wm
      * Updated to use org.x.X11 instead of com.apple.x11 for defaults
  * fonts:
    * made font caching more "automatic"
  * server:
    * xorg-server-1.3.0-apple10
      * Fixed Window menu to conform to OSX UI Guidelines
      * Fixed command-~ to reverse cycle through windows
      * Added option to preferences for quartz-wm click-through
      * Fixed UI layout problems when resizing Applications->Customize window
      * Updated render and fb code from 1.4 branch
        * We are now using pixman for our fbBlah function calls, and this code has been heavily refactored in the integration with pixman, so this should clear up many of those crashes

== Changes in 2.1.3 ==
  * All changes in 2.1.2 plus:
  * lib:
    * libXfont git 2008.01.14
      * CVE-2008-0006
  * server:
    * xorg-server-1.3.0-apple9
      * fixed 'login_shell' defaults key usage when launching from the Applications menu.
      * CVE-2007-5958
      * CVE-2007-6427
      * CVE-2007-6428
      * CVE-2007-6429
      * CVE-2008-0006

== Changes in 2.1.2 ==
  * All changes in 2.1.1 plus:
  * app:
    * xinit git 2008.01.09
      * Updated xinit to support launchd
      * Now using xinit to start the server rather than running X11.app directly
        * X11.app is relocatable now
      * Fixed fast-user-switching X11 regression
      * Properly honor xauth and tcp/ip preferences
    * xauth git 2008.01.11
      * fixed duplicate entry crash during xauth remove
  * lib:
    * pixman 0.9.6
  * proto:
    * compositeproto 0.4
    * glproto 1.4.9
    * inputproto-1.4.2.1
    * renderproto-0.9.3
  * server:
    * Xquartz fixes from xorg-server-1.2-apple (Up to Xquartz-1.3.0-apple7)
      * XQuartz comes to the foreground later in the startup process to not cause 'XQuartz -version' to flash a dock icon
      * Fixed -depth command line argument to work properly (still no 8-bit support)
      * added 'startx_script' defaults option which defaults to /usr/X11/bin/startx.
      * This is used when launchd support is disabled and the user uses X11.app to start the server (such as with Tiger).
      * added localization from Leopard's shipped X11.
      * added 'login_shell' key to org.x.X11 plist which defaults to /bin/sh and is used for launching from the Applications menu.  tcsh users will probably want to change this to /bin/tcsh.

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
    * Fixed Alt to work right with [wiki:KeyboardMapping#AltvsMode_switch ~/.Xmodmap
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
