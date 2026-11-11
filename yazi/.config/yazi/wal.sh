#!/bin/zsh
if [ -n "$1" ] && [ -f "$1" ]; then
    $HOME/.local/bin/wallpaper-wal "$1"
    exit 0
fi
# Try to get from args
for f in "$@"; do
    if [ -f "$f" ]; then
        $HOME/.local/bin/wallpaper-wal "$f"
        exit 0
    fi
done
exit 1
