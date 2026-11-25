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
			-- colorscheme is applied in config/theme.lua
		end,
	},
	-- Extra colorschemes for the theme cycler (<leader>nc); loaded on demand by :colorscheme
	{ "folke/tokyonight.nvim", lazy = true },
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("ibl").setup()
		end,
	},
	{ "mhinz/vim-startify" },
	-- {
	--     "karb94/neoscroll.nvim",
	--     opts = {},
	-- },
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("illuminate").configure({
				providers = {
					"lsp",
					"regex",
				},
			})
		end,
	},
	-- loaded by the n/N/*/# maps in config/theme.lua
	{
		"kevinhwang91/nvim-hlslens",
		lazy = true,
		config = function()
			require("hlslens").setup()
		end,
	},
}
