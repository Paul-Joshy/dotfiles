#source "$HOME/.openclaw/completions/openclaw.zsh"
export PATH="$HOME/.local/bin:$PATH"

alias ranger="source ranger"
alias r="ranger"
alias zshrc="nvim ~/.config/zsh/.zshrc && source ~/.config/zsh/.zshrc"
alias nvimrc="nvim ~/.config/nvim/init.lua"
alias ls="lsd -lah"
alias zathura="zathura -p /opt/homebrew/lib/zathura"

export PATH=$PATH:$(go env GOPATH)/bin
# export PATH=$PATH:/opt/homebrew/opt/skyland/libexec/.build/Skyland.app/Contents/MacOS/
function sky(){
  /opt/homebrew/opt/skyland/libexec/.build/Skyland.app/Contents/MacOS/Skyland
}
alias appid="skyland list-windows --all --format '%{app-bundle-id}'"


function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
                zle reset-prompt
	fi
	rm -f -- "$tmp"
}

alias cd="z"
eval "$(zoxide init zsh)"
#
# Powerlevel10k instant prompt disabled

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

# Prompt customization
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' check-for-untracked-files true
zstyle ':vcs_info:git:*' stagedstr ' +'
zstyle ':vcs_info:git:*' unstagedstr ' *'
zstyle ':vcs_info:git:*' untrackedstr ' ?'
zstyle ':vcs_info:git:*' formats ' %F{240}(%b%c%u)%f'
zstyle ':vcs_info:git:*' actionformats ' %F{240}(%b|%a%c%u)%f'
zstyle ':vcs_info:*' enable git

alias ginit="git init && git add . && git commit -am 'init' && git status"
alias gupdate="git add . && git commit -am "update" && git status"

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
source <(fzf --zsh)

# opencode
export PATH=$HOME/.opencode/bin:$PATH


function ff() {
    aerospace list-windows --all | fzf --bind 'enter:execute(bash -c "aerospace focus --window-id {1}")+abort'
}

wallpaper() {
    if [[ -z "$1" ]]; then
        echo "Usage: wallpaper /path/to/image"
        return 1
    fi

    local image_path
    image_path="$(cd "$(dirname "$1")" 2>/dev/null && pwd)/$(basename "$1")"

    if [[ ! -f "$image_path" ]]; then
        echo "Error: File not found: $1"
        return 1
    fi

    osascript - "$image_path" <<'APPLESCRIPT'
on run argv
    set imagePath to item 1 of argv
    tell application "System Events"
        tell every desktop to set picture to imagePath
    end tell
end run
APPLESCRIPT
}

# Pywal
wal() {
    if command -v pywal >/dev/null 2>&1 || [ -f "$HOME/.local/bin/wal" ] || [ -f "$HOME/.pyenv/shims/wal" ]; then
        command wal "$@"
    elif command -v wal >/dev/null 2>&1; then
        command wal "$@"
    else
        pipx run pywal "$@"
    fi
}
# Auto-generate kitty/sketchybar/yazi/nvim configs from wal
export PATH="$HOME/.local/bin:$PATH"

# Use bat for preview in some tools
export BAT_THEME="Dracula"
export MANPAGER="sh -c 'col -bx | nvim -c \"set ft=man\" -'"
export MANROFFOPT="-c"
alias cat='bat --style=plain'
alias less='bat'




stat() {
  if [ "$#" -eq 0 ]; then
    printf 'Usage: waabout "About text"\n' >&2
    return 2
  fi

  whatshell profile set-about "$*" --json
}

alias q="pmset displaysleepnow"
alias sd="sudo shutdown -h now"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# cat todos
# alias todo="nvim todos"

alias om="opencode mini --continue"

# function jj() {
#   if jrnl -from today --short 2>/dev/null | grep -q "no entries found"; then
#     jrnl
#   else
#     jrnl -from today --edit
#   fi
# }
alias jj="jrnl"
alias je="jrnl --edit"

jrnl @todo
