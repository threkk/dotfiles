-- ++ SYNTAX HIGHLIGHTING ++
require("nvim-treesitter.configs").setup({
	auto_install = true,
	sync_install = false,
	ignore_install = {},
	highlight = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
	},
	textobjects = {
		enabled = true,
	},
	indent = {
		enable = true,
	},
	ensure_installed = {
		"bash",
		"css",
		"dockerfile",
		"go",
		"gomod",
		"graphql",
		"html",
		"javascript",
		"json",
		-- "latex",
		"lua",
		"markdown",
		"markdown_inline",
		"perl",
		"python",
		"regex",
		"tsx",
		"typescript",
		"vim",
		"vue",
		"yaml",
	},
})

vim.cmd("set foldexpr=nvim_treesitter#foldexpr()")
