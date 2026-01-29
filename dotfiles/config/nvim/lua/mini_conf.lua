-- Mini plugin configuration

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

-- mini.snippets: Better snippet support.
local gen_loader = require("mini.snippets").gen_loader
local snippets = require("mini.snippets")
snippets.setup({
	snippets = {
		gen_loader.from_file(vim.fn.stdpath("config").."/snippets/global.json"),
		gen_loader.from_lang(),
	},
})
snippets.start_lsp_server()

-- mini.completion: Better autocomplete.
require("mini.completion").setup()


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

-- Navigation
-- mini.jump2d: Easymotion like
require("mini.jump2d").setup({
	mappings = {
		start_jumping = "<leader><leader>",
	},
})

-- mini.move: Improved line swapping. Should overwrite our defaults.
require("mini.move").setup()

-- mini.bracketed: Bracked operations
require("mini.bracketed").setup()

-- UI improvements
-- mini.files: File viewer
require("mini.files").setup()

local minifiles_toggle = function(...)
	if not MiniFiles.close() then
		MiniFiles.open()
	end
end
vim.keymap.set("n", "<leader>t", minifiles_toggle, ns)

-- mini.icons: UI icons.
require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()
MiniIcons.tweak_lsp_kind()

-- mini.tabline: Tabs improvements
require("mini.tabline").setup()

-- mini.statusline: Status line improvements
require("mini.statusline").setup()

-- mini.clue: shows hints based on keys pressed.
local miniclue = require("mini.clue")
miniclue.setup({
	triggers = {
		-- Leader triggers
		{ mode = "n", keys = "<Leader>" },
		{ mode = "x", keys = "<Leader>" },

		-- Built-in completion
		{ mode = "i", keys = "<C-x>" },

		-- `g` key
		{ mode = "n", keys = "g" },
		{ mode = "x", keys = "g" },

		-- Registers
		{ mode = "n", keys = '"' },
		{ mode = "x", keys = '"' },
		{ mode = "i", keys = "<C-r>" },
		{ mode = "c", keys = "<C-r>" },
	},

	clues = {
		miniclue.gen_clues.builtin_completion(),
		miniclue.gen_clues.g(),
		miniclue.gen_clues.registers(),
	},
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

-- mini.starter: Welcome dashboard
local starter = require("mini.starter")

starter.setup({
	evaluate_single = true,
	items = {
		starter.sections.builtin_actions(),
		starter.sections.recent_files(5, true),
		starter.sections.recent_files(5, false),
	},
	content_hooks = {
		starter.gen_hook.adding_bullet(),
		starter.gen_hook.aligning("center", "center"),
	},
})

-- mini.notifiy: Notification messages
require("mini.notify").setup({
	content = {
		format = function(notif)
			return string.format(" %s ", notif.msg)
		end,
	},
})
