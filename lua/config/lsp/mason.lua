-- lua/config/lsp/mason.lua
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
        "lua_ls",         -- lua
        "ts_ls",          -- TypeScript/JavaScript (tsserver successor)
        "pyright",        -- Python
        "clangd",         -- C/C++
        "rust_analyzer",  -- Rust
        "gopls",          -- Go
        -- add more as needed
    },
})
