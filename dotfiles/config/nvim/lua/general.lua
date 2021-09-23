-- Floating terminal
vim.api.nvim_set_keymap(
  'n',
  '<C-o>',
  [[:Nuake<CR>]],
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  't',
  '<C-o>',
  [[<C-\><C-n>:Nuake<CR>]],
  { noremap = true, silent = true }
)

-- Opens NERDTree.
-- map <leader>t :NERDTreeToggle<CR>
vim.api.nvim_set_keymap(
  'n',
  '<leader>t',
  [[:NERDTreeToggle<CR>]],
  { noremap = true, silent = true }
)
