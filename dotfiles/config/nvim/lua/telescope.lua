local ns = { noremap = true, silent = true }

-- Searches a file
vim.api.nvim_set_keymap('n', '<leader>f',
  '<cmd>lua require"telescope.builtin".find_files()<cr>',  ns)

vim.api.nvim_set_keymap('n', '<C-o>', 
  '<cmd>lua require"telescope.builtin".find_files()<cr>', ns)

vim.api.nvim_set_keymap('!', '<C-o>', 
  '<esc><cmd>lua require"telescope.builtin".find_files()<cr>', ns)

-- Searches a buffer
vim.api.nvim_set_keymap('n', '<leader>b',
  '<cmd>lua require"telescope.builtin".buffers()<cr>',  ns)

-- Searches with a live grep
vim.api.nvim_set_keymap('n', '<leader>p',
  '<cmd>lua require"telescope.builtin".live_grep()<cr>',  ns)

-- Searches in the current file
vim.api.nvim_set_keymap('n', '<c-f>',
  '<cmd>lua require"telescope.builtin".current_buffer_fuzzy_find()<cr>',  ns)

vim.api.nvim_set_keymap('!', '<c-f>',
  '<esc><cmd>lua require"telescope.builtin".current_buffer_fuzzy_find()<cr>',  ns)

-- Searches the list of builtins
vim.api.nvim_set_keymap('n', '<leader>e',
  '<cmd>lua require"telescope.builtin".builtin()<cr>',  ns)

-- Searches the Git files.
vim.api.nvim_set_keymap('n', '<leader>s',
  '<cmd>lua require"telescope.builtin".git_files()<cr>',  ns)

-- Searches the Git Status.
vim.api.nvim_set_keymap('n', '<leader>S',
  '<cmd>lua require"telescope.builtin".git_status()<cr>',  ns)
