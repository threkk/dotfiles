-- ++ BASH ++
-- LSP: https://github.com/mads-hartmann/bash-language-server
require'lspconfig'.bashls.setup{
  capabilities = capabilities,
}

-- ++ CSS,HTML,JSON ++
-- LSP: npm i -g vscode-langservers-extracted
require'lspconfig'.cssls.setup{
  capabilities = capabilities,
}
require'lspconfig'.html.setup{
  capabilities = capabilities,
}
require'lspconfig'.jsonls.setup{
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
}

-- ++ Docker ++
-- LSP: npm install -g dockerfile-language-server-nodejs
require'lspconfig'.dockerls.setup{
  capabilities = capabilities,
}

-- ++ GraphQL ++
-- LSP: npm install -g graphql-language-service-cli
require'lspconfig'.graphql.setup{
  capabilities = capabilities,
}

-- ++ SQL ++
-- LSP: go get github.com/lighttiger2505/sqls
require'lspconfig'.sqls.setup{
  capabilities = capabilities,
}

-- ++ Terraform ++
-- LPS: https://github.com/hashicorp/terraform-ls
require'lspconfig'.terraformls.setup{
  capabilities = capabilities,
}

-- ++ YAML ++
-- LSP: yarn global add yaml-language-server
require'lspconfig'.yamlls.setup{
  capabilities = capabilities,
}

-- ++ LUA ++
require'lspconfig'.lua_ls.setup{
  capabilities = capabilities,
}
