local km = vim.keymap
local home = os.getenv("HOME") or os.getenv("USERPROFILE")

-----------------------------------------------------------
--  Keymaps for copying file name and path to clipboard  --
-----------------------------------------------------------
km.set("n", "<leader>cf", function()
	vim.fn.setreg("+", vim.fn.expand("%"))
	print("Copied file name to clipboard: " .. vim.fn.expand("%"))
end, { desc = "Copy relative path file to clipboard" })
km.set("n", "<leader>cF", function()
	vim.fn.setreg("+", vim.fn.expand("%:p"))
	print("Copied absolute path file to clipboard: " .. vim.fn.expand("%:p"))
end, { desc = "Copy absolute path file to clipboard" })
km.set("n", "<leader>cfn", function()
	vim.fn.setreg("+", vim.fn.expand("%:t"))
	print("Copied only file name to clipboard: " .. vim.fn.expand("%:t"))
end, { desc = "Copy only file name to clipboard" })
km.set("n", "<leader>cp", function()
	vim.fn.setreg("+", vim.fn.expand("%:h"))
	print("Copied relative path to clipboard: " .. vim.fn.expand("%:h"))
end, { desc = "Copy relative path to clipboard" })
km.set("n", "<leader>cP", function()
	vim.fn.setreg("+", vim.fn.expand("%:p:h"))
	print("Copied absolute path to clipboard: " .. vim.fn.expand("%:p:h"))
end, { desc = "Copy absolute path to clipboard" })

----------------------------
--  Keymaps for NERDTree  --
----------------------------
km.set("n", "<leader>ee", ":NERDTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle NvimTree" })
km.set("n", "<leader>ef", ":NERDTreeFind<CR>", { noremap = true, silent = true, desc = "Toggle NvimTree" })

--------------------------
--  Keymaps for FzfLua  --
--------------------------
km.set("n", "<leader>ff", "<cmd>FzfLua files<CR>", { desc = "Fuzzy find files" })
km.set("n", "<leader>fg", "<cmd>FzfLua live_grep_native<CR>", { desc = "Fuzzy find text" })
km.set("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { desc = "Fuzzy find buffers" })
km.set("n", "<leader>fk", "<cmd>FzfLua keymaps<CR>", { desc = "Fuzzy find keymaps" })
km.set("n", "<leader>fls", "<cmd>FzfLua lsp_document_symbols<CR>", { desc = "Fuzzy find document symbols from LSP" })
km.set("n", "<leader>flS", "<cmd>FzfLua lsp_workspace_symbols<CR>", { desc = "Fuzzy find worksapce symbols from LSP" })
km.set("n", "<leader>fli", "<cmd>FzfLua lsp_implementations<CR>", { desc = "Fuzzy find implementations from LSP" })
km.set("n", "<leader>flr", "<cmd>FzfLua lsp_references<CR>", { desc = "Fuzzy find references from LSP" })
km.set("n", "<leader>fgf", "<cmd>FzfLua git_files<CR>", { desc = "Fuzzy find git list files" })
km.set("n", "<leader>fgd", "<cmd>FzfLua git_diff<CR>", { desc = "Fuzzy find git diff {ref}" })
km.set("n", "<leader>fgc", "<cmd>FzfLua git_commits<CR>", { desc = "Fuzzy find git commit log of the project" })
km.set("n", "<leader>fgv", "<cmd>FzfLua git_bcommits<CR>", { desc = "Fuzzy find git commit log of the buffer" })
km.set("n", "<leader>fgb", "<cmd>FzfLua git_blame<CR>", { desc = "Fuzzy find git blame of the buffer" })
km.set("n", "<leader>fgs", "<cmd>FzfLua git_stash<CR>", { desc = "Fuzzy find git stash" })
km.set("n", "<leader>fgt", "<cmd>FzfLua git_tags<CR>", { desc = "Fuzzy find git tags" })
km.set("n", "<leader>fga", "<cmd>FzfLua git_branches<CR>", { desc = "Fuzzy find git branches" })
km.set("n", "<leader>fdf", "<cmd>FzfLua dap_frames<CR>", { desc = "Fuzzy find frames in DAP" })
km.set("n", "<leader>fdv", "<cmd>FzfLua dap_variables<CR>", { desc = "Fuzzy find variables in DAP" })
km.set("n", "<leader>fdb", "<cmd>FzfLua dap_breakpoints<CR>", { desc = "Fuzzy find breakpoints in DAP" })
km.set("n", "<leader>fdc", "<cmd>FzfLua dap_commands<CR>", { desc = "Fuzzy find commands in DAP" })

-----------------------------------------
--  Keymaps for .c/.cpp/.h/.hpp files  --
-----------------------------------------
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp", "objc", "objcpp", "h", "hpp" },
	callback = function(args)
		vim.api.nvim_buf_set_keymap(
			args.buf,
			"n",
			"gH",
			"<cmd>ClangdSwitchSourceHeader<CR>",
			{ noremap = true, silent = true }
		)
		km.set("n", "gd", vim.lsp.buf.definition)
		km.set("n", "gy", vim.lsp.buf.type_definition)
		km.set("n", "gs", vim.lsp.buf.workspace_symbol)
	end,
})

