#!/bin/bash

. ~jeremy/src/strip.sh

unset CFLAGS OBJCFLAGS CPPFLAGS LDFLAGS C_INCLUDE_PATH OBJC_INCLUDE_PATH CPLUS_INCLUDE_PATH PKG_CONFIG_PATH

BUILDIT=~rc/bin/buildit
#BUILDIT=/usr/local/bin/buildit
#BUILDIT=./buildit

MERGE_DIRS="/"

if [[ $# -eq 2 ]] ; then
	MERGE_DIRS="${MERGE_DIRS} $(eval echo ~jeremy)/src/freedesktop/pkg/X11"

	VERSION_TXT=$1
	VERSION_TXT_SHORT=${VERSION_TXT%_*}
	VERSION=$2

	echo "User Version: ${VERSION_TXT}"
	echo "Base Version: ${VERSION_TXT_SHORT}"
	echo "Bundle Version: ${VERSION}"
fi

#MACOSFORGE=LEO
MACOSFORGE=SL

#MACOSFORGE_BUILD_DOCS="YES"
MACOSFORGE_BUILD_DOCS="NO"

TRAIN="trunk"
#TRAIN="trains/SnowLeopard"
#TRAIN="trains/SULeo"
#TRAIN="trains/Lion"

### End Configuration ###

XPLUGIN="${XPLUGIN:-${TRAIN}}"
X11MISC="${X11MISC:-${TRAIN}}"
X11PROTO="${X11PROTO:-${TRAIN}}"
X11LIBS="${X11LIBS:-${TRAIN}}"
QUARTZWM="${QUARTZWM:-${TRAIN}}"
X11SERVER="${X11SERVER:-${TRAIN}}"
X11APPS="${X11APPS:-${TRAIN}}"
X11FONTS="${X11FONTS:-${TRAIN}}"

die() {
	echo "${@}" >&2
	exit 1
}

MACOSFORGE_LEO=NO
MACOSFORGE_SL=NO
MACOSFORGE_RELEASE=NO

if [[ "${MACOSFORGE}" == "LEO" ]] ; then
	MACOSFORGE_LEO=YES
	MACOSFORGE_RELEASE=YES
elif [[ "${MACOSFORGE}" == "SL" ]] ; then
	MACOSFORGE_SL=YES
	MACOSFORGE_RELEASE=YES
fi

export MACOSFORGE_LEO MACOSFORGE_SL MACOSFORGE_RELEASE

if [[ ${MACOSFORGE_SL} == "YES" ]] ; then
	export X11_PREFIX="/opt/X11"
	export XPLUGIN_PREFIX="/opt/X11"
	export QUARTZWM_PREFIX="/opt/X11"
	export X11_BUNDLE_ID_PREFIX="org.macosforge.xquartz"
	export X11_APP_NAME="XQuartz"
	export LAUNCHD_PREFIX="/Library"
	export X11_PATHS_D_PREFIX="40"
fi

if [[ ${MACOSFORGE_RELEASE} == "YES" ]] ; then
	BUILDIT="${BUILDIT} -noverify -noverifydstroot -nocortex -nopathChanges"

	export MACOSFORGE_BUILD_DOCS

	if [[ ${MACOSFORGE_BUILD_DOCS} == "YES" ]] ; then
		export XMLTO=/opt/local/bin/xmlto
		export ASCIIDOC=/opt/local/bin/asciidoc
		export DOXYGEN=/opt/local/bin/doxygen
		export FOP=/opt/local/bin/fop
		export FOP_OPTS="-Xmx2048m -Djava.awt.headless=true"
		export GROFF=/opt/local/bin/groff
		export PS2PDF=/opt/local/bin/ps2pdf

		for f in "${XMLTO}" "${ASCIIDOC}" "${DOXYGEN}" "${FOP}" "${GROFF}" "${PS2PDF}" ; do
			[[ -z "${f}" || -x "${f}" ]] || die "Could not find ${f}"
		done
	fi
fi

if [[ "${MACOSFORGE_LEO}" == "YES" && ${XPLUGIN} == "trunk" ]] ; then
	XPLUGIN="trains/MacOSForge"
fi

if [[ "${MACOSFORGE_LEO}" == "YES" ]] ; then
	ARCH_EXEC="-arch i386 -arch ppc"
	ARCH_ALL="${ARCH_EXEC} -arch x86_64 -arch ppc64"
	export MACOSX_DEPLOYMENT_TARGET=10.5
	export EXTRA_XQUARTZ_CFLAGS="-mmacosx-version-min=${MACOSX_DEPLOYMENT_TARGET}"
	export EXTRA_XQUARTZ_LDFLAGS="-Wl,-macosx_version_min,${MACOSX_DEPLOYMENT_TARGET}"
	export CC="/usr/bin/gcc-4.2"
	export CXX="/usr/bin/g++-4.2"
	export OBJC="${CC}"
	export PYTHON=/usr/bin/python2.5
	export PYTHONPATH="/usr/X11/lib/python2.5:/usr/X11/lib/python2.5/site-packages"
	BUILDIT="${BUILDIT} -release SULeoLoki"
elif [[ "${TRAIN}" == "trains/SULeo" ]] ; then
	ARCH_EXEC="-arch i386 -arch ppc"
	ARCH_ALL="${ARCH_EXEC} -arch x86_64 -arch ppc64"
	BUILDIT="${BUILDIT} -release SULeoLoki"
else
	ARCH_EXEC="-arch i386 -arch x86_64"
	ARCH_ALL="${ARCH_EXEC}"
	if [[ "${MACOSFORGE_SL}" == "YES" ]] ; then
		export MACOSX_DEPLOYMENT_TARGET=10.6
		export EXTRA_XQUARTZ_CFLAGS="-mmacosx-version-min=${MACOSX_DEPLOYMENT_TARGET}"
		export EXTRA_XQUARTZ_LDFLAGS="-Wl,-macosx_version_min,${MACOSX_DEPLOYMENT_TARGET}"
		#export CC="clang-mp-3.1"
		#export CXX="clang++-mp-3.1"
		#export CC="$(xcrun -find clang)"
		#export CXX="$(xcrun -find clang++)"
		export CC="/usr/bin/clang"
		export CXX="/usr/bin/clang++"
		export OBJC="${CC}"
		export PYTHON=/usr/bin/python2.6
		export PYTHONPATH="${X11_PREFIX}/lib/python2.6:${X11_PREFIX}/lib/python2.6/site-packages"
	fi
fi

BUILDRECORDS="$(/usr/bin/mktemp -d ${TMPDIR-/tmp}/X11roots.XXXXXX)"
chown jeremy "${BUILDRECORDS}"

bit() {
	local PROJECT="${1}" ; shift
	local SRCROOT="${1}" ; shift
	local DSTROOT="${BUILDRECORDS}/${PROJECT}.roots/${PROJECT}~dst"
	local SYMROOT="${BUILDRECORDS}/${PROJECT}.roots/${PROJECT}~sym"

	pushd "${SRCROOT}" || die
	${BUILDIT} -rootsDirectory "${BUILDRECORDS}" -project "${PROJECT}" . "${@}" || die
	popd || die

	local MERGE_DIR
	echo ""
	for MERGE_DIR in ${MERGE_DIRS}; do
		echo "*** mk_x11_dist.sh ***: Merging into root: ${MERGE_DIR}" || die
		mkdir -p "${MERGE_DIR}" || die
		ditto "${DSTROOT}" "${MERGE_DIR}" || die

		if [[ -n "${MERGE_DIR}" && "${MERGE_DIR}" != "/" ]] ; then
			/bin/rm -rf "${MERGE_DIR}"/usr/local
			/bin/rmdir "${MERGE_DIR}"/usr >& /dev/null

			mkdir -p "${MERGE_DIR}.dSYMS"
			find "${SYMROOT}" -type d -name '*.dSYM' | while read dsym ; do
				local file_basename="${dsym##*/}"
				file_basename="${file_basename%.dSYM}"
				file=$(find "${DSTROOT}" -type f -name "${file_basename}")

				local dirname="${file#${DSTROOT}}"
				dirname="${dirname%/*}"

				ditto "${dsym}" "${MERGE_DIR}.dSYMS/${dirname}/${file_basename}.dSYM"
			done
		fi
	done
}

bit_git() {
	proj=${1} ; shift
	branch=${1} ; shift
	[[ "${branch}" == "trunk" ]] && branch="master"

	if [[ -n "${branch}" && -d "${proj}" ]] ; then
		pushd "${proj}"
		git checkout "${branch}" || die "Unable to checkout ${branch}"
		bit "${proj}" . "${@}"
		popd
	fi
}

[[ -n ${XPLUGIN} ]]     && bit_git X11_Xplugin   "${XPLUGIN}"              ${ARCH_ALL}
[[ -n ${X11MISC} ]]     && bit     X11misc       X11misc/${X11MISC}        ${ARCH_ALL}
[[ -n ${X11PROTO} ]]    && bit     X11proto      X11proto/${X11PROTO}      ${ARCH_ALL}
[[ -n ${X11LIBS} ]]     && bit     X11libs       X11libs/${X11LIBS}        ${ARCH_ALL}
[[ -n ${QUARTZWM} ]]    && bit     X11_quartz_wm X11_quartz_wm/${QUARTZWM} ${ARCH_ALL}
[[ -n ${X11SERVER} ]]   && bit     X11server     X11server/${X11SERVER}    ${ARCH_ALL}
[[ -n ${X11APPS} ]]     && bit     X11apps       X11apps/${X11APPS}        ${ARCH_ALL}
[[ -n ${X11FONTS} ]]    && bit     X11fonts      X11fonts/${X11FONTS}      ${ARCH_ALL}

INFO_PLIST="$(eval echo ~jeremy)/src/freedesktop/pkg/X11/Applications/Utilities/XQuartz.app/Contents/Info.plist"
if [[ -n ${VERSION} ]] ; then
	defaults write "${INFO_PLIST}" CFBundleVersion "${VERSION}"
	defaults write "${INFO_PLIST}" CFBundleShortVersionString "${VERSION_TXT}"
	plutil -convert xml1 "${INFO_PLIST}"
	chmod 644 "${INFO_PLIST}"

	if [[ "${VERSION_TXT}" == "${VERSION_TXT_SHORT}" ]] ; then
		/opt/local/bin/gsed -i 's:beta.xml:release.xml:' "${INFO_PLIST}"
	else
		/opt/local/bin/gsed -i 's:release.xml:beta.xml:' "${INFO_PLIST}"
	fi

	cd $(eval echo ~jeremy)/src/freedesktop/pkg

	find X11 -type f | while read file ; do
		if /usr/bin/file "${file}" | grep -q "Mach-O" ; then
			codesign -s "Developer ID Application: Apple Inc. - XQuartz" "${file}"
		fi
	done

	./mkpmdoc.sh
	chown -R jeremy XQuartz-${VERSION_TXT}.pmdoc
	echo "Browse to the components tab and check the box to make XQuartz.app downgradeable"
	echo "<rdar://problem/10772627>"
	echo "Press enter when done"
	sudo -u jeremy open XQuartz-${VERSION_TXT}.pmdoc
	read IGNORE
	sudo -u jeremy /Applications/PackageMaker.app/Contents/MacOS/PackageMaker --verbose --doc XQuartz-${VERSION_TXT}.pmdoc --out XQuartz-${VERSION_TXT}.pkg
	sudo -u jeremy productsign --sign "Developer ID Installer: Apple Inc. - XQuartz" XQuartz-${VERSION_TXT}.pkg{,.s}
	mv XQuartz-${VERSION_TXT}.pkg{.s,}
	sudo -u jeremy ./mkdmg.sh XQuartz-${VERSION_TXT}.pkg ${VERSION} > XQuartz-${VERSION_TXT}.sparkle.xml
fi
