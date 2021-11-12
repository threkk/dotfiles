local null_ls = require('null-ls')

local sources = {
    -- null_ls.builtins.diagnostics.misspell Under consideration
    -- null_ls.builtins.diagnostics.write_good Under consideration
    -- null_ls.builtins.formatting.perltidy Managed in perl.lua
    null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.diagnostics.hadolint,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.terraform_fmt
}

null_ls.config({ sources = sources })

require('lspconfig')['null-ls'].setup({
    on_attach = lsp_on_attach
})
