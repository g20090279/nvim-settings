return {
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = 'cd app && npm install',  -- Make sure to install dependencies (lazy.nvim runs `build`, not packer's `run`)
        ft = { "markdown" },
    },
    {
        "dhruvasagar/vim-table-mode",
        ft = { "rst", "markdown", "text" },
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        ft = { "markdown" },
        opts = {},
    },
    {
        "bullets-vim/bullets.vim",
        ft = { "markdown", "text", "gitcommit", "scratch" },
        -- init, not config: bullets.vim reads this when it loads
        init = function()
            vim.g.bullets_enabled_file_types = { "markdown", "text", "gitcommit", "scratch" }
        end,
    },
    { "tpope/vim-surround", event = "VeryLazy" },
    { "mbbill/undotree", cmd = "UndotreeToggle" },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    {
        "L3MON4D3/LuaSnip",
        lazy = true, -- loaded with nvim-cmp
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
    },
    {
        "lervag/vimtex",
        lazy = false,     -- we don't want to lazy load VimTeX
        init = function()
            local sysname = vim.uv.os_uname().sysname
            if sysname == "Darwin" then  -- macOS
                vim.g.vimtex_view_method = "skim"
            elseif sysname == "Linux" then  -- Linux
                vim.g.vimtex_view_method = "zathura"
            elseif sysname == "Windows_NT" then  -- Windows
                vim.g.vimtex_view_method = "general"
                vim.g.vimtex_view_general_viewer =  "SumatraPDF"
                vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
            else  -- Fallback or unsupported OS
                vim.g.vimtex_view_method = ""
            end
        end
    },
    -- Comment.nvim removed: Neovim 0.10+ has built-in gc / gcc commenting
}
