# source files
alias r=". ranger"
# alias vi="nvim"
# alias vim="nvim"
alias em="emacsclient -c"
alias profile="vi ~/.profile && source ~/.zshrc"
alias zshrc="vi ~/.zshrc && source ~/.zshrc"
alias vimrc="vi ~/.vimrc && source ~/.zshrc"

DOTFILES="/Users/paul/Documents/dotfiles"

# common function
function fcd() { cd $@ || mkdir -p $@ && cd $@; } # changes directory to a user provided directory or creates a new one if not present

#scripting
alias removecomments='sed "/#.*/d"'
function parsecomments(){ cat $@ | sed "/#.*/d" | awk '{print $1}'; }
alias comments='sed -i "/#.*/!d"' 

## Shortcuts
s=~/Documents/dotfiles/scripts/shortcuts
sc=~/Documents/dotfiles/scripts/

alias update_ranger_shortcuts="cat $s | removecomments | ~/Documents/dotfiles/scripts/rangershortcuts.awk > $sc/shortcuts.conf"
alias update_profile_shortcuts="cat $s | removecomments | ~/Documents/dotfiles/scripts/profileshortcuts.awk > ~/.profile-shortcuts"
alias update_shortcuts="update_ranger_shortcuts && update_profile_shortcuts && source ~/.profile-shortcuts"

alias es="vi $s && update_shortcuts"
alias s="cat $s| less"


# alias ladd="echo $s | ./ledgerparser.awk"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

## Emacs
export PATH="$HOME/.emacs.d/bin:$PATH"
export PATH="$HOME/.config/emacs/bin:$PATH"
export PATH="$HOME:~/Documents/dotfiles/scripts/rangershortcuts.awk:$PATH"
export PATH="$HOME:~/Documents/dotfiles/scripts/profileshortcuts.awk:$PATH"

#ytfzf
export PATH="$HOME/cli-apps/ytfzf:$PATH"

#regular scripts
# export PATH="$HOME/Documents/dotfiles/scripts:$PATH"


function wallpaper() {
    wallpaper_script="tell application \"Finder\" to set desktop picture to POSIX file \"$HOME/$1\""
    osascript -e $wallpaper_script
}
