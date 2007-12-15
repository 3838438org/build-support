#GIT_BASE="git://anongit.freedesktop.org/git"
GIT_BASE="ssh://git.freedesktop.org/git"

svn checkout --username jeremyhu@freedesktop.org http://svn.macosforge.org/repository/xquartz
mv xquartz svn-xquartz

mkdir src
cd src
curl -LO http://superb-west.dl.sourceforge.net/sourceforge/mesa3d/MesaLib-6.5.2.tar.bz2
tar -xjvf MesaLib-6.5.2.tar.bz2
curl -LO http://superb-west.dl.sourceforge.net/sourceforge/mesa3d/MesaLib-7.0.2.tar.bz2
tar -xjvf MesaLib-7.0.2.tar.bz2
git-clone ${GIT_BASE}/fontconfig
git-clone ${GIT_BASE}/xorg/app/xauth.git
git-clone ${GIT_BASE}/xorg/app/xinit.git
git-clone ${GIT_BASE}/xorg/util/lndir.git
git-clone ${GIT_BASE}/xorg/lib/libX11.git

git-clone ${GIT_BASE}/xorg/xserver.git
cd xserver
git-branch --track xorg-server-1.2-apple origin/xorg-server-1.2-apple
git-branch --track xorg-server-1.4-apple origin/xorg-server-1.4-apple
git-branch --track server-1.3-branch origin/server-1.3-branch
git-branch --track server-1.4-branch origin/server-1.4-branch
git-checkout -f xorg-server-1.2-apple
ln -s ../../svn-xquartz/trunk/compile-xserver.sh compile.sh

cd ../..
ln -s src/xserver
