#!/bin/sh
# This is a work in progress :)

#cwd="`pwd`"
#filesDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# got much of this from stackoverflow
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
	DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
	SOURCE="$(readlink "$SOURCE")"
	[[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
filesDir="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

destinationDir="$HOME"

echo "Linking from [$filesDir] to [$destinationDir]..."
cd $destinationDir

for f in $filesDir/.[^.]*; do
	basename=`basename $f`
	if [[ "$basename" != ".gitignore" ]]; then
		# TODO: Maybe make a backup of the destination file...
		echo "$basename"
		ln --symbolic --verbose --interactive $f $destinationDir
	fi

done
