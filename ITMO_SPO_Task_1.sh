#!/bin/bash

# Ask the user for enter directory path
# path example: /C/Users/AlexeySeverin/Desktop/Practika/*

echo "Enter directory path (format /../...../*):"
read path

# Delete previous .xls file
rm report.xls
# Add top line in .xls file
echo -e "NAME \t EXTENSION \t MODIFIED \t SIZE \t DURATION" >> report.xls
# Publish information for any files in directory
for f in $path
do
	# Delete text from the start line to the last match
	filename="${f##*/}"

	# Delete extention, for get name
	NAME=$(echo "$filename" | sed 's/\.[^.]*$//')
	echo $NAME

	# Delete name, for get extention
  	EXTENSION=$(echo "$filename" | sed 's/^.*\.//')
	echo $EXTENSION

	# Get file modified date
	MODIFIED=$(stat -c "%y" "$f" | awk '{print $1}')
	echo $MODIFIED

	# Get file size
  	SIZE=$(du -sh "$f" | awk '{print $1}')
	echo $SIZE

	if [[ -d "$f" ]]; then
 		EXTENSION="dir"
 		SIZE="dir"
	fi

	# Get video duration
	DURATION=$(ffprobe -v quiet -print_format compact=print_section=0:nokey=1:escape=csv -show_entries format=duration "$f")
	
	# Write results to the report.xls
	echo -e "$NAME \t $EXTENSION \t $MODIFIED \t $SIZE \t $DURATION" >> report.xls
done
