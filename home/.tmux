# Use hjkl for directional pane navigation
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

run ~/.config/tmux/plugins/catppuccin/tmux/catppuccin.tmux

# Force bash as login shell
set -g default-shell /bin/bash
# Run it as a login shell
set -g default-command bash
