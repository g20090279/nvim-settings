return {
    {
        "tpope/vim-fugitive",
        cmd = {
            "G", "Git", "Gdiffsplit", "Gvdiffsplit", "Ghdiffsplit", "Gread", "Gwrite", "Gedit",
            "Gsplit", "Gvsplit", "Gtabedit", "GBrowse", "GMove", "GRename", "GDelete", "GRemove",
            "Ggrep", "Glgrep", "Gclog", "Gllog", "Gcd", "Glcd",
        },
        event = "BufReadCmd fugitive://*", -- fugitive:// buffers restored by a session
    },
    {
        'lewis6991/gitsigns.nvim',
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require('gitsigns').setup()
        end
    },
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    },
}
