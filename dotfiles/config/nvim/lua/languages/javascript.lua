-- ++ Tree sitter ++
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.used_by = { "javascript.jsx", "typescript.tsx", "javascriptreact", "typescriptreact"}

-- ++ LSP ++
require'lspconfig'.tsserver.setup{
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  capabilities = capabilities, 
  on_attach = function(client, bufnr)
    -- Disable tsserver formatter
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false


    lsp_on_attach(client, bufnr)
    local ts_utils = require('nvim-lsp-ts-utils')

    ts_utils.setup {
      -- enable_import_on_completion = false,

      eslint_enable_code_actions = true,
      eslint_enable_disable_comments = true,

      -- linting
      eslint_bin = "eslint",
      eslint_enable_diagnostics =  true,
      eslint_enable_disable_comments = true,
      eslint_opts = {
        extra_args = function(params)
          local lsputil = require("lspconfig.util")
          local root = lsputil.root_pattern("package.json")(params.bufname)

          local eslint_js = lsputil.path.join(root, ".eslintrc.js")
          local eslint_json = lsputil.path.join(root, ".eslintrc.json")

          return lsputil.path.exists(eslint_js or eslint_json) and {}
          or { "--config", vim.fn.expand("~/.config/eslint/eslintrc.json") }
        end,
      },

      -- formatting
      enable_formatting = true,
      formatter = "eslint",
      formatter_opts = {
        extra_args = function(params)
          local lsputil = require("lspconfig.util")
          local root = lsputil.root_pattern("package.json")(params.bufname)

          local eslint_js = lsputil.path.join(root, ".eslintrc.js")
          local eslint_json = lsputil.path.join(root, ".eslintrc.json")

          return lsputil.path.exists(eslint_js or eslint_json) and {}
          or { "--config", vim.fn.expand("~/.config/eslint/eslintrc.json") }
        end,
      },


    }

    ts_utils.setup_client(client)

    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>go", ":TSLspImportAll<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gO", ":TSLspOrganize<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>R", ":TSLspRenameFile<CR>", opts)
  end
}

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