---------------------------
--  Keymaps for harpoon  --
---------------------------
local harpoon = require("harpoon")

harpoon:setup()
km.set("n", "<leader>ha", function()
	harpoon:list():add()
end, { desc = "Add file to Harpoon" })
km.set("n", "<leader>hs", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Toggle Harpoon menu" })

km.set("n", "<leader>h1", function()
	harpoon:list():select(1)
end, { desc = "Harpoon jump 1" })
km.set("n", "<leader>h2", function()
	harpoon:list():select(2)
end, { desc = "Harpoon jump 2" })
km.set("n", "<leader>h3", function()
	harpoon:list():select(3)
end, { desc = "Harpoon jump 3" })
km.set("n", "<leader>h4", function()
	harpoon:list():select(4)
end, { desc = "Harpoon jump 4" })

km.set("n", "<leader>hp", function()
	harpoon:list():next()
end, { desc = "Harpoon next file" })
km.set("n", "<leader>hn", function()
	harpoon:list():prev()
end, { desc = "Harpoon previous file" })

vim.keymap.set("n", "<leader>hd1", function()
	local harpoon = require("harpoon")
	harpoon:list():remove()
end, { desc = "Harpoon: remove current file" })

vim.keymap.set("n", "<leader>hd1", function()
	require("harpoon"):list():remove(1)
end)

vim.keymap.set("n", "<leader>hd2", function()
	require("harpoon"):list():remove(2)
end)

vim.keymap.set("n", "<leader>hd3", function()
	require("harpoon"):list():remove(3)
end)

vim.keymap.set("n", "<leader>hd4", function()
	require("harpoon"):list():remove(4)
end)

------------------------------------------------
--  Keymaps for DAP (Debug Adapter Protocol)  --
------------------------------------------------
local dap = require("dap")
local dapui = require("dapui")

local function set_dap_keymaps()
	km.set("n", "<Down>", dap.step_over, { silent = true, desc = "DAP Step Over" })
	km.set("n", "<Right>", dap.step_into, { silent = true, desc = "DAP Step Into" })
	km.set("n", "<Left>", dap.step_out, { silent = true, desc = "DAP Step Out" })
	km.set("n", "<Up>", dap.restart_frame, { silent = true, desc = "DAP Restart Frame" })
end

-- Remove keymaps when debug session ends
local function clear_dap_keymaps()
	km.del("n", "<Down>")
	km.del("n", "<Right>")
	km.del("n", "<Left>")
	km.del("n", "<Up>")
end

-- Set up listeners to set/clear keymaps during DAP sessions
dap.listeners.after.event_initialized["dap_keymaps"] = function()
	set_dap_keymaps()
end

dap.listeners.before.event_terminated["dap_keymaps"] = function()
	clear_dap_keymaps()
end

dap.listeners.before.event_exited["dap_keymaps"] = function()
	clear_dap_keymaps()
end

km.set("n", "<Leader>db", function()
	dap.toggle_breakpoint()
end, { noremap = true, silent = true })
km.set("n", "<Leader>dbc", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { noremap = true, silent = true })
km.set("n", "<leader>dbh", function()
	local hitCon = vim.fn.input("Break on hit (e.g. '>= 10', '==3', '% 5'): ")
	dap.set_breakpoint(nil, hitCon, nil)
end)
km.set("n", "<leader>dba", function()
	local con = vim.fn.input("Breakpoint condition: ")
	local hitCon = vim.fn.input("Break on hit (e.g. '>= 10', '==3', '% 5'): ")
	dap.set_breakpoint(con, hitCon, nil)
end)
km.set("n", "<Leader>dr", function()
	dap.continue()
end, { desc = "Continue debugging", noremap = true, silent = true })
km.set("n", "<Leader>dt", function()
	dap.run_to_cursor()
end, { desc = "Run to cursor", noremap = true, silent = true })
km.set("n", "<Leader>de", function()
	dap.terminate()
end, { noremap = true, silent = true })
km.set("n", "<Leader>dp", function()
	dap.repl.open()
end, { noremap = true, silent = true })
km.set("n", "<Leader>du", function()
	dapui.toggle()
end, { noremap = true, silent = true, desc = "Open DAP View" })
km.set("n", "<leader>d1", function()
	require("dapui").float_element("repl", { enter = true })
end)
km.set("n", "<leader>d2", function()
	require("dapui").float_element("scopes", { enter = true })
end)
km.set("n", "<leader>d3", function()
	require("dapui").float_element("stacks", { enter = true })
end)
km.set("n", "<leader>d4", function()
	require("dapui").float_element("console", { enter = true })
end)
km.set("n", "<leader>d5", function()
	require("dapui").float_element("breakpoints", { enter = true })
end)
km.set("n", "<leader>d6", function()
	require("dapui").float_element("watches", { enter = true })
end)
km.set("n", "<leader>dx", function()
	require("dapui").eval()
end, { desc = "DAP Eval under cursor" })
km.set("v", "<leader>dv", function()
	require("dapui").eval()
end, { desc = "DAP Eval selection" })

local dap_hover_enabled = false
local dap_hover_group = vim.api.nvim_create_augroup("DapHoverEval", { clear = true })

km.set("n", "<leader>dh", function()
	dap_hover_enabled = not dap_hover_enabled

	if dap_hover_enabled then
		-- Enable: create new autocmd
		vim.api.nvim_clear_autocmds({ group = dap_hover_group })
		vim.api.nvim_create_autocmd("CursorHold", {
			group = dap_hover_group,
			pattern = "*",
			callback = function()
				require("dapui").eval(nil, { enter = false })
			end,
		})
		print("DAP hover popup: ON")
	else
		-- Disable: clear autocmds AND close any open eval windows
		vim.api.nvim_clear_autocmds({ group = dap_hover_group })

		-- Close floating eval windows created by dap-ui
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			local cfg = vim.api.nvim_win_get_config(win)
			if cfg.relative ~= "" then -- floating window
				vim.api.nvim_win_close(win, true)
			end
		end

		print("DAP hover popup: OFF")
	end
end, { desc = "Toggle DAP hover auto evaluation" })

---------------------------
--  NVIM System Keymaps  --
---------------------------
km.set("n", "<leader>ncd", function()
	local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
	local target_dir

	if git_root and vim.fn.isdirectory(git_root) == 1 then
		target_dir = git_root
	else
		target_dir = vim.fn.expand("%:p:h")
	end

	vim.cmd("cd " .. target_dir)
	print("Working directory changed to: " .. target_dir)
end, { desc = "Change cwd to Git root or current file directory" })

-- Keymaps for open nvim setting files
km.set("n", "<leader>nvim", ":tabnew $MYVIMRC<CR>", { noremap = true, silent = true })
km.set(
	"n",
	"<leader>ndebug",
	":tabnew " .. home .. "/.config/nvim/lua/config/debugger.lua<CR>",
	{ desc = "Open config debugger" }
)

-- Keymaps for toggle line number and relative line number
km.set("n", "<leader>nn", function()
	if vim.wo.number == true and vim.wo.relativenumber == true then
		vim.wo.relativenumber = false
	else
		vim.wo.relativenumber = true
	end
end, { desc = "Toggle line number and relative line number" })

-- Keymaps for toggle word wrap
km.set("n", "<leader>nw", function()
	if vim.wo.wrap == true then
		vim.wo.wrap = false
	else
		vim.wo.wrap = true
	end
end, { desc = "Toggle wrap" })

-- Keymaps for toggle mouse support
km.set("n", "<leader>nm", function()
	if vim.opt.mouse:get() == "" then
		vim.opt.mouse = "a"
		print("Mouse: Enabled!")
	else
		vim.opt.mouse = ""
		print("Mouse: Disabled!")
	end
end, { desc = "Toggle mouse support" })

------------------------------------
---  Keymaps for code prettifier  --
------------------------------------
km.set("n", "<leader>pl", function()
	vim.lsp.buf.format({ async = true })
end)
km.set("n", "<leader>pf", function()
	require("conform").format({ async = true })
end, { desc = "Format file" })
km.set("v", "<leader>pg", function()
	local start_line = vim.fn.getpos("'<")[2]
	local end_line = vim.fn.getpos("'>")[2]

	require("conform").format({
		lsp_fallback = false,
		range = {
			start = { start_line, 0 },
			["end"] = { end_line, 0 },
		},
	})
end, { desc = "Format visual selection with clang-format" })

------------------------------
--  Keymaps for Toggleterm  --
------------------------------
local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
	size = 20,
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
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

function _G.set_terminal_keymaps()
	local opts = { noremap = true }
	vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

km.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
km.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Horizontal terminal" })
km.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "Vertical terminal" })
km.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Floating terminal" })

