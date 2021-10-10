-- ++ LSP ++
require'lspconfig'.gopls.setup{
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    -- Disabled default autoformatter until it is fixed
    client.resolved_capabilities.document_range_formatting = false
    client.resolved_capabilities.document_formatting = false
    lsp_on_attach(client, bufnr)
  end
}
