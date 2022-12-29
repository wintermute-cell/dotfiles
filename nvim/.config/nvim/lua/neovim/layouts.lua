local layouts = {
    wired_cafe = {"split", "resize 12", "vsplit", "term", "wincmd p", "term"}
}

local function open_splits(cwd)
    -- determine what layout shall be used by matching the cwd
    local layout
    for l, _ in pairs(layouts) do
        if string.match(cwd, ".*".. l ..".*") ~= nil then
            layout = l
            break
        end
    end
    -- run the commands registered for the path
    if layout ~= nil then
        for _, c in pairs(layouts[layout]) do
            vim.api.nvim_command(c)
        end
    end
end

-- we cant use 
local function cb()
    open_splits(vim.fn.getcwd())
end

-- Create the BufEnter autocommand
vim.api.nvim_create_autocmd({"VimEnter"}, {pattern = {"*"}, callback=cb})
