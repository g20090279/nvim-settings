local M = {}

function M.get_python_path()
    local home = vim.loop.os_homedir()

    if vim.fn.has("win32") == 1 then
        return home .. "/.virtualenvs/debugpy/Scripts/python.exe"
    else
        return home .. "/.virtualenvs/debugpy/bin/python"
    end
end

function M.get_virtualenvs_path()
    local home = vim.loop.os_homedir()

    if vim.fn.has("win32") == 1 then
        return home .. "/.virtualenvs/debugpy/Scripts"
    else
        return home .. "/.virtualenvs/debugpy/bin"
    end
end

function M.get_black_path()
    local home = vim.loop.os_homedir()

    if vim.fn.has("win32") == 1 then
        return home .. "/.virtualenvs/debugpy/Scripts/black.exe"
    else
        return home .. "/.virtualenvs/debugpy/bin/black"
    end
end

function M.get_isort_path()
    local home = vim.loop.os_homedir()

    if vim.fn.has("win32") == 1 then
        return home .. "/.virtualenvs/debugpy/Scripts/isort.exe"
    else
        return home .. "/.virtualenvs/debugpy/bin/isort"
    end
end

return M
