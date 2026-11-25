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
	elseif name == "texlab" then
		settings = {
			texlab = {
				bibtexFormatter = "texlab",
			},
		}
	elseif name == "pyright" then
		settings = {
			python = {
				pythonPath = python.get_python_path(),
			},
		}
	end

	-- root_markers lets Neovim find the project root per buffer (searching upward
	-- from each opened file); if omitted, nvim-lspconfig's default for the server is used.
	vim.lsp.config(name, {
		cmd = conf.cmd,
		root_markers = conf.root_markers,
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
	texlab = {
		cmd = { "texlab" },
	},
	matlab_ls = {
		cmd = { "matlab-language-server", "--stdio" },
		-- markers are exact names, so match the project file extensions with a function
		root_markers = {
			".git",
			function(name)
				return name:match("%.prj$") ~= nil or name:match("%.mlproj$") ~= nil
			end,
		},
	},
}

for name, config in pairs(servers) do
	config_server(name, config)
	vim.lsp.enable(name)
end

---------------------------
--- Reduce LSP log file ---
---------------------------
vim.lsp.log.set_level("ERROR")

local log_path = vim.lsp.log.get_filename()

local stat = vim.uv.fs_stat(log_path)

-- truncate if larger than 10 MB
if stat and stat.size > 10 * 1024 * 1024 then
    local fd = io.open(log_path, "w")
    if fd then
        fd:close()
    end
end
