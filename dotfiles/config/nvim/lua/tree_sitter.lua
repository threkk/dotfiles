local desired = {
	"css",
	"go",
	"html",
	"java",
	"javascript",
	"lua",
	"markdown",
	"markdown_inline",
	"perl",
	"python",
	"query",
	"typescript",
	"vim",
	"vimdoc",
	"vue",
}

-- Async install logic
local installed = require("nvim-treesitter.config").get_installed()
local to_install = vim.iter(desired)
	:filter(function(lang) return not vim.tbl_contains(installed, lang) end)
	:totable()
if #to_install > 0 then
	require("nvim-treesitter").install(to_install)
end

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)
	end
})
