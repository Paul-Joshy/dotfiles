-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50

-- Indentation settings
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.directory = os.getenv("HOME") .. "/.local/state/nvim/swap//"

-- Sticky headers
vim.opt.stc = ""

-- Set leader key to space
vim.g.mapleader = " "

-- Install lazy.nvim if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Configure plugins
require("lazy").setup({

	{
		"neovim/nvim-lspconfig",
		config = function()
			require("lsp").setup()
		end,
	},

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")

      harpoon:setup({
        settings = {
          save_on_toggle = false,
          sync_on_ui_close = false,
          key = function()
            return vim.loop.cwd()
          end,
        },
        projects = {}, -- do NOT add anything here
      })

      local map = vim.keymap.set
      map("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon Add File" })
      map("n", "<leader>m", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon Menu" })
      map("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon File 1" })
      map("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon File 2" })
      map("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon File 3" })
      map("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon File 4" })
    end,
  },


  -- Live Server: Bracey
  {
    "turbio/bracey.vim",
    cmd = { "Bracey", "BraceyStop", "BraceyReload", "BraceyEval" },
    build = "npm install --prefix server",
    ft = { "html", "css", "javascript" },
  },

  -- Theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = false,
        term_colors = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = true,
          treesitter = true,
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- Lualine
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  -- Tree-sitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "bash",
          "javascript",
          "typescript",
          "html",
          "css",
          "go",
        },
        auto_install = true,
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({
        enable = true,   -- Enable this plugin
        max_lines = 3,   -- How many lines the context window should span
        trim_scope = "outer", -- Which context lines to discard if too long
        mode = "cursor", -- or 'topline'
      })
    end,
  },


  -- File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        hijack_cursor = true,
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        view = {
          width = 30,
          preserve_window_proportions = true,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
        },
        git = {
          enable = true,
          ignore = false,
        },
      })

      -- Use `api` to avoid name collisions and buffer issues
      vim.keymap.set("n", "<leader>pv", function()
        require("nvim-tree.api").tree.toggle({ find_file = true, focus = true })
      end, { desc = "Toggle File Explorer" })
    end,
  },

  -- Git Integration
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signcolumn = true,
        numhl = true,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 1000,
          ignore_whitespace = false,
        },
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000,
        preview_config = {
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
      })

      -- Git keymaps
      vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>")
      vim.keymap.set("n", "<leader>gd", ":Gitsigns diffthis<CR>")
      vim.keymap.set("n", "<leader>gh", ":Gitsigns preview_hunk<CR>")
      vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>")
      vim.keymap.set("n", "<leader>gR", ":Gitsigns reset_buffer<CR>")
      vim.keymap.set("n", "<leader>gs", ":Gitsigns stage_hunk<CR>")
      vim.keymap.set("n", "<leader>gS", ":Gitsigns stage_buffer<CR>")
      vim.keymap.set("n", "<leader>gu", ":Gitsigns undo_stage_hunk<CR>")
    end,
  },

  -- Vim Fugitive
  {
-- Something else
    "tpope/vim-fugitive",
    config = function()
      -- Fugitive keymaps
      vim.keymap.set("n", "<leader>gg", vim.cmd.Git)
      vim.keymap.set("n", "<leader>gl", ":Git log<CR>")
      vim.keymap.set("n", "<leader>gp", ":Git push<CR>")
      vim.keymap.set("n", "<leader>gP", ":Git pull<CR>")
      vim.keymap.set("n", "<leader>gf", ":Git fetch<CR>")
      vim.keymap.set("n", "<leader>gm", ":Git merge<CR>")
      vim.keymap.set("n", "<leader>gr", ":Git rebase<CR>")
      vim.keymap.set("n", "<leader>gR", ":Git reset<CR>")
      vim.keymap.set("n", "<leader>gS", ":Git stash<CR>")
      vim.keymap.set("n", "<leader>gSP", ":Git stash pop<CR>")
      vim.keymap.set("n", "<leader>gB", ":Git branch<CR>")
      vim.keymap.set("n", "<leader>gC", ":Git commit<CR>")
      vim.keymap.set("n", "<leader>gA", ":Git add .<CR>")
      vim.keymap.set("n", "<leader>gD", ":Git diff<CR>")
      vim.keymap.set("n", "<leader>gS", ":Git status<CR>")
    end,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
          },
          cwd = vim.fn.getcwd(),
        },
      })

      telescope.load_extension("fzf")

      -- Keymaps
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>pf", function()
        builtin.find_files({
          cwd = vim.fn.getcwd(),
          hidden = false,
        })
      end, { desc = "Find files" })

      vim.keymap.set("n", "<leader>pg", function()
        builtin.git_files({
          cwd = vim.fn.getcwd(),
        })
      end, { desc = "Find git files" })

      vim.keymap.set("n", "<leader>ps", function()
        builtin.grep_string({
          search = vim.fn.input("Grep > "),
          cwd = vim.fn.getcwd(),
        })
      end, { desc = "Grep search" })

      -- Git keymaps
      vim.keymap.set("n", "<leader>gc", function()
        builtin.git_commits({
          cwd = vim.fn.getcwd(),
        })
      end, { desc = "Git commits" })

      vim.keymap.set("n", "<leader>gb", function()
        builtin.git_branches({
          cwd = vim.fn.getcwd(),
        })
      end, { desc = "Git branches" })

      vim.keymap.set("n", "<leader>gs", function()
        builtin.git_status({
          cwd = vim.fn.getcwd(),
        })
      end, { desc = "Git status" })
    end,
  },

  -- Mason (LSP installer)
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason LSP config
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "gopls",
        },
        automatic_installation = true,
      })
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
})

-- Visual mode text movement
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Saner Z commands
vim.keymap.set("n", "ZZ", ":wqa<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "ZQ", ":qa!<CR>", { noremap = true, silent = true })


-- Live server comms
-- Live Server keymaps using Bracey
vim.keymap.set("n", "<leader>ss", ":Bracey<CR>", { desc = "Start Bracey server" })
vim.keymap.set("n", "<leader>sr", ":BraceyReload<CR>", { desc = "Reload Bracey preview" })
vim.keymap.set("n", "<leader>sx", ":BraceyStop<CR>", { desc = "Stop Bracey server" })

-- Clear search highlight on <Esc>
vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR><Esc>", { noremap = true, silent = true })
vim.keymap.set("i", "<Esc>", "<Esc><Cmd>nohlsearch<CR>", { noremap = true, silent = true })
vim.keymap.set("v", "<Esc>", "<Esc><Cmd>nohlsearch<CR>", { noremap = true, silent = true })

vim.cmd("hi TreesitterContext guibg=#1e1e2e") -- or use Catppuccin highlights


-- personal plugins
-- Augment your init.lua
local function reload(module)
  package.loaded[module] = nil
  return require(module)
end

-- Bind visual keymap using reload so the latest tw_import.lua is used:
vim.keymap.set("v", "<leader>ta", function()
  reload("tw_import").import_visual()
end, { noremap = true, silent = true })

