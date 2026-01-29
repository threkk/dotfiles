local opts = function(str)
	return { noremap = true, silent = true, desc = str }
end

-- Disable nonnative plugin
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0

-- Telescope
local telescope = require("telescope")
telescope.setup({
	defaults = {
		preview = {
			-- Treesitter does not get along with telescope.
			treesitter = false,
		},
	},
})

-- Preview of the search
vim.opt.inccommand = "nosplit"

-- Bring back rounded borders
-- vim.o.winborder = 'rounded'

-- Define ts as a markdown language instead of typescript.
vim.g.markdown_fenced_languages = {
	"ts=typescript",
}

-- Twilight
require("twilight").setup({})

-- nvim colorscheme
vim.g.tokyonight_style = "night"
vim.cmd([[colorscheme tokyonight]])

-- Control + number tabs (only nvim > 0.7)
for i = 1, 8 do
	vim.keymap.set("n", "<C-" .. i .. ">", function()
		vim.api.nvim_set_current_tabpage(i)
	end, opts("Go to tab " .. i))
	vim.keymap.set("!", "<C-" .. i .. ">", function()
		vim.api.nvim_set_current_tabpage(i)
	end, opts("Go to tab " .. i))
end
vim.keymap.set("n", "<C-9>", function()
	vim.api.nvim_set_current_tabpage(vim.fn.tabpagenr("$"))
end, opts("Go to last tab"))
vim.keymap.set("!", "<C-9>", function()
	vim.api.nvim_set_current_tabpage(vim.fn.tabpagenr("$"))
end, opts("Go to last tab"))
