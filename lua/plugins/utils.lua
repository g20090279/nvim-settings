return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		lazy = true, -- loaded by the <leader>h* maps in config/keymaps.lua
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("harpoon"):setup()
		end,
	},
	{
		"stevearc/conform.nvim",
		lazy = true, -- loaded by the <leader>p* format maps in config/keymaps.lua
		cmd = "ConformInfo",
		opts = {
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
				bib = { "bibtex-tidy" }, -- conform's name has a hyphen; "bibtex_tidy" doesn't exist
				bibtex = { "bibtex-tidy" },
				tex = { "latexindent" },
				cmake = { "cmake_format" },
			},

			formatters = {
				black = {
					prepend_args = { "--line-length", "300" },
				},
				["bibtex-tidy"] = {
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
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			delay = 1000, -- before open (ms)
		},
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		cmd = { "ToggleTerm", "TermExec" },
		-- Only the open_mapping here: lazy deletes action-less keys when the plugin loads, and
		-- toggleterm maps <c-\> itself. The <leader>t* maps (config/keymaps.lua) use :ToggleTerm.
		keys = { { [[<c-\>]], mode = { "n", "i" } } },
		opts = {
			size = function(term)
				if term.direction == "vertical" then
					return vim.o.columns * 0.4 -- 40% of the screen width
				elseif term.direction == "horizontal" then
					return 20 -- 20 rows for horizontal
				end
			end,
			open_mapping = [[<c-\>]],
			hide_numbers = true,
			shade_filetypes = {},
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
		},
	},
	{
		"heilgar/bookmarks.nvim",
		dependencies = {
			"kkharji/sqlite.lua",
			-- lazy = true: otherwise the spec lazy.nvim builds from telescope's rockspec makes it a start plugin
			{ "nvim-telescope/telescope.nvim", lazy = true },
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("bookmarks").setup({
				-- your configuration comes here
				-- or leave empty to use defaults
				default_mappings = true,
				db_path = vim.fn.stdpath("data") .. "/bookmarks.db",
			})
			require("telescope").load_extension("bookmarks")
		end,
		cmd = {
			"BookmarkAdd",
			"BookmarkRemove",
			"Bookmarks",
		},
		keys = {
			{ "<leader>ba", "<cmd>BookmarkAdd<cr>", desc = "Add Bookmark" },
			{ "<leader>br", "<cmd>BookmarkRemove<cr>", desc = "Remove Bookmark" },
			{ "<leader>bj", desc = "Jump to Next Bookmark" },
			{ "<leader>bk", desc = "Jump to Previous Bookmark" },
			{ "<leader>bl", "<cmd>Bookmarks<cr>", desc = "List Bookmarks" },
			{ "<leader>bs", desc = "Switch Bookmark List" },
		},
	},
	{
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				-- core behavior
				auto_restore_last_session = false, -- avoid global restore
				root_dir = vim.fn.stdpath("data") .. "/sessions/",
				enabled = true,
				auto_save = true,
				auto_restore = false,

				-- smarter behavior
				suppressed_dirs = {
					"~/",
					"~/Downloads",
					"~/Desktop",
					"/",
				},

				-- quality of life
				git_use_branch_name = true, -- separate sessions per branch
				log_level = "error",

				-- <leader>sl (:AutoSession search) picker; fzf-lua loads when you search
				session_lens = { picker = "fzf", load_on_setup = false },
			})
			-- sessionoptions is set in config/theme.lua
		end,
	},
}
