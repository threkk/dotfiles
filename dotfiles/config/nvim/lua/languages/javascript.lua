local util = require'lspconfig.util'

-- ++ Tree sitter ++
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { 
  "javascript.jsx",
  "typescript.tsx", 
  "javascriptreact",
  "typescriptreact"
}

-- ++ LSP: tsserver ++
require'lspconfig'.tsserver.setup({
  capabilities = capabilities,
  single_file_support = false,
  root_dir = util.root_pattern('jsconfig.json', 'tsconfig.json', 'package.json'),
  on_attach = function(client, bufnr)
    -- Disable tsserver formatter
    client.server_capabilities.document_range_formatting = false
    client.server_capabilities.document_formatting = false -- 0.7 and earlier
    client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
  end
})

-- ++ LSP: eslint ++
require'lspconfig'.eslint.setup{
  root_dir = util.root_pattern('jsconfig.json', 'tsconfig.json', 'package.json'),
}

-- + LSP: volar +
-- We might need Take Over mode: https://vuejs.org/guide/typescript/overview.html#volar-takeover-mode
require'lspconfig'.volar.setup{}

-- + LSP: deno +
require'deno-nvim'.setup {
  server = {
    root_dir = util.root_pattern('deno.json', 'deno.jsonc'),
  }
}

vim.g.markdown_fenced_languages = {
  'ts=typescript'
}

-- + LSP: astro +
require'lspconfig'.astro.setup{}

-- +LSP: svelte +
require'lspconfig'.svelte.setup{}
