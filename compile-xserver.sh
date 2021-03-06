#!/bin/bash

#CONFOPT="--disable-xquartz --disable-glx --disable-dri --disable-launchd --enable-kdrive --disable-xsdl --enable-xnest --enable-xvfb"
#CONFOPT="--enable-xorg --disable-xquartz --disable-kdrive --disable-xnest --disable-xvfb"

#CONFOPT="--enable-standalone-xpbproxy"
#CONFOPT="--disable-shave --without-dtrace"

#CONFOPT="${CONFOPT} --with-dtrace"

# Parallel Make.  Change $MAKE if you don't have gmake installed
MAKE="gnumake"
MAKE_OPTS="-j8 V=1"

. ~/src/strip.sh

PATH=$PATH:/opt/local/bin

#PREFIX=/usr/X11
#ARCHFLAGS="-arch i386 -arch x86_64"

#PREFIX=/opt/local
#CONFOPT="$CONFOPT --with-apple-applications-dir=/Applications/MacPorts --with-launchd-id-prefix=org.macports"
#CPPFLAGS="$CPPFLAGS -I${HOME}/src/macports/dports/x11/xorg-server-devel/files/dri"

PREFIX=/opt/X11
CONFOPT="$CONFOPT --with-apple-application-name=XQuartz --with-launchd-id-prefix=org.macosforge.xquartz"
ARCHFLAGS="-arch i386 -arch x86_64"

ACLOCAL="aclocal -I ${PREFIX}/share/aclocal -I /opt/local/share/aclocal"

CPPFLAGS="$CPPFLAGS -DNO_ALLOCA -DFAIL_HARD -DFAKEIT -DHAVE_STRLCPY"

#CPPFLAGS="$CPPFLAGS -D_FORTIFY_SOURCE=2"
#CFLAGS="$CFLAGS -fstack-protector"
#CFLAGS="$CFLAGS -fstack-protector-strong"
CFLAGS="$CFLAGS -fstack-protector-all"
CFLAGS="$CFLAGS -fsanitize=address"

CFLAGS="$CFLAGS -pipe -O0"
CFLAGS="$CFLAGS -g3 -gdwarf-2"
CFLAGS="$CFLAGS $ARCHFLAGS"
CFLAGS="$CFLAGS -Wall -Wextra -Wno-sign-compare -Wno-unused-parameter -Wno-missing-field-initializers"

CFLAGS="${CFLAGS} -fdiagnostics-show-category=name"

# Stage 1:
#    CFLAGS="${CFLAGS} -Werror=clobbered"
#    CFLAGS="${CFLAGS} -Wlogical-op"
#    CFLAGS="${CFLAGS} -Wparentheses"
#    CFLAGS="${CFLAGS} -Wcast-align"
#    CFLAGS="${CFLAGS} -Wunsafe-loop-optimizations"

OBJCFLAGS="$CFLAGS"
LDFLAGS="$CFLAGS"

#CC="llvm-gcc"
#CXX="llvm-g++"
#CC="/opt/local/bin/gcc-apple-4.2"
#CXX="/opt/local/bin/g++-apple-4.2"
CC="/opt/local/bin/clang-mp-3.7"
CXX="/opt/local/bin/clang++-mp-3.7"
#CC=clang
#CXX=clang++

OBJC="$CC"

#SCAN_BUILD="scan-build-mp-3.4 -v -V -o clang.d --use-cc=${CC} --use-c++=${CXX}"

#CPPFLAGS="$CPPFLAGS -F/Applications/Utilities/XQuartz.app/Contents/Frameworks"
#LDFLAGS="$LDFLAGS -F/Applications/Utilities/XQuartz.app/Contents/Frameworks"
#CPPFLAGS="$CPPFLAGS -F/Applications/Utilities/X11.app/Contents/Frameworks"
#LDFLAGS="$LDFLAGS -F/Applications/Utilities/X11.app/Contents/Frameworks"
#CONFOPT="${CONFOPT} --enable-sparkle"

# This section is for building release tarballs
if false ; then
	CONFOPT="${CONFOPT} --enable-docs --enable-devel-docs --enable-builddocs --with-doxygen --with-xmlto --with-fop"
	export XMLTO=/opt/local/bin/xmlto
	export ASCIIDOC=/opt/local/bin/asciidoc
	export DOXYGEN=/opt/local/bin/doxygen
	export FOP=/opt/local/bin/fop
	export FOP_OPTS="-Xmx2048m -Djava.awt.headless=true"
	export GROFF=/opt/local/bin/groff
	export PS2PDF=/opt/local/bin/ps2pdf
else
	CONFOPT="${CONFOPT} --disable-docs --disable-devel-docs --disable-builddocs"
fi

export ACLOCAL CPPFLAGS CFLAGS OBJCFLAGS LDFLAGS CC OBJC

PKG_CONFIG_PATH=${PREFIX}/share/pkgconfig:${PREFIX}/lib/pkgconfig:$PKG_CONFIG_PATH
PATH=${PREFIX}/bin:$PATH

die() {
	echo "${@}" >&2
	exit 1
}

docomp() {
	PATH=/opt/local/bin:${PATH} autoreconf -fvi || die
	${SCAN_BUILD} ./configure --prefix=${PREFIX} ${CONFOPT} --disable-dependency-tracking --enable-maintainer-mode --enable-xcsecurity --enable-record --disable-xevie "${@}" || die "Could not configure xserver"
	${MAKE} clean || die "Unable to make clean"
	${SCAN_BUILD} ${MAKE} ${MAKE_OPTS} || die "Could not make xserver"
	#${MAKE} distcheck ${MAKE_OPTS} DESTDIR=/tmp/distcheck || die "distcheck failed"
	#../modular/release.sh .
}

doinst() {
	${MAKE} install DESTDIR="$(pwd)/../dist" || die "Could not install xserver"
}

dosign() {
	/opt/local/bin/gmd5sum $1 > $1.md5sum
	/opt/local/bin/gsha1sum $1 > $1.sha1sum
	DISPLAY="" /opt/local/bin/gpg2 -b $1
}

dodist() {
	${MAKE} dist
	dosign xorg-server-$1.tar.bz2

	cp hw/xquartz/mach-startup/X11.bin X11.bin-$1
	bzip2 X11.bin-$1
	dosign X11.bin-$1.bz2
}

docomp `[ -f conf_flags ] && cat conf_flags`
#doinst
[[ -n $1 ]] && dodist $1

exit 0
