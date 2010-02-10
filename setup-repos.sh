#GIT_BASE="git://anongit.freedesktop.org/git"
GIT_BASE="ssh://git.freedesktop.org/git"

#svn checkout --username jeremyhu@freedesktop.org https://svn.macosforge.org/repository/xquartz
#mv xquartz svn-xquartz

mkdir src
cd src
#curl -LO http://superb-west.dl.sourceforge.net/sourceforge/mesa3d/MesaLib-6.5.2.tar.bz2
#tar -xjvf MesaLib-6.5.2.tar.bz2
#curl -LO http://superb-west.dl.sourceforge.net/sourceforge/mesa3d/MesaLib-7.0.4.tar.bz2
#tar -xjvf MesaLib-7.0.4.tar.bz2
#curl -LO ftp://invisible-island.net/xterm/xterm-229.tgz
#tar -xjzf xterm-229.tgz
#git-clone ${GIT_BASE}/fontconfig
#git-clone ${GIT_BASE}/xorg/app/xauth.git
#git-clone ${GIT_BASE}/xorg/app/xinit.git
#git-clone ${GIT_BASE}/xorg/util/lndir.git
#git-clone ${GIT_BASE}/xorg/lib/libX11.git
#git-clone ${GIT_BASE}/xorg/lib/libXfont

git clone ${GIT_BASE}/xorg/xserver.git
mv xserver xserver-master

for branch in 1.4 1.5 1.6 1.7 ; do
	git clone --reference xserver-master ${GIT_BASE}/xorg/xserver.git
	mv xserver xserver-${branch}
	cd xserver-${branch}
	git branch --track xorg-server-${branch}-apple origin/xorg-server-${branch}-apple
	git checkout -f xorg-server-${branch}-apple
	ln -s ../compile-xserver.sh compile.sh
	cd ..
done
