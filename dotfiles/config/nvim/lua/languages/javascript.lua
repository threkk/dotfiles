-- ++ Tree sitter ++
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript.jsx", "typescript.tsx", "javascriptreact", "typescriptreact"}

-- ++ LSP: tsserver ++
require'lspconfig'.tsserver.setup{
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  capabilities = capabilities, 
  root_dir = require'lspconfig'.util.root_pattern("package.json"),
  on_attach = function(client, bufnr)
    -- Disable tsserver formatter
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false


    lsp_on_attach(client, bufnr)
    local ts_utils = require('nvim-lsp-ts-utils')

    ts_utils.setup {}
    ts_utils.setup_client(client)

    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gm", ":TSLspImportAll<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gM", ":TSLspOrganize<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>R", ":TSLspRenameFile<CR>", opts)
  end
}

-- ++ LSP: eslint ++
require'lspconfig'.eslint.setup{
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  root_dir = require'lspconfig'.util.root_pattern("package.json"),
}

-- + LSP: volar +
require'lspconfig'.volar.setup{
  on_attach = lsp_on_attach,
  -- Only if we need Take Over mode: https://vuejs.org/guide/typescript/overview.html#volar-takeover-mode
  -- filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'}
}

-- + LSP: deno +
require'lspconfig'.denols.setup {
  on_attach = lsp_on_attach,
  root_dir = require'lspconfig'.util.root_pattern("deno.json", "deno.jsonc", "deno.lock"),
}

vim.g.markdown_fenced_languages = {
  "ts=typescript"
}

-- + LSP: astro +
require'lspconfig'.astro.setup{
  on_attach = lsp_on_attach,
  root_dir = require'lspconfig'.util.root_pattern("astro.config.mjs")
}
