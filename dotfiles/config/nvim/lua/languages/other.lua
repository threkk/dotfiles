-- ++ BASH ++
-- LSP: https://github.com/mads-hartmann/bash-language-server
require'lspconfig'.bashls.setup{
  capabilities = capabilities,
  on_attach = lsp_on_attach
}

-- ++ CSS,HTML,JSON ++
-- LSP: npm i -g vscode-langservers-extracted
require'lspconfig'.cssls.setup{
  capabilities = capabilities,
  on_attach = lsp_on_attach
}
require'lspconfig'.html.setup{
  capabilities = capabilities,
  on_attach = lsp_on_attach
}
require'lspconfig'.jsonls.setup{
  capabilities = capabilities,
  on_attach = lsp_on_attach
}

-- ++ Docker ++
-- LSP: npm install -g dockerfile-language-server-nodejs
require'lspconfig'.dockerls.setup{
  capabilities = capabilities,
  on_attach = lsp_on_attach
}

-- ++ GraphQL ++
-- LSP: npm install -g graphql-language-service-cli
require'lspconfig'.graphql.setup{
  capabilities = capabilities,
  on_attach = lsp_on_attach
}

-- ++ SQL ++
-- LSP: go get github.com/lighttiger2505/sqls
require'lspconfig'.sqls.setup{
  capabilities = capabilities,
  on_attach = lsp_on_attach
}

-- ++ Terraform ++
-- LPS: https://github.com/hashicorp/terraform-ls
require'lspconfig'.terraformls.setup{
  capabilities = capabilities,
  on_attach = lsp_on_attach
}

-- ++ YAML ++
-- LSP: yarn global add yaml-language-server
require'lspconfig'.yamlls.setup{
  capabilities = capabilities,
  on_attach = lsp_on_attach
}
