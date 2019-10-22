#!/bin/bash

cd ../ru_base/
find -name PROMPTS > file
mkdir temp
while read line; do
	sed 's/[[:upper:]]/\l&/g' $line > temp/PROMPTS;
	cp -f temp/PROMPTS $line;
done < file
rm -r temp
rm file

