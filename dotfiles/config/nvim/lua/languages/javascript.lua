-- ++ Tree sitter ++
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript.jsx", "typescript.tsx", "javascriptreact", "typescriptreact"}

-- ++ LSP: tsserver ++
require'lspconfig'.tsserver.setup{
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  capabilities = capabilities, 
  on_attach = function(client, bufnr)
    -- Disable tsserver formatter
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false


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
require'lspconfig'.eslint.setup{}

-- + LSP: vuels +
require'lspconfig'.vuels.setup{
  on_attach = lsp_on_attach,
  init_options = {
    config = {
      vetur = {
        format = {
          defaultFormatter = {
            js = 'none',
            ts = 'none'
          }
        }
      }
    }
  }
}
