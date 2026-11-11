# Tutorial: your first install

By the end of this tutorial you will have the terminal, editor and file manager configs linked on a Mac, and you will have rethemed everything from a single wallpaper. It takes about fifteen minutes.

You need macOS with [Homebrew](https://brew.sh) installed. Everything else, we install as we go.

## 1. Get the tools

```sh
brew install stow neovim yazi zoxide fzf bat lsd btop
brew install --cask kitty
pipx install pywal
```

These are the packages this tutorial uses. The window manager and bar come later, once the basics work.

## 2. Clone the repo

```sh
git clone https://github.com/Paul-Joshy/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

## 3. See what would change

```sh
./install.sh zsh nvim yazi kitty scripts wal
```

This is a dry run. Stow prints every link it would create in your home folder. If it reports a conflict, you already have a file at that path; the [how-to guide](how-to.md#move-an-existing-config-aside) shows how to move it aside safely.

## 4. Link the packages

```sh
./install.sh --apply zsh nvim yazi kitty scripts wal
```

Open a new terminal. Your prompt now loads from `~/.config/zsh/.zshrc`, and `nvim` opens with the Lua config.

## 5. Retheme from a wallpaper

Pick any image and run:

```sh
wallpaper-wal ~/Pictures/some-image.jpg
```

Watch the desktop, the kitty window and yazi's colours change together. That one command set the wallpaper, generated a sixteen-colour palette, and pushed it to every app that reads it.

## Where next

- Add the window manager and bar: `./install.sh --apply skyland skylandbar`
- Look up the keybindings in the [reference](reference.md#skyland-keybindings).
- Read [how the colour pipeline works](explanation.md#one-wallpaper-every-colour).
