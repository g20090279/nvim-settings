-- lua/config/lsp/mason.lua
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
        -- "lua_ls",         -- lua language server
        -- "bashls",         -- bash language server
        -- "ts_ls",          -- TypeScript/JavaScript (tsserver successor)
        -- "pyright",        -- Python
        -- "clangd",         -- C/C++
        -- "ltex-ls",        -- Language check with support for LaTeX, Markdown, and others
        -- "texlab",         -- latex language server
        -- add more as needed
    },
})
