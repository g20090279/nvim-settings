local bigfile_size = 1.5 * 1024 * 1024 -- bytes

-- Big files (e.g. NRSim dumps, up to 16 MB / 500k lines): the treesitter foldexpr would run
-- once per line, so fold manually, skip the swap file, and skip treesitter (below)
vim.api.nvim_create_autocmd("BufReadPre", {
	group = vim.api.nvim_create_augroup("BigFile", { clear = true }),
	callback = function(args)
		local stat = vim.uv.fs_stat(args.match)
		if stat and stat.size > bigfile_size then
			vim.b[args.buf].bigfile = true
			vim.opt_local.foldmethod = "manual"
			vim.opt_local.swapfile = false
		end
	end,
})

-- Treesitter highlighting for the filetypes with an installed parser
-- (lua, markdown and help already start it from Neovim's own ftplugins)
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true }),
	pattern = { "sh", "bash", "c", "cpp", "go", "javascript", "python", "rust", "matlab" },
	callback = function(args)
		if not vim.b[args.buf].bigfile then
			pcall(vim.treesitter.start, args.buf) -- pcall: a machine may lack the parser
		end
	end,
})
