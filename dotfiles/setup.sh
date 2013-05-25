#!/bin/bash
# Script to automatically create dotfile symlinks

FROM=$(cd "$(dirname "$0")"; pwd)

if [[ -d "$1" ]]; then
	TO="$1"
else
	TO="$HOME"
fi

cd $FROM

for FILE in `find -L . -maxdepth 1 -wholename './.*' -printf '%P\n'`; do
	TO_FILE="$TO/$FILE"

	if [[ -e $TO_FILE ]] || [[ -h $TO_FILE ]]; then
		read -p "File $TO_FILE exists, overwrite? [Y/n] " -n 1 -r

		if [[ $REPLY =~ ^[Nn]$ ]]; then
			echo
			echo "Skipping $FILE"
			echo

			continue
		fi

		rm -rf $TO_FILE
	fi

	echo "Creating symlink to $FILE"
	echo

	ln -sT "$FROM/$FILE" $TO_FILE
done
