#!/bin/bash

dir="/home/lidja/Laba4/trash"

if (( $# != 1)); then
	echo "Too many/few arguments, should be 1"
	exit 1
elif [[ ! -f "$1" ]]; then
	echo "File doesn't exist"
	exit 1
elif [[ ! -e $dir ]]; then
	mkdir $dir
fi

id=$(uuidgen)
ln "$1" ""$dir"/"$id""
rm "$1" && echo ""$1":"$(realpath $1)":"$id"" >> ""$dir"/trash.log"
