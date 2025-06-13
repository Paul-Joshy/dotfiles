local M = {}

function M.setup()
  local lspconfig = require("lspconfig")
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- LSP keymaps
  local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  end

  -- Setup language servers
  lspconfig.lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  lspconfig.bashls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  lspconfig.tsserver.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  lspconfig.html.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  lspconfig.cssls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  lspconfig.emmet_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
  })

  -- Enable LSP status in statusline
  vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = true,
    severity_sort = true,
  })
end

return M 
  
