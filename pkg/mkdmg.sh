#!/bin/bash

. ~/.bashrc

verString=$1

mkdir ${verString}.d
mv ${verString}.pkg ${verString}.d/X11.pkg
hdiutil create -srcfolder ${verString}.d -format UDBZ -volname "${verString}" ${verString}.dmg
mv ${verString}.d/X11.pkg ${verString}.pkg
rmdir $1.d

dosign ${verString}.dmg

DSA=$(./sign_update.rb ${verString}.dmg sparkle_priv.pem)
SIZE=$(wc -c ${verString}.dmg | awk '{print $1}')
echo "      <item>"
echo "         <title>${verString}</title>"
echo "         <sparkle:releaseNotesLink>http://xquartz.macosforge.org/trac/wiki/ChangeLog</sparkle:releaseNotesLink>"
echo "         <pubDate>$(date)</pubDate>"
echo "         <enclosure url=\"http://xquartz.macosforge.org/downloads/${verString}.dmg\" sparkle:version=\"$2\" sparkle:shortVersionString=\"${verString}\" length=\"${SIZE}\" type=\"application/octet-stream\" sparkle:dsaSignature=\"${DSA}\" />"
echo "      </item>"
