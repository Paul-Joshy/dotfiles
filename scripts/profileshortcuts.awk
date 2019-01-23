#!/usr/bin/env bash
# awk script to update ranger shortcuts

# $var=~/path
# alias var="cd /path"
# function mvvar(){ mv $@ /path;}
# function cpvar(){ cp $@ /path;}

awk '{
	print $1"="$2
	print "alias "$1"=\42cd "$2"\42"
	print "function mv"$1"(){ mv $@ "$2";}"
	print "function cp"$1"(){ cp $@ "$2";}\n"
}'
