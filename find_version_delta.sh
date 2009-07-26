#!/bin/bash

install_version () {
	local version=$1
	if [[ ! -f X11.bin-${version} ]] ; then
		if [[ ! -f X11.bin-${version}.bz2 ]] ; then
			curl -LO http://static.macosforge.org/xquartz/downloads/archive/X11.bin-${version}.bz2 || die "Failed to fetch version ${version}"
		fi
		bunzip2 X11.bin-${version}.bz2 || die "Failed to decompress version ${version}"
	fi
	chmod 755 X11.bin-${version} || die "Failed to chmod version ${version}"
	cp X11.bin-${version} /Applications/Utilities/X11.app/Contents/MacOS/X11.bin || die "Failed to install version ${version}.  This needs to be done as root (run 'sudo ./find_version_delta.sh')"
}

die() {
        echo "${@}" >&2
        exit 1
}

((LO=18))
((HI=45))

TMPDIR=/tmp/test_x11

if ! [[ -d ${TMPDIR} ]] ; then
	mkdir ${TMPDIR} || die "Could not make #{TMPDIR}"
fi

cd ${TMPDIR}

while (( HI - LO > 1 )) ; do
	(( TRY = (LO + HI) / 2))
	version="1.4.2-apple${TRY}"
	echo "Trying ${version}"

	install_version ${version}

	echo "Please quit X11.app and restart it."
	ANSWER=""
	while ! [[ ${ANSWER} == "y" || ${ANSWER} == "n" ]] ; do
		echo -n "Is this version working (y/n)? "
		read ANSWER
	done

	# Assuming newer is broken
	if [[ ${ANSWER} == "y" ]] ; then
		(( LO=TRY ))
	else 
		(( HI=TRY ))
	fi
done

echo "1.4.2-apple${LO} was the last to work"
echo "1.4.2-apple${HI} was the first to break"
