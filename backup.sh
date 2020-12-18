#!/bin/bash

#Set constants
NOW=$(date "+%F")
NOW_SECONDS=$(date -d "$NOW" +%s)
BACKUP_DATE=$(ls ~ | grep -o -E "^Backup-[0-9]{4}-[0-9]{4}-[0-9]{4}" | cut -d "-" -f 2,3,4 | sort -n -r | head -n 1)
BACKUP_SECONDS=$(date -d "$BACKUP_dATE" +%s)
ELAPSED_dAYS=$(echo "($NOW_SECONDS - $BACKUP_SECONDS)/(60*60*24)" | bc -l)

#echo $BACKUP_DATE

last_dir="$HOME/Backup-$BACKUP_DATE"
now_dir="$HOME/Backup-$NOW"
report="$HOME/Backup-report"
source="$Home/Backup-source"

if [[ ! -d $source ]]; then
	echo ""$source" not found!"
	exit 1
fi

#if there already is dir created < 7 days ago - don't create a new one

if (($ELAPSED_DAYS > 7)) || [[ -z $BACKUP_DATE ]]; then
	#create a new dir
	mkdir $now_dir
	for file in $(ls $source); do
		cp ""$source"/"$file"" $now_dir
	done
	files=$(ls $source)
	#report has all the backedup files from source
	echo -e "Backup created at "$NOW" in "$now_dir":\n"$files"" >> $report
else
	#in case there already was this dir
	for file in $(ls $source); do
		#check for file existance. If no -> copy
		if [[ -f $last_dir/$file ]]; then
			srcSize=$(stat $source/$file -c%s)
			bcpSize=$(stat $last_dir/$file -c%s)
			if [[ $srcSize -ne $bcpSize ]]; then
				mv $last_dir/$file $last_dir/$file.$NOW
				cp $sourse/$file $last_dir/$file
				echo ""$NOW": $file was renamed to $file.$NOW and copied to $last_dir" >> $report
			fi
		else
			cp $source/$file $last_dir
			echo ""$NOW": $file was copied to $last_dir" >> $report
		fi
	done
fi

