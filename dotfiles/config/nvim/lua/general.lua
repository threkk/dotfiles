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
