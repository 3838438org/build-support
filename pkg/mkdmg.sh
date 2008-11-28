mkdir $1.d
mv $1.pkg $1.d
hdiutil create -srcfolder $1.d -format UDBZ -volname "$1" $1.dmg
mv $1.d/$1.dmg .
rmdir $1.d

