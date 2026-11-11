# Explanation

Why this setup looks and works the way it does.

## Small tools, joined by text

Most of this repo is the Unix philosophy applied to a desktop. Each tool does one job: yazi browses files, zathura shows PDFs, bat pages text, pywal makes colours. They talk to each other through plain files and signals, not through a framework. A palette is a JSON file in `~/.cache/wal`; a reload is `killall -USR1 kitty`. When one piece is replaced, nothing else has to change.

I come back to command-line tools because they are reliable and elegant rather than trendy. That is what I admire in the Debian way of doing things, even though my own laptop runs Arch.

## One wallpaper, every colour

Theming twelve apps by hand means twelve places to drift out of sync. Instead, the wallpaper is the single source of truth:

1. `wallpaper-wal` sets the desktop image and runs `wal -i`, which writes a sixteen-colour palette to `~/.cache/wal/`.
2. pywal fills the templates in `wal/.config/wal/templates/` (Skyland, Skylandbar, yazi, the Zen browser) with that palette.
3. The hook in `wal/.config/wal/scripts/skylandbar` applies the new Skyland theme and reloads kitty and the bar. `wallpaper-wal` also rewrites Ghostty's colours and rebuilds bat's cache.

Change the image and the whole desktop follows.

## Respecting defaults

I customise everything I use, but I understand why defaults exist: most people never change them, and they should not have to. This repo is opinionated for me. The docs try to make every opinion easy to undo, which is why the installer runs dry by default and refuses to overwrite your files.

## Why a glass theme

Skyland and Skylandbar use a translucent "liquid glass" look that matches the rest of macOS. Consistency with the system matters more to me than standing out from it; the tiling is where the power is, and the look should not fight the platform it runs on.
