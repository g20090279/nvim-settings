if vim.env.ZELLIJ then
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = function()
        return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
      end,
      ["*"] = function()
        return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
      end,
    },
  }
else
  vim.opt.clipboard = "unnamedplus"
end

vim.api.nvim_create_user_command("CdRoot", function()
    local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    if vim.v.shell_error == 0 and git_root and git_root ~= "" then
        vim.cmd.cd({ args = { git_root } })
        print("Changed dir to " .. git_root)
    else
        print("Not inside a Git repo")
    end
end, {})

vim.api.nvim_create_user_command("AutoSessionRemoveAll", function()
    local session_dir = vim.fn.stdpath("data") .. "/sessions/"
    vim.fn.delete(session_dir, "rf")
    vim.notify("All auto-session sessions deleted!", vim.log.levels.INFO)
end, {})

require("config.options")
require("config.lazy")
require("config.theme")
require("config.lsp.servers")
require("config.lsp.mason")
require("config.statusline")
require("config.keymaps")
require("config.autocmds")
-- config.cmp and config.debugger are loaded by their plugin specs (lua/plugins/)
