-- ++ LSP ++
require'lspconfig'.gopls.setup{
  settings = {
    cmd = { "gopls" },
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
    client.server_capabilities.document_range_formatting = false
    client.server_capabilities.document_formatting = false
  end
}
