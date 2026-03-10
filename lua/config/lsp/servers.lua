local common = require("config.lsp.common")
local python = require("common.python")

local function config_server(name, conf)
	local settings = nil
	if name == "ltex" then
		settings = {
			ltex = {
				language = "en-US",
				enabled = {
					"latex",
					"tex",
					"bib",
					"markdown",
					"org",
					"rst",
				},
			},
		}
	elseif name == "pyright" then
		settings = {
			python = {
				pythonPath = python.get_python_path(),
			},
		}
	end

	-- Use vim.fs.find to detect markers
	local root_dir = vim.fs.find(conf.root_markers or {}, { upward = true })[1]
	if root_dir then
		root_dir = vim.fs.dirname(root_dir)
	else
		root_dir = vim.loop.cwd() -- fallback to current directory
	end

	vim.lsp.config(name, {
		cmd = conf.cmd,
		root_dir = root_dir,
		on_attach = common.on_attach,
		capabilities = common.capabilities,
		settings = settings,
	})
end

local servers = {
	lua_ls = {
		cmd = { "lua-language-server" },
		root_markers = { ".git", "init.lua" },
	},
	pyright = {
		cmd = { "pyright-langserver", "--stdio" },
		root_markers = { ".git", "pyproject.toml", "setup.py" },
	},
	clangd = {
		cmd = { "clangd" },
		root_markers = { ".git", "compile_commands.json" },
	},
	bashls = {
		cmd = { "bash-language-server", "start" },
		root_markers = { ".git" },
	},
	ltex = {
		cmd = { "ltex-ls" },
		root_markers = {
			".git",
			".ltex.dictionary",
			".ltex.toml",
		},
	},
}

for name, config in pairs(servers) do
	config_server(name, config)
	vim.lsp.enable(name)
end
