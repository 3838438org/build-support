export CPLUS_INCLUDE_PATH="/usr/X11/include:${CPLUS_INCLUDE_PATH}"
export C_INCLUDE_PATH="/usr/X11/include:${C_INCLUDE_PATH}"
export OBJC_INCLUDE_PATH="/usr/X11/include:${OBJC_INCLUDE_PATH}"

export PKG_CONFIG_PATH="/usr/X11/lib/pkgconfig:${PKG_CONFIG_PATH}"
export ACLOCAL="aclocal -I /usr/X11/share/aclocal"

export CFLAGS="-Wall -O2 -arch i386 -arch ppc -pipe -DNO_ALLOCA"
export LDFLAGS="-Wall -O2 -arch i386 -arch ppc -pipe -DNO_ALLOCA"

# Parallel Make.  Change $MAKE if you don't have gmake installed
MAKE="gmake"
MAKE_OPTS="-j3"

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
	${MAKE} clean
	./configure --prefix=/usr/X11 --mandir=/usr/X11/man --disable-dependency-tracking "${@}" || die "Configure of ${d} failed."
	${MAKE} ${MAKE_OPTS} || die "Compile of ${d} failed."
	${MAKE} install DESTDIR="${DESTDIR}" || die "Install of ${d} failed."
}

# Protos
for d in compositeproto-0.4 damageproto-1.1.0 glproto-1.4.9 inputproto-1.4.2.1 randrproto-1.2.1 renderproto-0.9.3 ; do
	doinst $d
done

# Apps, git versions from 2007.12.09
for d in xauth xinit lndir xfs-1.0.5; do
	doinst $d
done

# Libs need x86_64 and ppc64
CFLAGS="${CFLAGS} -arch x86_64 -arch ppc64"

doinst pixman-0.9.6 --disable-static

# libX11-1.1.3 has libX11-apple.patch applied - see git-diff 4b91ed099554626f1ec17d5bdf7bd77ce1a70037 b57129ef324c73ee91c2a796b800c4b45f4d4855
doinst libX11-1.1.3 --disable-xf86bigfont --disable-xcb --disable-static
