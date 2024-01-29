vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Mappings
    local opts = { buffer = ev.buf, noremap = true, silent = true  }
    -- ++ Moving around ++
    vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', '<leader>gd', require"telescope.builtin".lsp_definitions, opts)
    vim.keymap.set('n', '<leader>gi', require"telescope.builtin".lsp_implementations, opts)
    vim.keymap.set('n', '<leader>gr', require"telescope.builtin".lsp_references, opts)
    vim.keymap.set('n', '<leader>gt', require"telescope.builtin".lsp_type_definitions, opts)
    vim.keymap.set('n', '<leader>go', require"telescope.builtin".lsp_document_symbols, opts)

    -- ++ Information ++
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>gs', vim.lsp.buf.signature_help, opts)

    -- ++ Actions ++
    vim.keymap.set('n', '<leader>ga', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
    -- vim.keymap.set('n', '<leader>gf', function ()
    --   vim.lsp.buf.format({ async = true })
    -- end, opts)
    vim.keymap.set('n', '<leader>gc', function()
      vim.lsp.codelens.refresh() 
      vim.lsp.codelens.run()
    end, opts)

    -- ++ Diagnostics ++
    vim.keymap.set('n', '<leader>ge', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<leader>gp', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', '<leader>gn', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<leader>gE', require"telescope.builtin".diagnostics, opts)
  end,
})
