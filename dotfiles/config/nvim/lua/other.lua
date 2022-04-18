local ns = { noremap = true, silent = true }

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

-- Copilot (disabled)
-- vim.cmd[[imap <silent><script><expr> <leader>gc copilot#Accept("\<CR>")]]
-- vim.cmd[[let g:copilot_no_tab_map = v:true]]

-- Control + number tabs (only nvim > 0.7)
for i = 1, 8  do
    vim.api.nvim_set_keymap('n', '<C-'..i..'>', ':tabn '..i..'<CR>', ns)
    vim.api.nvim_set_keymap('!', '<C-'..i..'>', '<ESC>:tabn '..i..'<CR>', ns)
end
vim.api.nvim_set_keymap('n', '<C-9>', ':tablast<CR>', ns)
vim.api.nvim_set_keymap('!', '<C-9>', '<ESC>:tablast<CR>', ns)
