#!/usr/bin/env bash
# awk script to update ranger shortcuts

awk 'FS="=" {
	print "map yt"$1" shell cp %s "$2
	print "map mt"$1" shell mv %s "$2
	print "map gt"$1" cd "$2"\n"
}'
