-- Cozy, minimal Neovim config with Catppuccin, lualine, and sane defaults

-- Bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git', lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set leader key early
vim.g.mapleader = ' '

require('lazy').setup({
  -- Catppuccin theme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'catppuccin-mocha'
    end,
  },
  -- Lualine (statusline)
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup {
        options = { theme = 'catppuccin' }
      }
    end,
  },
  -- Cozy file explorer
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup {}
    end,
  },
  -- Fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local telescope = require('telescope')
      local builtin = require('telescope.builtin')
      
      telescope.setup({
        defaults = {
          file_ignore_patterns = {
            "node_modules",
            ".git",
            "target",
            "dist",
            "build",
          },
        },
      })

      -- Debug function to check if telescope is working
      vim.keymap.set('n', '<leader>pt', function()
        print("Telescope loaded:", telescope ~= nil)
        print("Builtin loaded:", builtin ~= nil)
        builtin.find_files()
      end, { noremap = true, silent = true })
    end,
  },
  -- Treesitter for better syntax
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        highlight = { enable = true },
        indent = { enable = true },
      }
    end,
  },
})

-- Sane, cozy defaults
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 300
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Keymaps for comfort
vim.keymap.set('n', '<leader>pv', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>pf', function()
  require('telescope.builtin').find_files()
end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>/', function()
  require('telescope.builtin').live_grep()
end, { noremap = true, silent = true })

-- Move selected text up/down with proper indentation
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true }) 
