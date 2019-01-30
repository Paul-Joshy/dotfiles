#!/usr/bin/env bash

cat shortcuts| ./profileshortcuts.awk >> ~/.profile-shortcuts &&
cat shortcuts| ./rangershortcuts.awk >> ~/.config/ranger/shortcuts.conf &&
source ~/.profile
