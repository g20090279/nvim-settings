return {
	-- { "junegunn/seoul256.vim" },
	-- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				integrations = {
					indent_blankline = {
						enabled = true,
						colored_indent_levels = true,
					},
					gitsigns = true,
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = { "italic" },
							warnings = { "italic" },
							hints = { "italic" },
							information = { "italic" },
						},
						underlines = {
							errors = { "underline" },
							warnings = { "underline" },
							hints = { "underline" },
							information = { "underline" },
						},
					},
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	-- Extra colorschemes for the theme cycler (<leader>nc); loaded on demand by :colorscheme
	{ "folke/tokyonight.nvim", lazy = true },
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			require("ibl").setup()
		end,
	},
	{ "MunifTanjim/nui.nvim" },
	{ "mhinz/vim-startify" },
	-- {
	--     "karb94/neoscroll.nvim",
	--     opts = {},
	-- },
	{ "rcarriga/nvim-notify" },
	{ "RRethy/vim-illuminate" },
	{
		"kevinhwang91/nvim-hlslens",
		config = function()
			require("hlslens").setup()

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
		end,
	},
}
