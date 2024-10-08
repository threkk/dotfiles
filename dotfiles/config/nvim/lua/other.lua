local ns = { noremap = true, silent = true }

-- Disable non native plugin
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0

-- Mason
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})
require("mason-lspconfig").setup()

-- Telescope
local telescope = require("telescope")
telescope.setup({})

-- Preview of the search
vim.opt.inccommand = "nosplit"

-- Terminal
vim.keymap.set("n", "<c-g>", ":tabnew | term<CR>", ns)
vim.keymap.set("i", "<c-g>", "<Esc>:tabnew | term<CR>", ns)

-- Gitsigns
require("gitsigns").setup()

-- Twilight
require("twilight").setup({})

-- nvim colorscheme
vim.g.tokyonight_style = "night"
vim.cmd([[colorscheme tokyonight]])

-- Blankline
vim.opt.list = true
require("ibl").setup()

-- Control + number tabs (only nvim > 0.7)
for i = 1, 8 do
	vim.keymap.set("n", "<C-" .. i .. ">", ":tabn " .. i .. "<CR>", ns)
	vim.keymap.set("!", "<C-" .. i .. ">", "<ESC>:tabn " .. i .. "<CR>", ns)
end
vim.keymap.set("n", "<C-9>", ":tablast<CR>", ns)
vim.keymap.set("!", "<C-9>", "<ESC>:tablast<CR>", ns)


-- Edition
-- mini.align: Aligns lines around certain caracter.
require("mini.align").setup()

-- mini.ai: Selection of surrounding elements
require("mini.ai").setup()

-- mini.pairs: Auto-close parenthesis
require("mini.pairs").setup()

-- mini.surround: Bracket operations
require("mini.surround").setup()

-- UI improvements
-- mini.files: File viewer
require("mini.files").setup()

local minifiles_toggle = function(...)
	if not MiniFiles.close() then
		MiniFiles.open()
	end
end
vim.keymap.set("n", "<leader>t", minifiles_toggle, { silent = true })

-- mini.icons: UI icons.
require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

-- mini.notify: Shows notifications.
local bottom_right = function()
	local has_statusline = vim.o.laststatus > 0
	local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
	return { anchor = "SE", col = vim.o.columns, row = vim.o.lines - pad }
end
require("mini.notify").setup({
	content = {
		format = function(notif)
			return notif.msg
		end,
	},
	window = { config = bottom_right },
})

-- Under consideration: 
-- mini.mappings
-- mini.animate

-- Navigation
-- mini.jump2d: Easymotion like
require("mini.jump2d").setup({
    mappings = {
        start_jumping = "<leader><leader>"
    }
})
