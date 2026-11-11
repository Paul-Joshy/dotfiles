-- Minimal Neovim config (Neovim 0.12+, built-in vim.pack)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- Basic options
opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.termguicolors = true
opt.clipboard = "unnamedplus"
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.wrap = true
opt.linebreak = true
opt.breakindent = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.splitright = true
opt.splitbelow = true
opt.scrolloff = 6
opt.sidescrolloff = 6
opt.signcolumn = "yes"
opt.updatetime = 250
opt.timeoutlen = 400
opt.undofile = true
opt.completeopt = { "menu", "menuone", "noselect" }

-- Install plugins with vim.pack (built-in)
vim.pack.add({
  { src = "https://github.com/AlphaTechnolog/pywal.nvim" },
  { src = "https://github.com/catppuccin/nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/tpope/vim-fugitive" },
  { src = "https://github.com/tpope/vim-rhubarb" },
  { src = "https://github.com/mbbill/undotree" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.x") },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/junegunn/limelight.vim" },
  { src = "https://github.com/folke/zen-mode.nvim" },
  { src = "https://github.com/preservim/vim-pencil" },
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
  { src = "https://github.com/nvim-mini/mini.nvim" },
  { src = "https://github.com/catgoose/nvim-colorizer.lua" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/tpope/vim-surround" },
})

-- Theme (pywal)
local ok_pywal, pywal = pcall(require, "pywal")
if ok_pywal then
  pywal.setup()
  vim.cmd.colorscheme("pywal")
else
  require("catppuccin").setup({ flavour = "mocha", transparent_background = false })
  vim.cmd.colorscheme("catppuccin-mocha")
end

-- Git signs
require('gitsigns').setup({
  signs = {
    add = { text = '│' },
    change = { text = '│' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
})

-- Statusline
require('lualine').setup({
  options = {
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    globalstatus = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
})


-- Treesitter
require("nvim-treesitter").setup({})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "python", "javascript", "typescript", "typescriptreact", "javascriptreact", "html", "css", "json", "bash", "sh", "markdown", "go", "yaml", "toml" },
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})

-- Inline color previews: #hex, #RRGGBBAA, 0xRRGGBB / 0xAARRGGBB, rgb(), hsl(), named colors
local ok_colors, colorizer = pcall(require, "colorizer")
if ok_colors then
  colorizer.setup({
    filetypes = { "*" },
    options = {
      parsers = {
        names = { enable = true },
        hex = {
          default = true,
          rrggbbaa = true, -- #RRGGBBAA
          aarrggbb = true, -- 0xAARRGGBB, 0xRRGGBB, 0xRGB (shell/Hyprland/Android style)
        },
        rgb = { enable = true },
        hsl = { enable = true },
      },
      display = {
        mode = "foreground", -- colour the code itself; also "background", "underline", "virtualtext"
      },
    },
  })
end

-- LSP + Mason
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "pyright", "ts_ls", "bashls", "jsonls" },
  automatic_enable = true,
})

local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
    end
    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
    map("n", "gr", vim.lsp.buf.references, "Find references")
    map("n", "K", vim.lsp.buf.hover, "Hover")
    map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
    map("n", "<leader>d", vim.diagnostic.open_float, "Diagnostics")
    map("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
    map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
  end,
})

-- Completion
require("blink.cmp").setup({
  keymap = { preset = "default" },
  appearance = { nerd_font_variant = "mono" },
  completion = { documentation = { auto_show = true } },
  sources = { default = { "lsp", "path", "snippets", "buffer" } },
})

-- Telescope
require("telescope").setup({
  defaults = {
    layout_strategy = "horizontal",
    layout_config = { horizontal = { preview_width = 0.55 }, width = 0.9, height = 0.85 },
    sorting_strategy = "ascending",
    prompt_position = "top",
  },
})
local tb = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", tb.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", tb.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", tb.current_buffer_fuzzy_find, { desc = "Buffer grep" })

