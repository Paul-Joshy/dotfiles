#!/usr/bin/env bash

# Prompt for a free-form, multi-word todo item
input=$(dmenu -p "Enter zensciences task:")

# If input is non-empty, add the task and notify the user
if [ -n "$input" ]; then
  task add "$input" pro:zensciences
  notify-send "Added zensciences task!" "$input"
fi

