#!/usr/bin/env bash

cat /home/user/Documents/dotfiles/scripts/workmodes | dmenu | echo i $(date +"%Y/%m/%d %H:%M:%S") $(awk '{print $1}') >> ~/Documents/personal/ledger/logtimes
