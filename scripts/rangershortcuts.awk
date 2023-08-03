#!/usr/bin/env bash
# awk script to update ranger shortcuts

# example
# h ~/
# map yth shell cp %s ~/
# map mth shell mv %s ~/
# map gth cd ~/ 

awk '{
	print "map yt"$1" shell cp %s "$2
	print "map mt"$1" shell mv %s "$2
	print "map gt"$1" cd "$2"\n"
}'
