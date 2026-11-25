vim.opt.number = true
--vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.updatetime = 300
vim.opt.timeoutlen = 400 -- shorter wait on maps that are also a prefix (e.g. <leader>fg / <leader>fgf)
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "0"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
vim.opt.foldnestmax = 3

-- Keep swap files off NFS: they are written while you edit, and every write waits on the network
local state_fs = vim.uv.fs_statfs(vim.fn.stdpath("state"))
if state_fs and state_fs.type == 0x6969 then -- NFS_SUPER_MAGIC
	local swapdir = "/var/tmp/nvim-swap-" .. vim.uv.os_get_passwd().username
	pcall(vim.fn.mkdir, swapdir, "p", tonumber("700", 8))
	local st = vim.uv.fs_lstat(swapdir) -- /var/tmp is shared: only use a real dir we own
	if st and st.type == "directory" and st.uid == vim.uv.getuid() then
		vim.opt.directory = swapdir .. "//"
	end
end


-- for toggleterm, original blue is not visible there. Therefore, use another blue
vim.g.terminal_color_4 = "#00afff"  -- blue
vim.g.terminal_color_12 = "#00afff" -- bright blue
-- clipboard is set in init.lua (OSC 52 under Zellij, unnamedplus otherwise)
