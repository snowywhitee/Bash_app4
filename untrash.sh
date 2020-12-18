#!/bin/bash

dir="/home/lidja/Laba4/trash/"
log="/home/lidja/Laba4/trash/trash.log"
HOME="/home/lidja/Laba4"

if (( $# != 1)); then
	echo "Too many/few arguments! Should be 1"
	exit 1;
elif [[ ! -d $dir ]]; then
	echo ""$dir" doesn't exist"
elif [[ ! -f $log ]]; then
	echo ""$log" file doesn't exist"
fi


for i in $(grep -s "$1" $log); do
	name=$(echo $i | awk -F ':' '{print $1}')
	location=$(echo $i | awk -F ':' '{print $2}')
	id=$(echo $i | awk -F ':' '{print $3}')
	link=""$dir""$id""
	if [[ -f $link ]]; then
		read -p "Restore "$location"/"$name"? [y/N] " choice
		case "$choice" in
			[yY])
				path=$(dirname "$location")
				if [[ -d $path ]]; then
					#save to $dir
					if [[ -f ""$path"/"$1"" ]]; then
						read -p "File exists. New name: " newName
						ln $link ""$path"/"$newName""
						rm $link
						echo "Restored to: "$path"/"$newName""
					else
						ln $link ""$path"/"$1""
						rm $link
						echo "Restored to: "$path"/"$1""
					fi
					exit 0
				else
					#save to $HOME
					if [[ -f "/home/lidja/Laba4/"$1"" ]]; then
						read -p ""$dir" doesn't exist. File "$1" already at "$HOME". New name: " newName
						ln $link ""$HOME"/"$newName""
						rm $link
					else
						ln $link ""$HOME"/"$1""
						rm $link
					fi
					echo "Successfuly restored to "$HOME""
					exit 0
				fi
				;;
			*)
				continue
				;;
		esac
	fi
done

