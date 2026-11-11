# dotfiles

My desktop, terminal and editor configuration. One wallpaper drives the colours of everything: the window manager, the status bar, the terminals, the file manager and the browser.

The current set comes from my macOS machine, a tiling setup built on [Skyland](#credits) and Skylandbar with a glass look. My Arch Linux laptop (dwm, st, dmenu) will join it under its own packages. The configs I wrote in 2018 are kept in [`legacy-2018/`](legacy-2018/) as a record of where this started.

## Quick start

```sh
git clone https://github.com/Paul-Joshy/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh            # dry run: shows what would be linked
./install.sh --apply    # links every package into $HOME
```

`install.sh` uses [GNU Stow](https://www.gnu.org/software/stow/). Each top-level folder is a package that mirrors `$HOME`, so nothing is copied and every file stays editable from the repo.

## Documentation

The docs follow [Diátaxis](https://diataxis.fr/): each page does one job.

| If you want to... | Read |
|---|---|
| Set this up on a fresh Mac, step by step | [Tutorial: your first install](docs/tutorial.md) |
| Do one specific thing | [How-to guides](docs/how-to.md): retheme from a wallpaper, add a window rule, install one package |
| Look something up | [Reference](docs/reference.md): packages, keybindings, scripts |
| Understand why it is built this way | [Explanation](docs/explanation.md): the colour pipeline and the thinking behind it |

## Packages

| Package | What it configures |
|---|---|
| `skyland` | Tiling window manager: workspaces, window rules, keybindings, themes |
| `skylandbar` | Status bar with the liquid-glass theme |
| `wal` | pywal templates and the hook that pushes a new palette everywhere |
| `scripts` | Small tools in `~/.local/bin`: wallpaper and theme scripts, `jrnl-fzf`, a network-speed widget |
| `zsh` | Shell: aliases, zoxide, fzf, plugins (`ZDOTDIR` lives in `~/.config/zsh`) |
| `nvim` | Neovim, configured in Lua |
| `doom` | Doom Emacs |
| `yazi` | Terminal file manager, with plugins that set the wallpaper from the file you are on |
| `kitty`, `ghostty` | Terminals |
| `qutebrowser` | Keyboard-driven browser, coloured from Xresources |
| `zathura` | Minimal PDF viewer, used for live previews of LaTeX and Typst |
| `btop`, `htop`, `bat` | Monitoring and paging |

## Credits

- Most Skyland themes are adapted from [43PR/dotfiles](https://github.com/43PR/dotfiles) (MIT). Each file says so in its header.
- Colour generation is [pywal](https://github.com/dylanaraps/pywal).
- See [CREDITS.md](CREDITS.md) for the full list.
