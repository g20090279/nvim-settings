return {
    -- { "junegunn/seoul256.vim" },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = 'master',
        lazy = false,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
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
