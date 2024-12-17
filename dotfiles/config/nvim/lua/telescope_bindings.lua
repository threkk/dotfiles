local opts = function(str)
	return { noremap = true, silent = true, desc = str }
end

local builtin = require("telescope.builtin")

-- Searches a file
vim.keymap.set("n", "<leader>f", builtin.find_files, opts("Find files"))

vim.keymap.set("n", "<C-o>", builtin.find_files, opts("Find files"))

vim.keymap.set("!", "<C-o>", builtin.find_files, opts("Find files"))

-- Searches a buffer
vim.keymap.set("n", "<leader>b", builtin.buffers, opts("Buffers"))

-- Searches with a live grep
vim.keymap.set("n", "<leader>p", builtin.live_grep, opts("Live grep"))

vim.keymap.set("n", "<C-p>", builtin.live_grep, opts("Live grep"))

vim.keymap.set("!", "<C-p>", builtin.live_grep, opts("Live grep"))

-- Searches in the current file
vim.keymap.set("n", "<c-f>", builtin.current_buffer_fuzzy_find, opts("Search buffer"))

vim.keymap.set("!", "<c-f>", builtin.current_buffer_fuzzy_find, opts("Search buffer"))

-- Searches the list of builtins
vim.keymap.set("n", "<leader>e", builtin.builtin, opts("Builtin"))

-- Searches the Git files.
vim.keymap.set("n", "<leader>s", builtin.git_files, opts("Git files"))

-- Searches the Git Status.
vim.keymap.set("n", "<leader>S", builtin.git_status, opts("Git status"))

-- Opens telescope main menu
vim.keymap.set("n", "<leader>k", builtin.commands, opts("Commands"))
vim.keymap.set("n", "<C-k>", builtin.commands, opts("Commands"))
