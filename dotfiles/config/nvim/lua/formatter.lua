function get_js_runtime(bufnr)
	local bufname = vim.fs.normalize(vim.api.nvim_buf_get_name(bufnr))
	local dir = vim.fs.dirname(bufname)
	local findopts = { upward = true, path = dir }

	-- Deno project if any of these exist
	local deno_files = vim.fs.find({ "deno.json", "deno.jsonc", "deno.lock" }, findopts)
	-- Node/Prettier project if package.json exists
	local node_files = vim.fs.find({ "package.json" }, findopts)

	return {
		is_deno = #deno_files > 0,
		is_node = #node_files > 0,
	}
end

local function js_formatter(bufnr)
	local runtime = get_js_runtime(bufnr)

	-- Prefer deno_fmt if a deno config exists
	if runtime.is_deno then
		return { "deno_fmt" }
	end

	-- Otherwise, use prettier for regular JS/TS projects
	return { "prettier" }
end

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		graphql = { "prettier" },
		vue = { "prettier" },
		css = { "prettier" },
        markdown = { "prettier" },
		javascript = js_formatter,
		typescript = js_formatter,
		javascriptreact = js_formatter,
		typescriptreact = js_formatter,
		json = js_formatter,
	},
})
