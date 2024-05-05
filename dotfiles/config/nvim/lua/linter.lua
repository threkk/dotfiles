-- Linters
require("lint").linters_by_ft = {
	python = { "flake8" },
	docker = { "hadolint" },
	bash = { "shellcheck" },
	perl = { "perlcritic" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})

local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
-- Formatters
require("formatter").setup({
	filetype = {
		json = { require("formatter.filetypes.json").prettier },
		graphql = { require("formatter.filetypes.graphql").prettier },
		css = { require("formatter.filetypes.css").prettier },
		html = { require("formatter.filetypes.html").prettier },
		lua = { require("formatter.filetypes.lua").stylua },
		javascript = {
			function()
				if is_deno() then
					return require("formatter.filetypes.typescript").denofmt()
				end
				return require("formatter.filetypes.typescript").prettier()
			end,
		},
		javascriptreact = {
			function()
				if is_deno() then
					return require("formatter.filetypes.typescript").denofmt()
				end
				return require("formatter.filetypes.typescript").prettier()
			end,
		},
		typescript = {
			function()
				print(is_deno())
				if is_deno() then
					return require("formatter.filetypes.typescript").denofmt()
				end
				return require("formatter.filetypes.typescript").prettier()
			end,
		},
		typescriptreact = {
			function()
				print(is_deno())
				if is_deno() then
					return require("formatter.filetypes.typescript").denofmt()
				end
				return require("formatter.filetypes.typescript").prettier()
			end,
		},
		vue = {
			require("formatter.filetypes.vue").prettier,
		},
		python = {
			require("formatter.filetypes.python").black,
			require("formatter.filetypes.python").isort,
		},
		perl = {
			require("formatter.filetypes.perl").perltidy,
		},
		go = {
			require("formatter.filetypes.go").gofmt,
			require("formatter.filetypes.go").goimports,
		},
		sh = {
			require("formatter.filetypes.sh").shfmt,
		},
	},
})

vim.keymap.set("n", "<leader>gf", ":Format<CR>", opts)
