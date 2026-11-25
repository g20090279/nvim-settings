return {
    -- DAP (Debug Adapter Protocol) for debugging.
    -- Lazy: loads on the first require("dap") (the <leader>d* maps), which runs config/debugger.lua
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "mfussenegger/nvim-dap-python",
        },
        config = function()
            require("config.debugger")
        end,
    },

    -- DAP UI for better visualization.
    -- Keeps nvim-dap as a dependency: dapui requires dap when it loads, and a dapui map may come first
    {
        "rcarriga/nvim-dap-ui",
        lazy = true,
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio"
        },
    },

    -- DAP for Python (set up in config/debugger.lua)
    {
        "mfussenegger/nvim-dap-python",
        lazy = true,
    },
}
