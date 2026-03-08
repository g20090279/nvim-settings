local home = os.getenv("HOME") or os.getenv("USERPROFILE")

require("dapui").setup({
	layouts = {
		{
			elements = {
				{ id = "scopes", size = 1 },
			},
			size = 40, -- width of Left panel
			position = "left",
		},
		{
			elements = {
				{ id = "repl", size = 1 },
				-- { id = "console", size = 0.5 },
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
	if git_root and vim.fn.isdirectory(git_root) == 1 then
		return git_root
	else
		return vim.fn.expand("%:p:h") -- directory of current file
	end
end

local function get_current_file_dir()
	return vim.fn.expand("%:p:h")
end

-- Configure dap for C/C++/Rust
dap.adapters.gdb = {
	type = "executable",
	command = home .. "/.local/gdb/bin/gdb",
	args = { "--interpreter=dap" },
}

dap.adapters.cppdbg = {
	type = "executable",
	command = home .. "/.vscode-server/extensions/ms-vscode.cpptools-1.28.3-linux-x64/debugAdapters/bin/OpenDebugAD7",
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
		name = "Debug NRSim",
		type = "cppdbg",
		-- type = 'codelldb',  -- support more features, such as hit-count breakpoint, ensure to install codelldb, for example, by using Mason
		request = "launch",
		cwd = get_project_root(),
		program = "nrsim_dbg",
		args = { "/path/to/autorun" },
		exterminalConsole = true, -- suppress the warning gdb failed to set controlling terminal
		setupCommands = {
			{
				description = "Enable pretty-printing for gdb",
				text = "-enable-pretty-printing",
				ignoreFailures = true,
			},
			{
				description = "Enable Eigen Library Pretty Printer",
				text = "python import sys; sys.path.insert(0, '${env:HOME}/opt/eigen-3.4.0/debug/gdb')",
			},
			{
				description = "Load Eigen Pretty Printer",
				text = "source ${env:HOME}/opt/eigen-3.4.0/debug/gdb/eigen_printers.py",
				ignoreFailures = true,
			},
			{
				description = "Add VBit Pretty Printer",
				text = "source ${env:HOME}/opt/ASIP-Pretty-Printer/trv32p5x_chess_pretty_printing.py",
				ignoreFailures = true,
			},
			{
				description = "Set GDB log file",
				text = "-gdb-set logging file gdb.log." .. os.date("%Y%m%d%H%M%S") .. ".log",
				ignoreFailures = true,
			},
			{
				description = "Overwrite log file",
				text = "set logging overwrite on",
				ignoreFailures = true,
			},
			{
				description = "Disable pagination",
				text = "set pagination off",
				ignoreFailures = true,
			},
			{
				description = "Show all array elements",
				text = "set print elements 0",
				ignoreFailures = true,
			},
			{
				description = "Trace commands",
				text = "set trace-commands on",
				ignoreFailures = true,
			},
			{
				description = "Print current working directory",
				text = "pwd",
				ignoreFailures = true,
			},
			-- {
			--     description = 'Load Additional Setting',
			--     text = 'source ${env:HOME}/nfs/home/zekai.liang/opt/runNrsim/printForAsip/pyprint_mrc_normHSqr.py',
			--     ignoreFailures = true
			-- },
		},
	},
	{
		name = "Debug fw-top",
		type = "cppdbg",
		request = "launch",
		cwd = get_project_root(),
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		setupCommands = {
			{
				description = "Enable pretty-printing for gdb",
				text = "-enable-pretty-printing",
				ignoreFailures = true,
			},
			{
				description = "Set GDB log file",
				text = "-gdb-set logging file gdb.log." .. os.date("%Y%m%d%H%M%S") .. ".log",
				ignoreFailures = true,
			},
			{
				description = "Overwrite log file",
				text = "set logging overwrite on",
				ignoreFailures = true,
			},
			{
				description = "Disable pagination",
				text = "set pagination off",
				ignoreFailures = true,
			},
			{
				description = "Show all array elements",
				text = "set print elements 0",
				ignoreFailures = true,
			},
			{
				description = "Trace commands",
				text = "set trace-commands on",
				ignoreFailures = true,
			},
		},
		environment = {
			{
				name = "DSP_TEST_VECTOR_DIR",
				value = home .. "/workspace/dsp-test-vectors",
			},
		},
	},
	{
		name = "Debug asip",
		type = "cppdbg",
		request = "launch",
		cwd = get_project_root(),
		-- program = function()
		--     return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		-- end,
		program = "/path/to/binary",
		setupCommands = {
			{
				description = "Enable pretty-printing for gdb",
				text = "-enable-pretty-printing",
				ignoreFailures = true,
			},
			{
				description = "Add VBit Pretty Printer",
				text = "source ${env:HOME}/path/to/pretty-printer",
				ignoreFailures = true,
			},
			{
				description = "Load local .gdbinit",
				text = "source ${env:HOME}/.gdbinit",
				ignoreFailures = true,
			},
			{
				description = "Set GDB log file",
				text = "-gdb-set logging file gdb.log." .. os.date("%Y%m%d%H%M%S") .. ".log",
				ignoreFailures = true,
			},
			{
				description = "Overwrite log file",
				text = "set logging overwrite on",
				ignoreFailures = true,
			},
			{
				description = "Disable pagination",
				text = "set pagination off",
				ignoreFailures = true,
			},
			{
				description = "Show all array elements",
				text = "set print elements 0",
				ignoreFailures = true,
			},
			{
				description = "Trace commands",
				text = "set trace-commands on",
				ignoreFailures = true,
			},
		},
	},
	{
		name = "Launch GDB",
		type = "gdb",
		request = "launch",
		cwd = get_project_root(),
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
	{
		name = "Launch",
	},
}
dap.configurations.c = dap.configurations.cpp

-- Configure dap for Python
local uname = vim.loop.os_uname() -- Get the system information
local is_windows = uname and uname.sysname == "Windows_NT" -- Check if the system is Windows
local pythonBinPath
if is_windows then
	print("Configuring python debugger for Windows")
	pythonBinPath = home .. "/.virtualenvs/debugpy/Scripts/python.exe"
else
	print("Configuring python debugger for Windows")
	pythonBinPath = home .. "/.virtualenvs/debugpy/bin/python"
end
require("dap-python").setup(pythonBinPath, {
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
		cwd = get_current_file_dir(),
		program = "${file}",
		console = "integratedTerminal", -- or "externalTerminal" if needed
		pythonPath = function()
			return pythonBinPath
		end,
	},
	{
		name = "Debug Autorun",
		type = "python",
		request = "launch",
		cwd = get_current_file_dir(),
		program = "${file}",
		args = { "-n" }, -- ← Your script's arguments
		console = "integratedTerminal", -- or "externalTerminal" if needed
		pythonPath = function()
			return pythonBinPath
		end,
	},
}
