return {
    -- { "junegunn/seoul256.vim" },
    -- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                integrations = {
                    indent_blankline = {
                        enabled = true,
                        colored_indent_levels = true,
                    },
                    gitsigns = true,
                    native_lsp = {
                        enabled = true,
                        virtual_text = {
                            errors = { "italic" },
                            warnings = { "italic" },
                            hints = { "italic" },
                            information = { "italic" },
                        },
                        underlines = {
                            errors = { "underline" },
                            warnings = { "underline" },
                            hints = { "underline" },
                            information = { "underline" },
                        },
                    },
                },
            })
            vim.cmd.colorscheme("catppuccin")
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = 'master',
        lazy = false,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("ibl").setup()
        end,
    },
    { "MunifTanjim/nui.nvim" },
    { "mhinz/vim-startify" },
    {
        "karb94/neoscroll.nvim",
        opts = {},
    },
    { "rcarriga/nvim-notify" },
    { "RRethy/vim-illuminate" },
    {'akinsho/toggleterm.nvim', version = "*", config = true}
}
