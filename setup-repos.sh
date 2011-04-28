#!/bin/bash -e

GIT_BASE="ssh://git.freedesktop.org/git"

[[ -e svn-xquartz ]] || svn checkout --username jeremyhu@freedesktop.org https://svn.macosforge.org/repository/xquartz svn-xquartz

[[ -e src ]] || mkdir src
cd src

if [[ ! -e xserver-1.11 ]] ; then
	git clone ${GIT_BASE}/xorg/xserver.git

	cd xserver
	git remote add jeremyhu git+ssh://jeremyhu@people.freedesktop.org/~jeremyhu/xserver.git
	git fetch --all
	git branch --set-upstream master jeremyhu/master
	git branch --track server-1.11-apple jeremyhu/server-1.11-apple
	git branch --track server-1.10-apple jeremyhu/server-1.10-apple
	git branch --track server-1.9-apple jeremyhu/server-1.9-apple
	git branch --track server-1.10-branch origin/server-1.10-branch
	git branch --track server-1.9-branch origin/server-1.9-branch
	ln -s ../../svn-xquartz/trunk/compile-xserver.sh compile
	cd ..

	cp -pPR xserver xserver-1.9
	cp -pPR xserver xserver-1.10
	mv xserver xserver-1.11
fi
