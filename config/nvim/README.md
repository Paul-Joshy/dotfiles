# Cozy Minimal Neovim Config

A warm, minimal Neovim setup with the Catppuccin theme, a beautiful statusline, and sensible defaults. Powered by [lazy.nvim](https://github.com/folke/lazy.nvim) for easy plugin management.

## Features
- 🌈 **Catppuccin Mocha** theme for a cozy look
- 🛤️ **Lualine** statusline (Catppuccin styled)
- 🗂️ **NvimTree** file explorer
- 🔍 **Telescope** fuzzy finder
- 🌳 **Treesitter** for better syntax highlighting
- 🧠 **LSP** support with Mason
- 🤖 **Autocompletion** with nvim-cmp
- 🐙 **Git Integration** with gitsigns, fugitive, and telescope
- 🎯 Sane, modern defaults

## Installation
1. **Clone or symlink this config** to `~/.config/nvim`.
2. **Open Neovim**: Plugins will install automatically on first launch.

```bash
# If not already in place:
ln -s /path/to/this/folder ~/.config/nvim
nvim
```

## Keybindings

### General
- `<leader>` is set to space
- `J` and `K` in visual mode: Move selected text up/down while maintaining indentation

### File Explorer (NvimTree)
- `<leader>pv` — Toggle file explorer
- `o` — Open file/directory
- `a` — Create file/directory
- `d` — Delete file/directory
- `r` — Rename file/directory
- `q` — Close file explorer

### File Search (Telescope)
- `<leader>pf` — Find files in current directory
- `<leader>pg` — Find git files (ignores .gitignore)
- `<leader>ps` — Grep search in current directory

### Git Integration
#### Gitsigns (Inline Git Status)
- `<leader>gb` — Show blame for current line
- `<leader>gd` — Show diff for current file
- `<leader>gh` — Preview hunk
- `<leader>gr` — Reset hunk
- `<leader>gR` — Reset buffer
- `<leader>gs` — Stage hunk
- `<leader>gS` — Stage buffer
- `<leader>gu` — Undo stage hunk

#### Fugitive (Git Commands)
- `<leader>gg` — Open Git status
- `<leader>gl` — View git log
- `<leader>gp` — Git push
- `<leader>gP` — Git pull
- `<leader>gf` — Git fetch
- `<leader>gm` — Git merge
- `<leader>gr` — Git rebase
- `<leader>gR` — Git reset
- `<leader>gS` — Git stash
- `<leader>gSP` — Git stash pop
- `<leader>gB` — Git branch
- `<leader>gC` — Git commit
- `<leader>gA` — Git add all
- `<leader>gD` — Git diff
- `<leader>gS` — Git status

#### Telescope Git
- `<leader>gc` — Browse git commits
- `<leader>gb` — Browse git branches
- `<leader>gs` — Browse git status

### LSP Features
- `gd` — Go to definition
- `gr` — Go to references
- `K` — Show hover information
- `<leader>rn` — Rename symbol
- `<leader>ca` — Code actions
- `<leader>d` — Show diagnostics
- `[d` — Previous diagnostic
- `]d` — Next diagnostic

### Autocompletion
- `<C-Space>` — Trigger completion
- `<Tab>` — Next completion item or expand snippet
- `<S-Tab>` — Previous completion item
- `<CR>` — Confirm selection
- `<C-b>` — Scroll documentation up
- `<C-f>` — Scroll documentation down

## Default Settings
- Line numbers and relative line numbers
- Mouse support
- Smart case search
- No line wrapping
- Break indent
- True color support
- 2-space indentation
- Expand tabs to spaces
- Smart indentation
- Sticky headers while scrolling

## Dependencies
- [ripgrep](https://github.com/BurntSushi/ripgrep) for Telescope grep search
- [fd-find](https://github.com/sharkdp/fd) for Telescope file search
- [build-essential](https://packages.ubuntu.com/build-essential) for compiling some plugins

## Customization
- Edit `init.lua` to add or tweak plugins and settings
- Change the Catppuccin flavor in the theme config (latte, frappe, macchiato, mocha)
- Modify keybindings in their respective plugin configurations

---

Enjoy your cozy Neovim! ☕ 
