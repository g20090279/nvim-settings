--vim.g.seoul256_background = 233
--vim.cmd.colorscheme("seoul256")  -- seoul256-light
-- vim.api.nvim_set_hl(0, "CursorLine", { bg = "#333333" })

-- setup startify
vim.g.startify_lists = {
	{ type = "sessions", header = { "   Sessions" } },
	{ type = "files", header = { "   Recent files" } },
	{ type = "dir", header = { "   Current dir" } },
}
vim.g.startify_session_dir = vim.fn.stdpath("data") .. "/sessions"
vim.o.sessionoptions = "buffers,curdir,tabpages,winsize,help,globals,skiprtp,folds"

-- Install or update parsers explicitly with :TSInstall and :TSUpdate.

-- Enable treesitter highlighting for any buffer whose language has a parser
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("TreesitterHighlight", { clear = true }),
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)
	end,
})

require("illuminate").configure({
	providers = {
		"lsp",
		"regex",
	},
})
