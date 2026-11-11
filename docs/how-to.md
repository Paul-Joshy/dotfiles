# How-to guides

Short recipes for one task each. They assume the repo is cloned to `~/dotfiles`.

## Install a single package

```sh
cd ~/dotfiles
./install.sh nvim            # dry run first
./install.sh --apply nvim
```

## Move an existing config aside

Stow will not overwrite a real file. If the dry run reports a conflict:

```sh
mv ~/.config/nvim ~/.config/nvim.bak.$(date +%Y%m%d)
./install.sh --apply nvim
```

## Retheme everything from a wallpaper

```sh
wallpaper-wal path/to/image.jpg
```

Or, inside yazi, hover over an image and press `Ctrl-w`.

To reapply the current palette without changing the wallpaper:

```sh
wal-reload
```

## Make a new app float in Skyland

Find the app's bundle id with the `appid` alias (it lists every window's bundle id), then add a rule to `skyland/.config/skyland/skyland.toml`:

```toml
[[on-window-detected]]
if.app-id = 'com.example.app'
run = ['layout floating']
```

Reload Skyland: press `alt-shift-;` to enter service mode, then `esc`.

## Switch a workspace between tiling and floating

- `alt-shift-t`: master layout
- `alt-shift-v`: floating

Both call `skyland/.config/skyland/set-workspace-layout.sh`.

## Remove a package

```sh
cd ~/dotfiles
stow -D -t "$HOME" nvim
```

This removes the links and leaves the files in the repo untouched.
