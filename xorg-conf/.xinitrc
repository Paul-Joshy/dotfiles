#!/bin/sh

# Set keyboard layout (optional)
setxkbmap us

# Set wallpaper (fixed typo)
feh --bg-fill ~/Pictures/wallpaper &

# Launch status bar (if you have one)
~/.local/bin/status-bar.sh &

# Start compositor
picom &

# ✅ Set environment correctly before launching DWM
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
# export GTK_IM_MODULE=xim
# export QT_IM_MODULE=xim
# export XMODIFIERS="@im=none"
export XCOMPOSEFILE=/usr/share/X11/locale/en_US.UTF-8/Compose

# Start dwm (must be last)
exec ~/programs/dwm/dwm

