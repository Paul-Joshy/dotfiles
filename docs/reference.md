# Reference

## Packages and paths

Every package mirrors `$HOME`. Stow links each file to the same path under your home folder.

| Package | Files it links |
|---|---|
| `bat` | `~/.config/bat/config` |
| `btop` | `~/.config/btop/btop.conf` |
| `doom` | `~/.config/doom/{init,config,packages}.el` |
| `ghostty` | `~/.config/ghostty/config.toml` |
| `htop` | `~/.config/htop/htoprc` |
| `kitty` | `~/.config/kitty/kitty.conf` |
| `nvim` | `~/.config/nvim/init.lua`, `nvim-pack-lock.json` |
| `qutebrowser` | `~/.config/qutebrowser/config.py`, `greasemonkey/`, `styles/` |
| `scripts` | `~/.local/bin/*` (see [Scripts](#scripts)) |
| `skyland` | `~/.config/skyland/skyland.toml`, layout scripts, `themes/` |
| `skylandbar` | `~/.config/skylandbar/skylandbar.toml`, `themes/liquid-glass.toml` |
| `wal` | `~/.config/wal/templates/`, `~/.config/wal/scripts/skylandbar` |
| `yazi` | `~/.config/yazi/{yazi,keymap}.toml`, `init.lua`, `plugins/`, wallpaper helpers |
| `zathura` | `~/.config/zathura/zathurarc` |
| `zsh` | `~/.zshenv` (sets `ZDOTDIR`), `~/.config/zsh/.zshrc` |

## Skyland keybindings

Main mode. `alt` is the Option key.

| Keys | Action |
|---|---|
| `alt-h` `alt-j` `alt-k` `alt-l` | Focus left, down, up, right |
| `alt-shift-h/j/k/l` | Move the window left, down, up, right |
| `alt-1` ... `alt-9` | Go to workspace 1 to 9 |
| `alt-shift-1` ... `alt-shift-9` | Send the window to workspace 1 to 9 |
| `alt-tab` | Previous workspace |
| `alt-shift-tab` | Move the workspace to the next monitor |
| `alt-shift-m` | Move the window to the next monitor |
| `alt-shift-f` | Fullscreen without outer gaps |
| `alt-minus` | Toggle the iTerm2 scratchpad |
| `alt-shift-minus` / `alt-equal` | Shrink / grow the window |
| `alt-shift-t` | Master layout for this workspace |
| `alt-shift-enter` | Swap with the master window |
| `alt-shift-v` | Floating layout for this workspace |
| `alt-shift-r` | `skyland env` |
| `alt-enter` | Open kitty |
| `alt-shift-space` | Open Terminal |
| `alt-b` / `alt-z` | Open Brave / Zen |
| `alt-d` | Cyberdeck launcher |
| `alt-shift-d` / `alt-shift-a` / `alt-shift-n` | Cyberdeck HUD / audio / messages |
| `alt-shift-;` | Enter service mode |

Service mode (after `alt-shift-;`):

| Keys | Action |
|---|---|
| `esc` | Reload the config and return to main mode |
| `backspace` | Close every window except the focused one |
| `alt-shift-h/j/k/l` | Join with the window on that side |

## Yazi keybindings

| Keys | Action |
|---|---|
| `Ctrl-w` | Set the hovered image as wallpaper and retheme with pywal |
| `m` `w` | Move selected files to `~/Downloads/wallpapers/` |
| `m` `d` | Move selected files to `~/Documents/` |
| `o` | Open the selected file |

## Scripts

All live in `scripts/.local/bin/`.

| Script | Usage | What it does |
|---|---|---|
| `wallpaper-wal` | `wallpaper-wal <image>` | Sets the wallpaper, generates a pywal palette, rewrites Ghostty's colours, updates yazi, Skyland and Skylandbar |
| `wallpaper-with-wal` | `wallpaper-with-wal <image>` | Earlier, simpler version of `wallpaper-wal` |
| `wallpaper` | `wallpaper <image>...` | Sets the wallpaper only |
| `wal-apply-all` | `wal-apply-all <image>` | Generates a palette and reloads kitty, the bar and yazi |
| `wal-reload` | `wal-reload` | Reapplies the current palette without changing the wallpaper |
| `skylandbar-network-speed` | run by Skylandbar | Updates the bar's upload and download rates from macOS interface counters |
| `jrnl-fzf` | `jrnl-fzf [query]` | Fuzzy-finds whole jrnl entries and copies the chosen one to the clipboard |

## Selected shell aliases

From `zsh/.config/zsh/.zshrc`.

| Alias | Expands to |
|---|---|
| `cd` | `z` (zoxide) |
| `ls` | `lsd -lah` |
| `cat`, `less` | `bat` |
| `r` | `ranger` |
| `zshrc` | Edit and reload the shell config |
| `nvimrc` | Edit the Neovim config |
| `appid` | List every window's bundle id (for Skyland rules) |
| `jj`, `je` | `jrnl`, `jrnl --edit` |
