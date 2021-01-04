# ~t/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

[ -s "/home/paul/.jabba/jabba.sh" ] && source "/home/paul/.jabba/jabba.sh"

# User commands

# sources
source ~/.profile-shortcuts
# source ~/.config/up/up.sh
source $dt/work/work_aliases.sh
source /etc/zsh_command_not_found

# Dotfiles
dotfiles=~/Documents/dotfiles
profile=$dt/home/.profile
zshrc=$dt/home/.zshrc
bashrc=$dt/home/.bashrc
vimrc=$dt/home/.vimrc
i3=$dt/config/i3
rcconf=$dt/config/ranger/rc.conf


function edit(){ vi $@ && source $@; } # edit files and source them
alias profile="edit $profile"
alias rcconf="vi $rcconf"
alias waliases="vi $dt/work/work_aliases.sh && source $profile"
# alias bashrc="edit $bashrc"
# alias zshrc="edit $zshrc"
alias vimrc="vi $vimrc"
alias i3config="vi $i3/config"
alias vvim="vim -u NONE"
alias tl="timeline"

# General
function fcd() { cd $@ || mkdir -p $@ && cd $@; } # changes directory to a user provided directory or creates a new one if not present
function li(){ sudo light -S $@; } # changes the brighness percent
alias lumos="li 100"
alias nox="li 10"
function apti() { sudo apt install -y $@; }
alias update="sudo apt update -y"
alias upgrade="sudo apt dist-upgrade -y"
function debug(){ vi $(which $@); }
function rcd(){ awk -F"," '{print "pushd " $1 " && " $2 " && popd"}' | bash; }
alias r="ranger"
alias n="nnn"
alias p="pwd"
alias removecomments='sed "/#.*/d"'
function parsecomments(){ cat $@ | sed "/#.*/d" | awk '{print $1}'; }
alias comments='sed -i "/#.*/!d"' 
alias rs="reset"
alias rsh="rs && h"
alias imagetag="exiftool"
# Internet
alias wifilist='watch -c "nmcli dev wifi"' # outputs the list of wifi
alias wifirescan='nmcli dev wifi rescan'
alias internet='speedtest-cli && ping -c 4 8.8.8.8' # check for internet speed
alias net="internet"
alias wificonnect="sc && ./wificonnect ; cd -"
alias wifiautoconnect="sc && ./wifiautoconnect; cd -"
alias wconnect="wificonnect"
alias winfo="sc && ./winfo | less; cd -"
alias wpass="sc && ./winfo | grep psk; cd -"
alias waconnect="wifiautoconnect"
alias a="alias"
alias wlist="wifilist"
alias wscan="wifirescan"
alias wspeed="internet"
alias rnet="sudo systemctl restart NetworkManager.service"
# alias xclip="xclip -selection c"
alias history-uniq="history | awk '{$1=\"\"; print;}'| sort| uniq"
alias l="ls"
# alias v="vim"
alias sound="alsamixer"
alias slsd="sls deploy"
alias slsdf="sls deploy --force"

# dunst
alias pausenoti='notify-send "DUNST_COMMAND_PAUSE"'
alias resnoti='notify-send "DUNST_COMMAND_RESUME"'

# Custom scripts
PATH="$HOME/scripts:$PATH"
export PATH

alias hostip="sh /$dt/scripts/hostip"

## Display
alias big="sh ~/.screenlayout/big.sh"
alias small="sh ~/.screenlayout/small.sh"
alias lock="sh $dt/scripts/i3lock.sh"

#git
alias gitremote="sh $dt/scripts/gitremote"
alias gpo="git pull origin"
alias gr="gitremote"

# Typos
alias gti="git"
alias itg="git"
alias usdo="sudo"

## Time logging
alias in="$dt/scripts/recordstart.bash| sh"
alias out="$dt/scripts/recordend.bash| sh"
alias shutdown="out && shutdown"
alias reboot="out && reboot"
alias i3shutdown="out && i3-msg-exit"
alias clip="xclip -selection C"

## Shortcuts
alias update_ranger_shortcuts="cat $dt/scripts/shortcuts | /$dt/scripts/rangershortcuts.awk > $dt/config/ranger/shortcuts.conf"
alias update_profile_shortcuts="cat $dt/scripts/shortcuts | /$dt/scripts/profileshortcuts.awk > ~/.profile-shortcuts"
alias update_shortcuts="update_ranger_shortcuts && update_profile_shortcuts && source ~/.profile-shortcuts"

s=$dt/scripts/shortcuts
alias es="vi $s && update_shortcuts"
alias s="cat $s| less"

# Google translate
function translateenglish(){ trans --brief :en "$@"; }
alias tren="translateenglish"
function translategerman(){ trans --brief :de "$@"; }
alias trde="translategerman"
function translatespanish(){ trans --brief :es "$@"; }
alias tres="translatespanish"

