-- ++ LSP ++
-- pip install python-lsp-server
require'lspconfig'.pylsp.setup{
  capabilities = capabilities,
}

-- npm install -g pyright
require'lspconfig'.pyright.setup{
  capabilities = capabilities,
}
-- pip install -U jedi-language-server
require'lspconfig'.jedi_language_server.setup{
  capabilities = capabilities,
}
