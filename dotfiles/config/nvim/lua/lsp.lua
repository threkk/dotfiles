-- +++ SERVERS +++

-- General config
vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- Hides "match 1 of 3" noise
vim.opt.shortmess:append("c")

-- Enables virtual text for diagnostics
vim.diagnostic.config({
	virtual_text = true,
})

local super_tab = function()
	local completion_visible = vim.fn.pumvisible() == 1
	local snippet_active = vim.snippet.active({ direction = 1 })

	if completion_visible then
		return "<C-n>"
	elseif snippet_active then
		return "<cmd>lua vim.snippet.jump(1)<cr>"
	else
		return "<Tab>"
	end
end

local super_s_tab = function()
	local completion_visible = vim.fn.pumvisible() == 1
	local snippet_active = vim.snippet.active({ direction = -1 })
	if completion_visible then
		return "<C-p>"
	elseif snippet_active then
		return "<cmd>lua vim.snippet.jump(-1)<cr>"
	else
		return "<S-Tab>"
	end
end
-- Map Tab/Shift-Tab/Enter
vim.keymap.set({ "i", "s" }, "<Tab>", super_tab, { expr = true })
vim.keymap.set({ "i", "s" }, "<S-Tab>", super_s_tab, { expr = true })
vim.keymap.set({ "i", "s" }, "<CR>", function()
	return vim.fn.pumvisible() == 1 and "<C-y>a" or "<CR>"
end, { expr = true })

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

require("mason-lspconfig").setup({
	handlers = {
		-- Default Handler: Automatically enable every installed server
		function(server_name)
			vim.lsp.enable(server_name)
		end,
		["harper_ls"] = function()
			vim.lsp.config("harper_ls", {
				settings = {
					["harper-ls"] = {
						dialect = "British",
					},
				},
			})
			vim.lsp.enable("harper_ls")
		end,
		["jsonls"] = function()
			vim.lsp.config("jsonls", {
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})
			vim.lsp.enable("jsonls")
		end,
	},
})

-- --- +++ KEYMAPS +++
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		-- Autocomplete
		if client and client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
			vim.keymap.set({ "i", "n" }, "<c-space>", function()
				vim.lsp.completion.get()
			end)
		end

		-- Mappings
		local tb = require("telescope.builtin")
		local opts = function(str)
			return { buffer = args.buf, noremap = true, silent = true, desc = str }
		end

		-- ++ Moving around ++
		vim.keymap.set("n", "grd", tb.lsp_definitions, opts("Definition"))
		vim.keymap.set("n", "grD", vim.lsp.buf.declaration, opts("Declaration"))
		vim.keymap.set("n", "gri", tb.lsp_implementations, opts("Implementation")) -- Default
		vim.keymap.set("n", "grt", tb.lsp_type_definitions, opts("Type definitions"))
		vim.keymap.set("n", "grr", tb.lsp_references, opts("References")) -- Default
		vim.keymap.set("n", "gO", tb.lsp_document_symbols, opts("Symbols")) -- Default

		-- ++ Information ++
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Hover")) -- Default value.
		vim.keymap.set({ "i", "n" }, "<C-g>", vim.lsp.buf.signature_help, opts("Signature help"))
		-- Not released yet
		-- vim.keymap.set({ "i", "n" }, "<C-b>", "<Plug>(nvim.lsp.ctrl-s)", opts("Cycle signature help"))
		--
		-- ++ Actions ++
		vim.keymap.set("n", "gra", vim.lsp.buf.code_action, opts("Code action"))
		vim.keymap.set("n", "grn", vim.lsp.buf.rename, opts("Rename")) -- Default
		vim.keymap.set("n", "grf", function()
			vim.lsp.buf.format({ async = true })
		end, opts("Format"))
		vim.keymap.set("n", "grc", function()
			vim.lsp.codelens.refresh()
			vim.lsp.codelens.run()
		end, opts("Code lens"))

		-- ++ Diagnostics ++
		vim.keymap.set({ "n", "i" }, "<C-d>", vim.diagnostic.open_float, opts("Diagnostic"))
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = -1 })
		end, opts("Go prev diagnostic"))
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = 1 })
		end, opts("Go next diagnostic"))
		vim.keymap.set("n", "gre", tb.diagnostics, opts("Diagnostics"))
	end,
})