# Emacs and spacemacs
alias emacs_copy='pushd $ec/ && rm -fdR ~/.emacs.d/* && stow -vt ~/.emacs.d .emacs.d && popd'
alias spacemacs_copy='pushd $ec/spacemacs/ && rm -fdR ~/.emacs.d/* && stow -vt ~/.emacs.d/ .emacs.d && popd'

# Buku aliases
alias webo="buku -t --np --oa"

# function emacs(){
# 	pushd $ec/ &&
# 		rm -fdR ~/.emacs.d/* &&
# 		stow -vt ~/.emacs.d/ .emacs.d &&
# 		emacs $1 &&
# 		popd;
# }


# function spacemacs(){
# 	pushd $ec/spacemacs/ &&
# 		rm -fdR ~/.emacs.d/* &&
# 		stow -vt ~/.emacs.d/ .emacs.d &&
# 		emacs $1 &&
# 		popd;
# }

# Ledger
alias lf="ledger -f $lg/main.ledger"
alias t="ledger -f $lg/logtimes"
alias lbtm="echo 'Ledger Balance this month' && lf b -S amount --flat --period \"this month\"" # Ledger balance this month
alias lblm="echo 'Ledger balance last month' && lf b -S amount --flat --period \"last month\"" # Ledger balance last month

# Personal work
personal=~/Documents/personal/
servers=~/Documents/servers/

# Development
alias npms='npm i -s'
alias mongostart='sudo service mongod start' # starts mongodb server
alias mongozip="mongorestore --drop --gzip"
function findp () { ps -A | grep $(fuser $@/tcp) } # finds process based on port
alias killvid="fuser -k /dev/video0"
function killp () { fuser -k $@/tcp;  } # kills process based on port
alias logs='tail -f logs.txt' # outputs a live stream of a file that's being written live
alias vimrc='vi ~/.vimrc'
function logwrite(){ unbuffer $@ | tee -a logs.txt; }
alias serverstart='logwrite $(cat startscript) || logwrite npm start'
alias xresources='vi $dt/home/.Xresources && xrdb $dt/home/.Xresources'
export NODE_OPTIONS=--max_old_space_size=4096 # to fix the javascript memory running out issue
function bashtouch(){ touch $@ && echo "#!/usr/bin/env bash" >> $@ && chmod +x $@ && vi $@;  } # create bash file, add shebangs and give exec permissions
alias ngs="ng s"
alias ngsp="ng s --prod"
# alias ip="$dt/scripts/ip"
function ip(){
	$dt/scripts/ip;
	$dt/scripts/ip | head -4 | tail -1| xclip -selection C &&
		echo "Copied ip to clipboard!"
}
function hb(){ cat $@| hastebin| xclip -selection c; } # Import file to hastebin and store link in clipboard

# Git commands
alias gitfind='find -name .git | sed "/Documents/!d"' #finds all projects initialized with git in documents
function gits(){echo $( alias | grep "git $@") && git $@; }
alias gitignore='vi .gitignore'
alias gcop='git checkout -p'
alias gitconfig='vi $dt/home/.gitconfig'
# Music & Video
alias youtube-dl='youtube-dl --ignore-errors --continue'
alias download_music='youtube-dl --extract-audio --audio-format mp3 $(parsecomments download-list) -o "%(title)s.%(ext)s" && removecomments download-list >> ~/Music/Downloaded/downloaded-list && comments download-list'
alias download_video='youtube-dl $(parsecomments download-list) -o "%(title)s.%(ext)s" && echo $(pwd) >> $dv/downloaded-list && removecomments download-list >> ~/Videos/Downloaded/downloaded-list && comments download-list'

#playerctl commands
alias play='playerctl play'
alias pause='playerctl pause'
alias next='playerctl next'
alias prev='playerctl previous'

# # Logs
# todoadd(){ echo $@ >> ~/Documents/todo && reset; }
# caplog(){ echo $@ >> ~/Documents/captains_log && clear; }
# vidadd(){ echo $@ >> ~/Videos/Downloaded/download-list; }
# tipsadd() {echo $@ >> ~/Documents/tips; }
# alias todoedit='vi ~/Documents/todo'
# alias todoview='cat ~/Documents/todo | removecomments'
# alias ta='todoadd'
# alias cl='caplog'
# alias te='todoedit'
# alias tv='todoview'
# alias va='vidadd'

# Random
function cowstomize(){cowsay -f $(cat $sc/formats.txt | fzf) zoo wee mama;}
alias cows="cowstomize"
alias font="~/scripts/fontpreview| sh"

# fun stuff
# alias usetheforceluke='$(fc -ln -1) --force'
# alias nowwatchmewhip='$(fc -ln -1) --watch'
# alias justfuckingdoit='sudo sh -c "$(fc -ln -1)"'


# fortune -s | lolcat
# sort -R ~/Documents/tips | head -n1


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
export EDITOR="vim"
