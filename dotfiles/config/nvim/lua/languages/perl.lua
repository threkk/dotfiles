-- ++ LSP ++
-- Current
require'lspconfig'.perlls.setup{
  on_attach = lsp_on_attach
}
-- Deserves a try: https://metacpan.org/pod/PLS
-- require'lspconfig'.perlpls.setup{}
