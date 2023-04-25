-- ++ LSP ++

-- require'lspconfig'.perlls.setup{
--   capabilities = capabilities,
-- }

-- Deserves a try: https://metacpan.org/pod/PLS
require'lspconfig'.perlpls.setup{
  capabilities = capabilities,
}
