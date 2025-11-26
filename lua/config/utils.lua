-- configure harpoon
local harpoon = require("harpoon")
harpoon:setup()

-- configure conform
require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        rust = { "rustfmt", lsp_format = "fallback" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        c = { "clang_format" },
        cpp = { "clang_format" },
        h = { "clang_format" },
        hpp = { "clang_format" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        markdown = { "prettier" },
        bib = { "bibtex_tidy" },
        tex = { "latexindent" },
        cmake = { "cmake_format" },
    },
})

-- confgiure which-key
require("which-key").setup({
    delay = 1000,  -- before open (ms)
})
