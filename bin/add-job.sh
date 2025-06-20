#!/usr/bin/env bash

# Prompt for a free-form, multi-word todo item
input=$(dmenu -p "Enter job item:")

# If input is non-empty, add the task and notify the user
if [ -n "$input" ]; then
  task add "$input" pro:jobs
  notify-send "Added task!" "$input"
fi

