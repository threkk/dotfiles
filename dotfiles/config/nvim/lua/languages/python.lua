-- ++ LSP ++
-- pip install python-lsp-server
require'lspconfig'.pylsp.setup{
  capabilities = capabilities,
  on_attach = lsp_on_attach
}

-- npm install -g pyright
require'lspconfig'.pyright.setup{
  capabilities = capabilities,
  on_attach = lsp_on_attach
}
-- pip install -U jedi-language-server
require'lspconfig'.jedi_language_server.setup{
  capabilities = capabilities,
  on_attach = lsp_on_attach
}
