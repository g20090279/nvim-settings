local python = require("common.python")

require("dapui").setup({
	layouts = {
		{
			elements = {
				{ id = "breakpoints", size = 0.1 },
				{ id = "watches", size = 0.1 },
				{ id = "stacks", size = 0.2 },
				{ id = "scopes", size = 0.6 },
			},
			size = 40, -- width of Left panel
			position = "left",
		},
		{
			elements = {
				{ id = "repl", size = 0.5 },
				{ id = "console", size = 0.5 },
			},
			size = 10, -- hight of bottome panel
			position = "bottom",
		},
	},
})

-- Brighter DAP signs
local cp = require("catppuccin.palettes").get_palette("mocha")
vim.fn.sign_define("DapBreakpoint", {
	text = "●",
	texthl = "DapBreakpoint",
	linehl = "",
	numhl = "",
})

vim.fn.sign_define("DapBreakpointCondition", {
	text = "", -- or "?" / "" / "ﳁ"
	texthl = "DapBreakpointCondition",
	linehl = "",
	numhl = "",
})

vim.fn.sign_define("DapStopped", {
	text = "▶",
	texthl = "DapStopped",
	linehl = "",
	numhl = "",
})

vim.fn.sign_define("DapBreakpointRejected", {
	text = "",
	texthl = "DapBreakpointRejected",
	linehl = "",
	numhl = "",
})
vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = cp.red })
vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = cp.yellow })
vim.api.nvim_set_hl(0, "DapStopped", { fg = cp.green })
vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = cp.maroon })

-- Make REPL nice to read
vim.api.nvim_create_autocmd("FileType", {
	pattern = "dap-repl",
	callback = function()
		vim.opt_local.wrap = true -- wrap long lines
		vim.opt_local.linebreak = true -- wrap at word boundaries
		vim.opt_local.breakindent = true -- indent wrapped lines
		vim.opt_local.scrollback = 10000 -- large scrollback
	end,
})

local dap = require("dap")

local function get_project_root()
	local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
	if vim.v.shell_error == 0 and git_root and vim.fn.isdirectory(git_root) == 1 then
		return git_root
	else
		return vim.fn.expand("%:p:h") -- directory of current file
	end
end

-- Configure dap for C/C++/Rust
dap.adapters.gdb = {
	type = "executable",
	command = "gdb",
	args = { "--interpreter=dap" },
}

dap.adapters.cppdbg = {
	type = "executable",
	command = "OpenDebugAD7",
	id = "cppdbg",
}

dap.adapters.executable = {
	type = "executable",
	command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
	name = "lldb1",
	host = "127.0.0.1",
	port = 13000,
}

dap.adapters.codelldb = {
	name = "codelldb server",
	type = "server",
	port = "${port}",
	executable = {
		command = "codelldb",
		args = { "--port", "${port}" },
		env = {
			RUST_LOG = "debug",
		},
	},
}

dap.configurations.cpp = {
	{
		name = "Launch GDB",
		type = "gdb",
		request = "launch",
		cwd = get_project_root, -- evaluated by nvim-dap when the session starts
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		stopAtBeginningOfMainSubprogram = false,
	},
	{
		name = "Launch LLDB",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopAtBeginningOfMainSubprogram = false,
	},
}
dap.configurations.c = dap.configurations.cpp

-- Configure dap for Python
require("dap-python").setup(python.get_python_path(), {
	rocks = {
		enabled = true,
	},
}) -- path to python with debugpy

---
-- Create debugpy virtual environment:
-- $ mkdir ~/.virtualenvs
-- $ cd ~/.virtualenvs
-- $ python3 -m venv debugpy
-- $ debugpy/bin/python -m pip install debugpy
--
-- Use debugpy virtual environment in terminal:
-- $ source ~/.virtualenvs/debugpy/bin/activate
--
-- After activate virtual environment, can update / install packages:
-- $ python -m pip install --upgrade pip    # update pip in virtual environment
-- $ pip install --upgrade <package_name>   # package name like debugpy
-- $ pip install <package_name>             # package name like numpy
--
-- To exit the virtual environment:
-- $ deactivate
---

require("dap").configurations.python = {
	{
		name = "Launch debugpy",
		type = "python",
		request = "launch",
		cwd = "${fileDirname}",
		program = "${file}",
		console = "integratedTerminal", -- or "externalTerminal" if needed
	},
	{
		name = "Debug Autorun",
		type = "python",
		request = "launch",
		cwd = "${fileDirname}",
		program = "${file}",
		args = { "-n" }, -- ← Your script's arguments
		console = "integratedTerminal", -- or "externalTerminal" if needed
	},
}

-- Machine-specific debugger settings are kept out of version control.
local local_config = vim.fn.stdpath("config") .. "/lua/config/debugger_local.lua"
if vim.fn.filereadable(local_config) == 1 then
	dofile(local_config)
end
