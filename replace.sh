#!/bin/bash

set -e
input=names_2018.txt
while IFS= read -r line
do
	sed "/url:*/c\url: $line" content/post/2018/"$line".md
	echo "$line"
#	head -n5 ${line}.md
done 
