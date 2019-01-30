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

# sources
source ~/.profile-shortcuts
source ~/.config/up/up.sh
source $dt/work/work_aliases.sh


# Dotfiles
dotfiles=~/Documents/dotfiles
profile=$dt/home/.profile
zshrc=$dt/home/.zshrc
bashrc=$dt/home/.bashrc
vimrc=$dt/home/.vimrc
i3=$dt/config/i3


function edit(){ vi $@ && source $@; } # edit files and source them
alias profile="edit $profile"
# alias bashrc="edit $bashrc"
# alias zshrc="edit $zshrc"
alias vimrc="vi $vimrc"
alias i3config="vi $i3/config"

# General
function fcd() { cd $@ || mkdir -p $@ && cd $@; } # changes directory to a user provided directory or creates a new one if not present
function li(){ sudo light -S $@; } # changes the brighness percent
function apti() { sudo apt install -y $@; }
function debug(){ vi $(which $@); }
function rcd(){ awk -F"," '{print "pushd " $1 " && " $2 " && popd"}' | bash; }
alias r="ranger"
alias p="pwd"
alias removecomments='sed "/#.*/d"'
function parsecomments(){ cat $@ | sed "/#.*/d" | awk '{print $1}'; }
alias comments='sed -i "/#.*/!d"' 

# Internet
alias wifilist='watch -c "unbuffer nmcli dev wifi"' # outputs the list of wifi
alias internet='speedtest-cli && ping -c 4 8.8.8.8' # check for internet speed
function wificonnect() { nmcli --ask device wifi connect $@; } # prompt which asks for wifi password after typing wifi SSID

#Shortcuts
alias add_shortcuts="cat ~/dotfiles/scripts/shortcuts | sh ~/dotfiles/scripts/profilesshortcuts.awk >> ~/.profile-shortcuts && source ~/.profile && source ~/.profile-shortcuts"
alias update_ranger_shortcuts="cat $dt/scripts/shortcuts | /$dt/scripts/rangershortcuts.awk > $dt/config/ranger/shortcuts.conf"
alias update_profile_shortcuts="cat $dt/scripts/shortcuts | /$dt/scripts/profileshortcuts.awk > ~/.profile-shortcuts"
alias update_shortcuts="update_ranger_shortcuts && update_profile_shortcuts && source ~/.profile-shortcuts"
s=$dt/scripts/shortcuts
alias es="vi $s && update_shortcuts"
alias s="cat $s"

# Emacs and spacemacs
alias emacs_copy='pushd $ec/ && rm -fdR ~/.emacs.d/* && stow -vt ~/.emacs.d .emacs.d && popd'
alias spacemacs_copy='pushd $ec/spacemacs/ && rm -fdR ~/.emacs.d/* && stow -vt ~/.emacs.d/ .emacs.d && popd'

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
alias l="ledger -f $lg/main.ledger"

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
alias xresources='vi $dt/home/.Xresources && xrdb $dt/home/.Xresources'
alias t='tmux'
export NODE_OPTIONS=--max_old_space_size=4096 # to fix the javascript memory running out issue
function bashtouch(){ touch $@ && echo "#!/usr/bin/env bash" >> $@ && chmod +x $@ && vi $@;  } # create bash file, add shebangs and give exec permissions

# Git commands
alias gitfind='find -name .git | sed "/Documents/!d"' #finds all projects initialized with git in documents
function gits(){echo $(alias | grep "$@") && git $@; }
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

# Logs
todoadd(){ echo $@ >> ~/Documents/todo && reset; }
caplog(){ echo $@ >> ~/Documents/captains_log && clear; }
vidadd(){ echo $@ >> ~/Videos/Downloaded/download-list; }
tipsadd() {echo $@ >> ~/Documents/tips; }
alias todoedit='vi ~/Documents/todo'
alias todoview='cat ~/Documents/todo | removecomments'
alias ta='todoadd'
alias cl='caplog'
alias te='todoedit'
alias tv='todoview'
alias va='vidadd'

# Random
function cowstomize(){cowsay -f $@ zoo wee mama;}

# fortune -s | lolcat
sort -R ~/Documents/tips | head -n1


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