-- General keymaps
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search" })
vim.keymap.set("n", "<leader>w", "<cmd>write<CR>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>e", "<cmd>Explore<CR>", { desc = "Explorer" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Right window" })

-- Move lines (fixed mappings)
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Diagnostics
vim.diagnostic.config({ virtual_text = true, signs = true, underline = true, update_in_insert = false, severity_sort = true })

-- Markdown setup with working limelight + "focus" writing mode
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "en_us" }
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true
    vim.opt_local.conceallevel = 2

    vim.g.limelight_conceal_ctermfg = 240
    vim.g.limelight_conceal_guifg = "#6c7086"
    vim.g.limelight_paragraph_span = 1

    vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<CR>", { buffer = true, desc = "Zen" })
    vim.keymap.set("n", "<leader>p", "<cmd>PencilToggle<CR>", { buffer = true, desc = "Pencil" })
    vim.keymap.set("n", "<leader>l", "<cmd>Limelight!!<CR>", { buffer = true, desc = "Limelight" })

    -- Space x: tick/untick the checkbox on this line (or every selected line)
    local function toggle_checkbox(first, last)
      for lnum = first, last do
        local line = vim.fn.getline(lnum)
        local new = line:gsub("%[ %]", "[x]", 1)
        if new == line then new = line:gsub("%[[xX]%]", "[ ]", 1) end
        if new ~= line then vim.fn.setline(lnum, new) end
      end
    end
    vim.keymap.set("n", "<leader>x", function()
      local l = vim.fn.line(".")
      toggle_checkbox(l, l)
    end, { buffer = true, desc = "Toggle checkbox" })
    vim.keymap.set("x", "<leader>x", function()
      local a, b = vim.fn.line("v"), vim.fn.line(".")
      toggle_checkbox(math.min(a, b), math.max(a, b))
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
    end, { buffer = true, desc = "Toggle checkboxes" })

    -- Focus writing mode toggle
    vim.keymap.set("n", "<leader>W", function()
      local focus = vim.b.focus_writing_mode or false
      if focus then
        -- Turn off focus mode
        pcall(vim.cmd, "ZenMode")
        pcall(vim.cmd, "PencilOff")
        if vim.fn.exists(":Limelight") == 2 then
          pcall(vim.cmd, "Limelight!")
        end
        local ok_rm, rm = pcall(require, "render-markdown")
        if ok_rm then
          if type(rm.enable) == "function" then
            pcall(rm.enable)
          elseif type(rm.toggle) == "function" then
            pcall(rm.toggle)
          end
        end
        vim.b.completion = nil
        pcall(function() vim.opt_local.complete = ".,w,b,u,t,i" end)
        vim.b.focus_writing_mode = false
        vim.notify("Focus writing mode disabled", vim.log.levels.INFO)
      else
        -- Turn on focus mode
        pcall(vim.cmd, "ZenMode")
        pcall(vim.cmd, "PencilOff")
        pcall(vim.cmd, "Pencil")
        if vim.fn.exists(":Limelight") == 2 then
          pcall(vim.cmd, "Limelight!")
          pcall(vim.cmd, "Limelight")
        end
        local ok_rm, rm = pcall(require, "render-markdown")
        if ok_rm then
          if type(rm.disable) == "function" then
            pcall(rm.disable)
          elseif type(rm.toggle) == "function" then
            pcall(rm.toggle)
          end
        end
        pcall(function()
          local ok_b, blink = pcall(require, "blink.cmp")
          if ok_b and blink.hide then
            blink.hide()
          end
        end)
        vim.b.completion = false
        pcall(function() vim.opt_local.complete = "" end)
        vim.b.focus_writing_mode = true
        vim.notify("Focus writing mode enabled", vim.log.levels.INFO)
      end
    end, { buffer = true, desc = "Toggle focus writing mode" })
  end,
})

-- Persistent undo
local undodir = vim.fn.stdpath('data') .. '/undo'
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, 'p')
end
vim.opt.undodir = undodir
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.undoreload = 10000

-- Undotree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Toggle Undotree' })

-- Oil.nvim
require("oil").setup({
  default_file_explorer = true,
  view_options = {
    show_hidden = true,
  },
})
vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })
