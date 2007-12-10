export CPLUS_INCLUDE_PATH="/usr/X11/include:${CPLUS_INCLUDE_PATH}"
export C_INCLUDE_PATH="/usr/X11/include:${C_INCLUDE_PATH}"
export OBJC_INCLUDE_PATH="/usr/X11/include:${OBJC_INCLUDE_PATH}"

export PKG_CONFIG_PATH="/usr/X11/lib/pkgconfig:${PKG_CONFIG_PATH}"
export ACLOCAL="aclocal -I /usr/X11/share/aclocal"

export CFLAGS="-Wall -O2 -arch i386 -arch ppc -pipe"
export LDFLAGS="-Wall -O2 -arch i386 -arch ppc -pipe"

rootdir="$(pwd)"
DESTDIR="$(pwd)/dist"

die() {
	echo "${@}" >&2
	exit 1
}

doinst() {
	d=$1
	shift
	cd ${rootdir}/${d} || die "unable to find source for ${d}"
	gmake distclean
	./configure --prefix=/usr/X11 --mandir=/usr/X11/man --disable-dependency-tracking "${@}" || die "Configure of ${d} failed."
	gmake -j5 || die "Compile of ${d} failed."
	gmake install DESTDIR="${DESTDIR}" || die "Install of ${d} failed."
}

for d in compositeproto-0.4 damageproto-1.1.0 glproto-1.4.9 inputproto-1.4.2.1 randrproto-1.2.1 renderproto-0.9.3 xfs-1.0.5 ; do
	doinst $d
done

# Libs need x86_64 and ppc64
CFLAGS="${CFLAGS} -arch x86_64 -arch ppc64"
doinst pixman-0.9.6 --disable-static

# This -D__DARWIN__ should be fixed in 1.1.4 - in git 2007-12-28
OLD_CFLAGS=${CFLAGS}"
CFLAGS="${CFLAGS} -D__DARWIN__"
doinst libX11-1.1.3 --disable-xf86bigfont --disable-xcb --disable-static
CFLAGS="${OLD_CFLAGS}"
