 #Enabl Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set font weight
ZSH_THEME_FONT_WEIGHT="bold"

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY

# Completion system
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' rehash true

# Directory stack
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

# Key bindings
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey '^[[Z' reverse-menu-complete
bindkey '^?' backward-delete-char
bindkey '^[[3~' delete-char
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# Aliases
alias ls='ls --color=auto'
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Prompt customization
autoload -Uz vcs_info
precmd() { vcs_info }
# zstyle ':vcs_info:git:*' formats ' %F{240}(%b)%r%f'
zstyle ':vcs_info:git:*' formats ' %F{240}(%b)'
zstyle ':vcs_info:*' enable git

# Set prompt
setopt PROMPT_SUBST
PROMPT='%F{blue}%~${vcs_info_msg_0_}%f %F{green}❯%f '

# Syntax highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# Auto suggestions
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null

# FZF integration
if [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]; then
    source /usr/share/doc/fzf/examples/key-bindings.zsh
    source /usr/share/doc/fzf/examples/completion.zsh
fi

# Environment variables
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'
export LESS='-R --use-color -Dd+r$Du+b'
export DOOMDIR="$HOME/.config/doom"
# export MANPAGER='less -R --use-color -Dd+r -Du+b'

# Path
export PATH="$HOME/.local/bin:$PATH"

# Colors for less
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline 

alias bashrc="nvim ~/.bashrc && source ~/.bashrc"
alias zshrc="nvim ~/.zshrc && source ~/.zshrc"
alias vimrc="vim ~/.vimrc && source ~/.vimrc"
alias nvimrc="nvim ~/.config/nvim"

# Yazi config
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

alias ta="task add"
alias t="task"
alias j="task project:jobs"
alias n="task next limit:1"
alias p='f() { local proj; proj=$(task _projects | fzf) && [ -n "$proj" ] && task project:"$proj" list; }; f'
alias w="task waiting"
alias l="task completed"

# Zensciences
alias z="task project:zensciences"
alias zl="task completed project:zensciences"
alias za="task add project:zensciences"

# alias s="shutdown 0"
alias r="source ranger"

homestow() {
  if [ "$#" -eq 0 ]; then
    echo "Usage: homestow <package1> [package2 ...]"
    return 1
  fi

  for pkg in "$@"; do
    echo "📦 Stowing '$pkg' to \$HOME"
    stow --target="$HOME" "$pkg"
  done
}

source ~/.profile

#Xephyr
# alias xdwm="sudo make clean install && cat $HOME/programs/xephyr/dwm.sh | sh"
export MANPAGER="nvim +Man!"
alias dwmconfig="cd $HOME/programs/dwm/ && nvim config.h"
alias stconfig="cd $HOME/programs/st/ && nvim config.h"
alias g="llm -m gemini-2.5-flash"
alias em="devour emacsclient -c"
alias doom="/home/paul/.emacs.d/bin/doom"

alias bat="batcat"
alias restartemacs="doom sync && killall emacs && emacs --daemon && em ~/.config/doom/"

export GOOGLE_API_KEY="AIzaSyBl0aHaNDqz-KxiidnwbmhPRXHVbwB8V2g"
export TERM=xterm-256color
export TERMINFO=/usr/share/terminfo
alias m="mods -C"

# ChatGPT asked me to put this
# ✅ Force proper UTF-8 locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# ✅ Avoid broken input method frameworks
# export GTK_IM_MODULE=xim
# export QT_IM_MODULE=xim
# export XMODIFIERS="@im=none"

# ✅ Fix libxkbcommon input bugs by using a valid Compose file
export XCOMPOSEFILE=/usr/share/X11/locale/en_US.UTF-8/Compose

unset XMODIFIERS
unset GTK_IM_MODULE
unset QT_IM_MODULE
