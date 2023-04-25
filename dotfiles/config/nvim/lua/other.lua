local ns = { noremap = true, silent = true }

-- Telescope
local telescope = require('telescope')
telescope.setup{}

-- Preview of the search
vim.opt.inccommand = 'nosplit' 

-- Terminal
vim.api.nvim_set_keymap('n', '<c-g>',
    ':tabnew | term<CR>', ns)
vim.api.nvim_set_keymap('i', '<c-g>',
    '<Esc>:tabnew | term<CR>', ns)

-- Gitsigns
require('gitsigns').setup()

-- Twilight
require('twilight').setup {}

-- nvim colorscheme
vim.g.tokyonight_style = 'night'
vim.cmd[[colorscheme tokyonight]]

-- Stabilize.nvim
require('stabilize').setup()

-- Blankline
vim.opt.list = true
require('indent_blankline').setup {
    space_char_blankline = ' ',
    show_current_context = true,
}

-- Control + number tabs (only nvim > 0.7)
for i = 1, 8  do
    vim.api.nvim_set_keymap('n', '<C-'..i..'>', ':tabn '..i..'<CR>', ns)
    vim.api.nvim_set_keymap('!', '<C-'..i..'>', '<ESC>:tabn '..i..'<CR>', ns)
end
vim.api.nvim_set_keymap('n', '<C-9>', ':tablast<CR>', ns)
vim.api.nvim_set_keymap('!', '<C-9>', '<ESC>:tablast<CR>', ns)

-- Fidget
require('fidget').setup()

-- Noice
require('noice').setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
      ['cmp.entry.get_documentation'] = true,
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = false, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
})

-- Project.nvim
require('project_nvim').setup{}
telescope.load_extension('projects')
vim.api.nvim_set_keymap('n', '<leader>w', ':Telescope projects<CR>', ns)
vim.api.nvim_set_keymap('!', '<leader>w', ':<ESC>:Telescope projects<CR>', ns)
