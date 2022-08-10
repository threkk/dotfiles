
-- ++ SYNTAX HIGHLIGHTING ++
require'nvim-treesitter.configs'.setup {
  ensure_installed = 'maintained',
  ignore_install = {},
  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  ensure_installed = {
    'astro',
    'bash',
    'css',
    'dockerfile',
    'go',
    'gomod',
    'graphql',
    'hcl',
    'html',
    'javascript',
    'json',
    'lua',
    -- 'perl',
    'python',
    'tsx',
    'typescript',
    'vim',
    'vue',
    'yaml',
  },
}

vim.cmd 'set foldexpr=nvim_treesitter#foldexpr()'
