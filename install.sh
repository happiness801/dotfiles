#/bin/sh
# This is a work in progress :)

cwd="`pwd`"
dest="$HOME"
ext="dotfilesbak"

echo "Installing from [$cwd] to [$dest]..."
echo && echo
cd $dest

for f in $cwd/.[^.]*; do
	basename=`basename $f`
	if [ ! -L $f ] && [ ! -d $f ] && [[ "$basename" != ".gitignore" ]]; then
		# TODO: Make creation of backups optional / maybe prompt if differences are found
		echo "##### $basename #####"
		# If destination file exists and they are different, create backup and display the differences
		[[ -e $dest/$basename ]] && ( ! cmp $dest/$basename $f ) && cp $dest/$basename $dest/$basename.$ext && diff $dest/$basename $f
		cp $f $dest
		echo && echo
	fi
done

echo "Backups saved:"
ls -la $dest/.*.$ext 2>/dev/null

echo 
echo "To remove backups:"
echo "  rm $dest/.*.$ext    OR    ./remove-backups.sh"
