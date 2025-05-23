--- +++ SERVERS +++

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

-- Enables virtual text in diagnostics
vim.diagnostic.config({
	virtual_text = true,
})

-- Custom confs
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.lsp.config("jsonls", {
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
	capabilities = capabilities,
})

vim.lsp.config("lua_ls", {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
				return
			end
		end
		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				version = "LuaJIT",
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
				},
			},
		})
	end,
	settings = {
		Lua = {},
	},
})

vim.lsp.config("denols", {
	-- There is an open bug that makes denols open always.
	-- https://github.com/neovim/nvim-lspconfig/issues/3728
	-- https://github.com/neovim/neovim/issues/32037#issuecomment-2774451000
	root_markers = { "deno.json", "deno.jsonc" },
	root_dir = function(_, callback)
		local root_dir = vim.fs.root(0, { "deno.json", "deno.jsonc" })

		if root_dir then
			callback(root_dir)
		end
	end,
})

vim.lsp.config("ts_ls", {
	-- There is an open bug that makes denols open always.
	-- https://github.com/neovim/nvim-lspconfig/issues/3728
	-- https://github.com/neovim/neovim/issues/32037#issuecomment-2774451000
	root_markers = { "package.json" },
	root_dir = function(_, callback)
		local deno_dir = vim.fs.root(0, { "deno.json", "deno.jsonc" })
		local root_dir = vim.fs.root(0, { "tsconfig.json", "jsconfig.json", "package.json" })

		if root_dir and deno_dir == nil then
			callback(root_dir)
		end
	end,
})

vim.lsp.config("volar", {
	-- Disable hybnid mode
	filetypes = { "vue" },
	init_options = {
		vue = {
			-- disable hybrid mode
			hybridMode = false,
		},
	},
})

-- Linters
local hadolint = require("efmls-configs.linters.hadolint")
local shellcheck = require("efmls-configs.linters.shellcheck")
local perlcritic = require("efmls-configs.linters.perlcritic")

-- Formatters
local languages = require("efmls-configs.defaults").languages()
local shfmt = require("efmls-configs.formatters.shfmt")
local prettier = require("efmls-configs.formatters.prettier")
local perltidy = require("efmls-configs.formatters.perltidy")
languages = vim.tbl_extend("force", languages, {
	sh = { shfmt, shellcheck },
	perl = { perlcritic, perltidy }, -- TODO: Modify to adapt to the b.com config.
	dockerfile = { hadolint },
	json = { prettier },
	graphql = { prettier },
	vue = { prettier },
})

vim.lsp.config("efm", {
	filetypes = vim.tbl_keys(languages),
	settings = {
		rootMarkers = { ".git/" },
		languages = languages,
	},
	root_dir = function(_, callback)
		local deno_dir = vim.fs.root(0, { "deno.json", "deno.jsonc" })
		local root_dir = vim.fs.root(0, { ".git/" })

		if root_dir and deno_dir == nil then
			callback(root_dir)
		end
	end,

	init_options = {
		documentFormatting = true,
		documentRangeFormatting = true,
	},
})

-- Enable LSPs
require("mason-lspconfig").setup({
	ensure_installed = { "efm" },
})

--- +++ KEYMAPS +++
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		-- Options
		local opts = function(str)
			return { buffer = ev.buf, noremap = true, silent = true, desc = str }
		end

		-- ++ Completion ++
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method("textDocument/completion") then
			-- Recommended setup https://neovim.io/doc/user/lsp.html#lsp-completion
			vim.cmd([[set completeopt+=menuone,noselect,popup]])
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
			vim.keymap.set({ "i", "n" }, "<c-space>", function()
				vim.lsp.completion.get()
			end)
		end

		local tb = require("telescope.builtin")
		-- ++ Moving around ++
		vim.keymap.set("n", "grd", tb.lsp_definitions, opts("Definition"))
		vim.keymap.set("n", "grD", vim.lsp.buf.declaration, opts("Declaration"))
		vim.keymap.set("n", "gri", tb.lsp_implementations, opts("Implementation")) -- Default
		vim.keymap.set("n", "gry", tb.lsp_type_definitions, opts("Type definitions"))
		vim.keymap.set("n", "grr", tb.lsp_references, opts("References")) -- Default
		vim.keymap.set("n", "gO", tb.lsp_document_symbols, opts("Symbols")) -- Default

		-- ++ Information ++
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Hover")) -- Default value.
		vim.keymap.set({ "i", "n" }, "<C-g>", vim.lsp.buf.signature_help, opts("Signature help"))

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
		vim.keymap.set({ "n", "i" }, "<C-e>", vim.diagnostic.open_float, opts("Diagnostic"))
		-- vim.keymap.set("n", "<leader>gp", vim.diagnostic.goto_prev, opts("Go prev diagnostic"))
		-- vim.keymap.set("n", "<leader>gn", vim.diagnostic.goto_next, opts("Go next diagnostic"))
		vim.keymap.set("n", "gre", tb.diagnostics, opts("Diagnostics"))
	end,
})
