# sources
source ~/.profile-shortcuts

export PATH="$HOME/scripts:$PATH"

## Shortcuts
alias update_ranger_shortcuts="cat $HOME/programs/dotfiles/scripts/shortcuts| $HOME/programs/dotfiles/scripts/rangershortcuts.awk > $HOME/.config/ranger/shortcuts.conf"
alias update_profile_shortcuts="cat $HOME/programs/dotfiles/scripts/shortcuts | $HOME/programs/dotfiles/scripts/profileshortcuts.awk > ~/.profile-shortcuts"
alias update_shortcuts="update_ranger_shortcuts && update_profile_shortcuts && source ~/.profile-shortcuts"

s=$HOME/programs/dotfiles/scripts/shortcuts
alias es="nvim $s && update_shortcuts"
# alias s="cat $s| less"
alias r="source ranger"

alias profile="nvim ~/.profile && source ~/.profile"
