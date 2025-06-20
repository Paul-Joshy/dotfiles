#!/usr/bin/env bash

cat /home/user/Documents/dotfiles/scripts/workmodes | dmenu -l 10 -i | echo i $(date +"%Y/%m/%d %H:%M:%S") $(awk '{print $1}') >> ~/Documents/personal/ledger/logtimes