-----------------------------
--  Keymaps for undo tree  --
-----------------------------
km.set("n", "<leader>u", vim.cmd.UndotreeToggle)

----------------------------
--  Keymaps for gitsigns  --
----------------------------
local gs = require("gitsigns")

km.set("n", "<leader>gn", gs.next_hunk, { desc = "Next hunk" })
km.set("n", "<leader>gp", gs.prev_hunk, { desc = "Previous hunk" })
km.set("n", "<leader>gr", gs.reset_hunk, { desc = "Reset hunk" })
km.set("n", "<leader>gR", gs.reset_buffer, { desc = "Reset buffer" })
km.set("n", "<leader>gs", gs.stage_hunk, { desc = "Stage hunk" })
km.set("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
km.set("n", "<leader>gS", gs.stage_buffer, { desc = "Stage buffer" })
km.set("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
km.set("n", "<leader>gb", function()
	gs.blame_line({ full = true })
end, { desc = "Blame current line" })
km.set("n", "<leader>gt", gs.toggle_current_line_blame, { desc = "Toggle inline blame" })
km.set("n", "<leader>gd", gs.diffthis, { desc = "Diff this" })
km.set("n", "<leader>gD", function()
	gs.diffthis("~")
end, { desc = "Diff against HEAD" })
km.set("n", "<leader>gg", function()
	local dict = vim.b.gitsigns_status_dict
	if not dict then
		print("No gitsigns info available")
		return
	end
	print(vim.inspect(dict))
end, { desc = "Show gitsigns status dict" })

---------------------------------
--  Keymaps for vim-illuminate --
---------------------------------
km.set("n", "]c", function()
	if vim.wo.diff then
		return "]c"
	end
	vim.schedule(gs.next_hunk)
end, { desc = "Next Git hunk" })

km.set("n", "[c", function()
	if vim.wo.diff then
		return "[c"
	end
	vim.schedule(gs.prev_hunk)
end, { desc = "Prev Git hunk" })

---------------------------------
--  Keymaps for vim-illuminate --
---------------------------------
-- Go to next reference
km.set("n", "]i", function()
	require("illuminate").goto_next_reference(true)
end, { desc = "Next Reference" })

-- Go to previous reference
km.set("n", "[i", function()
	require("illuminate").goto_prev_reference(true)
end, { desc = "Prev Reference" })
