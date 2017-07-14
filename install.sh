#/bin/sh
# This is a work in progress :)

cwd="`pwd`"
dest="$HOME"

echo "Installing from [$cwd] to [$dest]..."
cd $dest

for f in *; do
	echo "file = $f"
	if [ ! -L $f ] && [ ! -d $f ]; then
		echo "Is file"
	fi
done


