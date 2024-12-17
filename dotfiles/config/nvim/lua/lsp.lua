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

local util = require("lspconfig.util")
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers({
	-- default handler (optional)
	function(server_name)
		require("lspconfig")[server_name].setup({})
	end,
	["jsonls"] = function()
		require("lspconfig").jsonls.setup({
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			},
		})
	end,
	["lua_ls"] = function()
		require("lspconfig").lua_ls.setup({
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
	end,
	["ts_ls"] = function()
		require("lspconfig").ts_ls.setup({
			root_dir = util.root_pattern("package.json"),
			single_file_support = false,
		})
	end,
	["eslint"] = function()
		require("lspconfig").eslint.setup({
			root_dir = util.root_pattern("package.json"),
		})
	end,
	["volar"] = function()
		require("lspconfig").volar.setup({
			filetypes = { "vue" },
			init_options = {
				vue = {
					-- disable hybrid mode
					hybridMode = false,
				},
			},
		})
	end,
	["denols"] = function()
		require("deno-nvim").setup({
			server = {
				root_dir = util.root_pattern("deno.json", "deno.jsonc"),
			},
		})
	end,
})

--- +++ KEYMAPS +++
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Mappings
		local opts = function(str)
			return { buffer = ev.buf, noremap = true, silent = true, desc = str }
		end

		local tb = require("telescope.builtin")
		-- ++ Moving around ++
		vim.keymap.set("n", "gd", tb.lsp_definitions, opts("Definition"))
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Declaration"))
		vim.keymap.set("n", "gI", tb.lsp_implementations, opts("Implementation"))
		vim.keymap.set("n", "gy", tb.lsp_type_definitions, opts("Type definitions"))
		vim.keymap.set("n", "go", tb.lsp_document_symbols, opts("Symbols"))
		vim.keymap.set("n", "gr", tb.lsp_references, opts("References"))

		-- ++ Information ++
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Hover"))
		vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, opts("Signature help"))

		-- ++ Actions ++
		vim.keymap.set("n", "<leader>ga", vim.lsp.buf.code_action, opts("Code action"))
		vim.keymap.set("n", "<leader>gr", vim.lsp.buf.rename, opts("Rename"))
		-- vim.keymap.set('n', '<leader>gf', function ()
		--   vim.lsp.buf.format({ async = true })
		-- end, opts)
		vim.keymap.set("n", "<leader>gc", function()
			vim.lsp.codelens.refresh()
			vim.lsp.codelens.run()
		end, opts("Code lens"))

		-- ++ Diagnostics ++
		vim.keymap.set("n", "ge", vim.diagnostic.open_float, opts("Diagnostic"))
		-- vim.keymap.set("n", "<leader>gp", vim.diagnostic.goto_prev, opts("Go prev diagnostic"))
		-- vim.keymap.set("n", "<leader>gn", vim.diagnostic.goto_next, opts("Go next diagnostic"))
		vim.keymap.set("n", "gE", tb.diagnostics, opts("Diagnostics"))
	end,
})
