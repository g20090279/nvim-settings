-- toggleterm (the only place it is configured; keymaps are in keymaps.lua)
require("toggleterm").setup({
	size = function(term)
		if term.direction == "vertical" then
			return math.floor(vim.o.columns * 0.3) -- 30% of the screen width
		end
		return 20 -- 20 rows for horizontal
	end,
	open_mapping = [[<c-\>]],
	hide_numbers = true,
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
		winblend = 3,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

-- Terminal-mode keymaps: <Esc> to leave insert, <C-hjkl> to move between windows
vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("TerminalKeymaps", { clear = true }),
	pattern = "term://*",
	callback = function(args)
		local opts = { buffer = args.buf }
		vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
		vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
		vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
		vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
		vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
	end,
})

-- configure harpoon
local harpoon = require("harpoon")
harpoon:setup()

-- configure conform
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		--rust = { "rustfmt", lsp_format = "fallback" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		c = { "clang_format" },
		cpp = { "clang_format" },
		h = { "clang_format" },
		hpp = { "clang_format" },
		sh = { "shfmt" },
		bash = { "shfmt" },
		markdown = { "prettier" },
		bib = { "bibtex_tidy" },
		bibtex = { "bibtex_tidy" },
		tex = { "latexindent" },
		cmake = { "cmake_format" },
	},

	formatters = {
		black = {
			prepend_args = { "--line-length", "300" },
		},
		bibtex_tidy = {
			command = "bibtex-tidy",
			args = {
				"--curly",
				"--numeric",
				"--space=2",
				"--align=13",
				"--sort=key",
				"--duplicates=key",
				"--merge",
				"--strip-comments",
				"--trailing-commas=false",
			},
			stdin = true,
		},
	},
})

-- confgiure which-key
require("which-key").setup({
	delay = 1000, -- before open (ms)
})
