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
require'typescript'.setup({
  disable_commands = false, -- prevent the plugin from creating Vim commands
  debug = false, -- enable debug logging for commands
  go_to_source_definition = {
    fallback = true, -- fall back to standard LSP definition on failure
  },
  server = { -- pass options to lspconfig's setup method
    capabilities = capabilities,
    single_file_support = false,
    root_dir = util.root_pattern('package.json'),
    on_attach = function(client, bufnr)
      -- Disable tsserver formatter
      client.server_capabilities.document_range_formatting = false
      client.server_capabilities.document_formatting = false -- 0.7 and earlier
      client.server_capabilities.documentFormattingProvider = false -- 0.8 and later

      lsp_on_attach(client, bufnr)
    end
  },
})

-- ++ LSP: eslint ++
require'lspconfig'.eslint.setup{
  on_attach = lsp_on_attach,
  root_dir = util.root_pattern('package.json'),
}

-- + LSP: volar +
require'lspconfig'.volar.setup{
  on_attach = lsp_on_attach,
  -- Only if we need Take Over mode: https://vuejs.org/guide/typescript/overview.html#volar-takeover-mode
  -- filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'}
}

-- + LSP: deno +
require'deno-nvim'.setup {
  server = {
    on_attach = lsp_on_attach,
    root_dir = util.root_pattern('deno.json', 'deno.jsonc'),
  }
}

vim.g.markdown_fenced_languages = {
  'ts=typescript'
}

-- + LSP: astro +
require'lspconfig'.astro.setup{
  on_attach = lsp_on_attach
}
