return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{ "stevearc/conform.nvim" },
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
	},
	{ "akinsho/toggleterm.nvim", version = "*", config = true },
	{
		"heilgar/bookmarks.nvim",
		dependencies = {
			"kkharji/sqlite.lua",
			"nvim-telescope/telescope.nvim",
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
        dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			local auto_session = require("auto-session")

			auto_session.setup({
				-- core behavior
				auto_session_enable_last_session = false, -- avoid global restore
				auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
				auto_session_enabled = true,
				auto_save_enabled = true,
				auto_restore_enabled = false,

				-- smarter behavior
				auto_session_suppress_dirs = {
					"~/",
					"~/Downloads",
					"~/Desktop",
					"/",
				},

				-- quality of life
				auto_session_use_git_branch = true, -- separate sessions per branch
				log_level = "error",
			})

			-- better session content
			vim.o.sessionoptions = "buffers,curdir,tabpages,winsize,help,globals,skiprtp,folds"
		end,
	},
}
