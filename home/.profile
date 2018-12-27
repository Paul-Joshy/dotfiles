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
vimrc=$dotfilrs/home/.vimrc
i3=$dotfiles/config/i3

function edit(){ vi $@ && source $@; } # edit files and source them
alias profile="edit $profile"
# alias bashrc="edit $bashrc"
# alias zshrc="edit $zshrc"
alias vimrc="vi $vimrc"
alias i3config="vi $i3/config"

alias wifilist='watch -c "nmcli dev wifi"' # outputs the list of wifi
function wificonnect() { nmcli --ask device wifi connect $@; } # prompt which asks for wifi password after typing wifi SSID
function fcd() { cd $@ || mkdir -p $@ && cd $@; } # changes directory to a user provided directory or creates a new one if not present

# Development
alias mongostart='sudo service mongod start' # starts mongodb server
# alias serverstart='unbuffer npm start | tee -a logs.txt'
function killp () { fuser -k $@/tcp;  } # kills process based on port
alias logs='tail -f logs.txt' # outputs a live stream of a file that's being written live
alias vimrc='vi ~/.vimrc'
function logwrite(){ unbuffer $@ | tee -a logs.txt; }
alias serverstart='logwrite npm start'
alias internet='speedtest-cli && ping 8.8.8.8'
alias xresources='vi $dotfiles/home/.Xresources && xrdb $dotfiles/home/.Xresources'

fortune -s
