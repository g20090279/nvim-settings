local common = require("config.lsp.common")

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
                bibtexFormatter = "texlab"
            }
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
        cmd = { "texlab" }
    }
}

for name, config in pairs(servers) do
	config_server(name, config)
	vim.lsp.enable(name)
end
