-- lua/config/lsp/mason.lua
-- mason must run at startup: it puts its bin/ on PATH before any server starts
require("mason").setup()

-- mason-lspconfig only ensures installs and auto-enables extra servers (~25 ms), so run it
-- after startup; the servers in config/lsp/servers.lua are enabled there directly
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	once = true,
	callback = function()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls", -- lua
				"ts_ls", -- TypeScript/JavaScript (tsserver successor)
				"pyright", -- Python
				"clangd", -- C/C++
				"rust_analyzer", -- Rust
				"gopls", -- Go
				-- add more as needed
			},
		})
	end,
})
