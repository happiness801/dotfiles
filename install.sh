#/bin/sh
# This is a work in progress :)

cwd="`pwd`"
dest="$HOME"

echo "Installing from [$cwd] to [$dest]..."
cd $dest

for f in $cwd/.[^.]*; do
	basename=`basename $f`
	if [ ! -L $f ] && [ ! -d $f ] && [[ "$basename" != ".gitignore" ]]; then
		# TODO: Maybe make a backup of the destination file...
		echo "$basename"
		cp $f $dest
	fi

done


