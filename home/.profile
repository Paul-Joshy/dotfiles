# ~/.profile: executed by the command interpreter for login shells.
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

[ -s "/home/user/.jabba/jabba.sh" ] && source "/home/user/.jabba/jabba.sh"

# User commands

# Dotfiles
dotfiles=~/Documents/dotfiles
profile=$dotfiles/home/.profile
zshrc=$dotfiles/home/.zshrc
bashrc=$dotfiles/home/.bashrc
vimrc=$dotfiles/home/.vimrc
i3=$dotfiles/config/i3

function edit(){ vi $@ && source $@; } # edit files and source them
alias profile="edit $profile"
# alias bashrc="edit $bashrc"
# alias zshrc="edit $zshrc"
alias vimrc="vi $vimrc"
alias i3config="vi $i3/config"

# General
alias wifilist='watch -c "unbuffer nmcli dev wifi"' # outputs the list of wifi
function wificonnect() { nmcli --ask device wifi connect $@; } # prompt which asks for wifi password after typing wifi SSID
function fcd() { cd $@ || mkdir -p $@ && cd $@; } # changes directory to a user provided directory or creates a new one if not present
function li(){ sudo light -S $@; } # changes the brighness percent
alias play='playerctl play'
alias pause='playerctl pause'
alias next='playerctl next'
alias prev='playerctl previous'
function apti() { sudo apt install -y $@; }
function debug(){ vi $(which $@); }
# function rcd(){pushd $1 && $(sed "%/s/rcd//g") && popd; }
function rcd(){pushd $@ && popd;}

# Personal work
personal=~/Documents/personal/
servers=~/Documents/servers/

# Development
alias npms='npm i -s'
alias mongostart='sudo service mongod start' # starts mongodb server
function killp () { fuser -k $@/tcp;  } # kills process based on port
alias logs='tail -f logs.txt' # outputs a live stream of a file that's being written live
alias vimrc='vi ~/.vimrc'
function logwrite(){ unbuffer $@ | tee -a logs.txt; }
alias serverstart='logwrite $(cat startscript) || logwrite npm start'
alias internet='speedtest-cli && ping -c 4 8.8.8.8'
alias xresources='vi $dotfiles/home/.Xresources && xrdb $dotfiles/home/.Xresources'
alias t='tmux'
export NODE_OPTIONS=--max_old_space_size=4096 # to fix the javascript memory running out issue

# Git commands
function gits(){echo $(alias | grep "$@") && git $@; }
alias gitignore='vi .gitignore'
alias gcop='git checkout -p'
alias gitconfig='vi $dotfiles/home/.gitconfig'

# Music
alias youtube-dl='youtube-dl --ignore-errors --continue'
alias removecomments='sed "/#.*/d"'
function parsecomments(){ cat $@ | sed "/#.*/d" | awk '{print $1}'; }
alias comments='sed -i "/#.*/!d"' 
alias download_music='youtube-dl --extract-audio --audio-format mp3 $(parsecomments download-list) -o '%(title)s.%(ext)s' && removecomments download-list >> ~/Music/Downloaded/downloaded-list && comments download-list'

# Videos
alias download_video='youtube-dl $(parsecomments download-list) -o '%(title)s.%(ext)s' && removecomments download-list >> ~/Videos/Downloaded/downloaded-list && comments download-list'

# Todo
todoadd(){ echo $@ >> ~/Documents/todo && reset; }
caplog(){ echo $@ >> ~/Documents/captains_log && clear; }
vidadd(){ echo $@ >> ~/Videos/Downloaded/download-list; }
alias todoedit='vi ~/Documents/todo'
alias todoview='cat ~/Documents/todo | removecomments'
alias ta='todoadd'
alias cl='caplog'
alias te='todoedit'
alias tv='todoview'
alias va='vidadd'

# Screenshots
# clipboard='/tmp/%F_%T_$wx$h.png' -e 'xclip -selection clipboard -target image/png -i+"i" $f'

# Random
function cowstomize(){cowsay -f $@ zoo wee mama;}

fortune -s | lolcat

source ~/.config/up/up.sh
source $dotfiles/work/work_aliases.sh
