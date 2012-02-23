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
	BUILDIT="${BUILDIT} -noverify -noverifydstroot"

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
		export CC="/opt/llvm/bin/clang"
		#export CC="/usr/bin/gcc-4.2"
		#export CC="/usr/bin/llvm-gcc-4.2"
		#export CC="/usr/bin/clang"
		export OBJC="${CC}"
		export PYTHON=/usr/bin/python2.6
		export PYTHONPATH="${X11_PREFIX}/lib/python2.6:${X11_PREFIX}/lib/python2.6/site-packages"
	fi
fi

bit() {
	local MERGE_ROOT
	if [[ "${MERGE_DIRS/ /}" == "${MERGE_DIRS}" ]] ; then
		MERGE_ROOT="${MERGE_DIRS}"
		mkdir -p ${MERGE_ROOT}
	else
		MERGE_ROOT="$(/usr/bin/mktemp -d ${TMPDIR-/tmp}/X11dst.XXXXXX)"
	fi

	[[ -d "${MERGE_ROOT}" ]] || die
	${BUILDIT} "${@}" -merge "${MERGE_ROOT}" || die

	if [[ "${MERGE_DIRS/ /}" == "${MERGE_DIRS}" ]] ; then
		if [[ -n "${MERGE_ROOT}" && "${MERGE_ROOT}" != "/" ]] ; then
			/bin/rm -rf ${MERGE_ROOT}/usr/local
			/bin/rmdir ${MERGE_ROOT}/usr >& /dev/null
		fi
	else
		local MERGE_DIR
		echo ""
		for MERGE_DIR in ${MERGE_DIRS}; do
			echo "*** mk_x11_dist.sh ***: Merging into root: ${MERGE_DIR}" || die
			mkdir -p ${MERGE_DIR} || die
			ditto ${MERGE_ROOT} ${MERGE_DIR} || die

			if [[ -n "${MERGE_DIR}" && "${MERGE_DIR}" != "/" ]] ; then
				/bin/rm -rf ${MERGE_DIR}/usr/local
				/bin/rmdir ${MERGE_DIR}/usr >& /dev/null
			fi
		done
		rm -rf ${MERGE_ROOT}
	fi
}

bit_git() {
	proj=${1} ; shift
	branch=${1} ; shift
	[[ "${branch}" == "trunk" ]] && branch="master"

	if [[ -n "${branch}" && -d "${proj}" ]] ; then
		pushd ${proj}
		git checkout "${branch}" || die "Unable to checkout ${branch}"
		bit . -project ${proj} "${@}"
		popd
	fi
}

[[ -n ${XPLUGIN} ]]      && bit_git X11_Xplugin "${XPLUGIN}" ${ARCH_ALL} 
[[ -n ${X11MISC} ]]     && bit X11misc/${X11MISC}        -project X11misc       ${ARCH_ALL}
[[ -n ${X11PROTO} ]]    && bit X11proto/${X11PROTO}      -project X11proto      ${ARCH_ALL}
[[ -n ${X11LIBS} ]]     && bit X11libs/${X11LIBS}        -project X11libs       ${ARCH_ALL}
[[ -n ${QUARTZWM} ]]    && bit X11_quartz_wm/${QUARTZWM} -project X11_quartz_wm ${ARCH_ALL}
[[ -n ${X11SERVER} ]]   && bit X11server/${X11SERVER}    -project X11server     ${ARCH_ALL}
[[ -n ${X11APPS} ]]     && bit X11apps/${X11APPS}        -project X11apps       ${ARCH_ALL}
[[ -n ${X11FONTS} ]]    && bit X11fonts/${X11FONTS}      -project X11fonts      ${ARCH_ALL}

[[ -n ${X11SERVER} ]] && echo "Remember to edit the plists"

INFO_PLIST="$(eval echo ~jeremy)/src/freedesktop/pkg/X11/Applications/Utilities/XQuartz.app/Contents/Info.plist"
if [[ -n ${VERSION} ]] ; then
	defaults write "${INFO_PLIST}" CFBundleVersion "${VERSION}"
	defaults write "${INFO_PLIST}" CFBundleShortVersionString "${VERSION_TXT}"
	plutil -convert xml1 "${INFO_PLIST}"
	chmod 644 "${INFO_PLIST}"

	if [[ "${VERSION_TXT}" == "VERSION_TXT_SHORT" ]] ; then
		/opt/local/bin/gsed -i 's:beta.xml:release.xml:' "${INFO_PLIST}"
	else
		/opt/local/bin/gsed -i 's:release.xml:beta.xml:' "${INFO_PLIST}"
	fi

	cd $(eval echo ~jeremy)/src/freedesktop/pkg
	./mkpmdoc.sh
	chown -R jeremy XQuartz-${VERSION_TXT}.pmdoc
	echo "Browse to the components tab and check the box to make XQuartz.app downgradeable"
	echo "<rdar://problem/10772627>"
	echo "Press enter when done"
	sudo -u jeremy open XQuartz-${VERSION_TXT}.pmdoc
	read IGNORE
	sudo -u jeremy /Developer/usr/bin/packagemaker --verbose --doc XQuartz-${VERSION_TXT}.pmdoc --out XQuartz-${VERSION_TXT}.pkg
	sudo -u jeremy ./mkdmg.sh XQuartz-${VERSION_TXT}.pkg ${VERSION} > XQuartz-${VERSION_TXT}.sparkle.xml
fi
