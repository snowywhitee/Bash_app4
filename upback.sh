#!/bin/bash
if [[ ! -d ""$HOME"/restore" ]]; then
	mkdir ""$HOME"/restore"
fi
backup_dir=$(find $HOME -maxdepth 0 -name "Backup-*" | sort -n | tail -n 1)

if [[ ! -d $backup_dir ]]; then
	echo "Backup doesn't exist!"
	exit 1
fi

for file in $(ls $backup_dir | grep -E -v "[0-9]{4}-[0-9]{2}-[0-9]{2}"); do
	cp ""$backup_dir"/"$file"" ""$HOME"/restore/"$file""
done
