local opts = function(str)
	return { noremap = true, silent = true, desc = str }
end

-- Disable non native plugin
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0

-- Telescope
local telescope = require("telescope")
telescope.setup({})

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

-- Noice.nvim
require("noice").setup({
	lsp = {
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
		},
	},
	-- you can enable a preset for easier configuration
	presets = {
		bottom_search = false, -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = true, -- add a border to hover docs and signature help
	},
})
