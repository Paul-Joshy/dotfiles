#!/bin/bash

BOOKMARKS_FILE="$HOME/bookmarks.txt"

# Get the first URL from clipboard
url=$(xclip -o -selection clipboard | grep -Eo 'https?://[^ ]+' | head -n 1)

# Exit if no URL is found
[[ -z "$url" ]] && exit 1

# Prompt for a name
name=$(dmenu -p "Bookmark name:" <&-)

# Exit if already bookmarked
grep -q "^$url " "$BOOKMARKS_FILE" 2>/dev/null && exit 0

# Save the bookmark
echo "$url #$name" >> "$BOOKMARKS_FILE"

# Show notification
notify-send "✅ Bookmark saved" "$url #$name"

