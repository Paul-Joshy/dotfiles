local M = {}

function M.setup()
  -- Global indentation settings
  vim.opt.autoindent = true
  vim.opt.smartindent = true
  vim.opt.cindent = true
  vim.opt.copyindent = true
  vim.opt.preserveindent = true
  vim.opt.expandtab = true
  vim.opt.tabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.softtabstop = 2

  -- Filetype-specific settings
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "lua", "javascript", "typescript", "html", "css", "python", "bash", "sh" },
    callback = function()
      vim.opt_local.autoindent = true
      vim.opt_local.smartindent = true
      vim.opt_local.cindent = true
    end,
  })

  -- Indent on new line
  vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
      vim.opt.autoindent = true
      vim.opt.smartindent = true
    end,
  })
end

return M 
