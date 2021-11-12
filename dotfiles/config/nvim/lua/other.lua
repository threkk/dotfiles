-- Preview of the search
vim.opt.inccommand = 'nosplit' 

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

-- Copilot
vim.cmd[[imap <silent><script><expr> <leader>gc copilot#Accept("\<CR>")]]
vim.cmd[[let g:copilot_no_tab_map = v:true]]
