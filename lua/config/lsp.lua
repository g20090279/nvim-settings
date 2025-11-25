require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "pyright", "clangd" }
})

local navic = require("nvim-navic")
local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end
end

-------------------------------
-- New API of nvim-lspconfig --
-------------------------------
-- This is defined in nvim-lspconfig. 
-- Since we now use vim.lsp.start() to start server, the extra commands are
--   - ClangdSwitchSourceHeader
--   - ClangdAST
--   - ClangdTypeHierarchy
--   - ClangdMemoryUsage
-- Therefore, must be global so Neovim can call it
function _G.ClangdSwitchSourceHeader()
    local params = { uri = vim.uri_from_bufnr(0) }
    vim.lsp.buf_request(0, "textDocument/switchSourceHeader", params, function(err, result)
        if err then
            vim.notify("clangd: " .. err.message, vim.log.levels.ERROR)
            return
        end
        if not result then
            vim.notify("No corresponding header/source file found")
            return
        end
        vim.cmd("edit " .. vim.uri_to_fname(result))
    end)
end

vim.api.nvim_create_user_command("ClangdSwitchSourceHeader", _G.ClangdSwitchSourceHeader, {})

local function find_root(root_files)
    local path = vim.fs.find(root_files, { upward = true })[1]
    if path then
        return vim.fs.dirname(path)
    end
end

local function start_server(name, cmd, root_files)
    local root_dir = find_root(root_files)

    if not root_dir then
        -- vim.notify("No root found for " .. name .. ", skipping")
        return
    end

    vim.lsp.start({
        name = name,
        cmd = cmd,
        root_dir = root_dir,
        on_attach = on_attach,
        capabilities = cmp_capabilities,
    })
end

local servers = {
    lua_ls = {
        cmd = { "lua-language-server" },
        root_files = { ".git", "init.lua" },
    },
    pyright = {
        cmd = { "pyright-langserver", "--stdio" },
        root_files = { ".git", "pyproject.toml", "setup.py" },
    },
    clangd = {
        cmd = { "clangd" },
        root_files = { ".git", "compile_commands.json" },
    },
    bashls = {
        cmd = { "bash-language-server", "start" },
        root_files = { ".git" },
    },
}

for name, config in pairs(servers) do
    start_server(name, config.cmd, config.root_files)
end

vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
