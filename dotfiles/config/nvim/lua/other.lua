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

-- Twilight
require("twilight").setup({})

-- nvim colorscheme
vim.g.tokyonight_style = "night"
vim.cmd([[colorscheme tokyonight]])

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

-- mini.comment: Toggle comment blocks
require("mini.comment").setup()

-- mini.splitjoin: Convert objects from single line to multiline.
require("mini.splitjoin").setup()

-- mini.git: Git integration
require("mini.git").setup()

local align_blame = function(au_data)
	if au_data.data.git_subcommand ~= "blame" then
		return
	end

	-- Align blame output with source
	local win_src = au_data.data.win_source
	vim.wo.wrap = false
	vim.fn.winrestview({ topline = vim.fn.line("w0", win_src) })
	vim.api.nvim_win_set_cursor(0, { vim.fn.line(".", win_src), 0 })

	-- Bind both windows so that they scroll together
	vim.wo[win_src].scrollbind, vim.wo.scrollbind = true, true
end

vim.api.nvim_create_autocmd("User", { pattern = "MiniGitCommandSplit", callback = align_blame })

-- mini.diff: Git diff on every line
require("mini.diff").setup({
	view = { style = "sign" },
})

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

-- mini.cursorword: Highlights the word under the cursor
require("mini.cursorword").setup()

-- mini.hipatterns: Highlights certain words with colours.
local hipatterns = require("mini.hipatterns")
require("mini.hipatterns").setup({
	highlighters = {
		fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
		hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
		todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
		note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
		hex_color = hipatterns.gen_highlighter.hex_color(),
	},
})

-- mini.indentscope: Display a vertical line to mark current scope.
require("mini.indentscope").setup()

-- Navigation
-- mini.jump2d: Easymotion like
require("mini.jump2d").setup({
	mappings = {
		start_jumping = "<leader><leader>",
	},
})
