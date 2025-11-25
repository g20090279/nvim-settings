vim.api.nvim_create_user_command("CdRoot", function()
    local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    if git_root and git_root ~= "" then
        vim.cmd("cd " .. git_root)
        print("Changed dir to " .. git_root)
    else
        print("Not inside a Git repo")
    end
end, {})

require("config.options")
require("config.lazy")
require("config.theme")
require("config.lsp")
require("config.cmp")
require("config.file-explorer")
require("config.statusline")
require("config.debugger")
require("config.ai")
require("config.search")
require("config.utils")
require("config.keymaps")
