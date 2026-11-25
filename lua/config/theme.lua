--vim.g.seoul256_background = 233
--vim.cmd.colorscheme("seoul256")  -- seoul256-light
-- vim.api.nvim_set_hl(0, "CursorLine", { bg = "#333333" })
vim.opt.termguicolors = true
vim.cmd.colorscheme("catppuccin")

-- nvim -d
local function set_diff_highlights()
	vim.api.nvim_set_hl(0, "DiffAdd", {
		bg = "#264f36",
	})
	vim.api.nvim_set_hl(0, "DiffDelete", {
		fg = "#ff6b6b",
		bg = "#3c1f1f",
	})
	vim.api.nvim_set_hl(0, "DiffChange", {
		bg = "#1e3a5f",
	})
	vim.api.nvim_set_hl(0, "DiffText", {
		bg = "#007acc",
		bold = true,
	})
end

set_diff_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = set_diff_highlights,
})

-- toggleterm is configured in lua/plugins/utils.lua, its terminal keymaps in config/keymaps.lua

-- setup startify
vim.g.startify_lists = {
	{ type = "sessions", header = { "   Sessions" } },
	{ type = "files", header = { "   Recent files" } },
	{ type = "dir", header = { "   Current dir" } },
}
vim.g.startify_session_dir = vim.fn.stdpath("data") .. "/sessions"
vim.o.sessionoptions = "buffers,curdir,tabpages,winsize,help,globals,skiprtp,folds"

-- Ensure parsers after startup: install() checks every parser directory, which is slow on NFS
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	once = true,
	callback = function()
		require("nvim-treesitter").install({ "bash", "c", "cpp", "lua", "python", "markdown", "javascript", "rust", "go" })
	end,
})

-- hlslens is set up by its plugin spec; the maps below load it on first use

local kopts = { noremap = true, silent = true }
vim.api.nvim_set_keymap(
	"n",
	"n",
	[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
	kopts
)
vim.api.nvim_set_keymap(
	"n",
	"N",
	[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
	kopts
)
vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap("n", "<Leader>l", "<Cmd>noh<CR>", kopts)
