-- nixpkgs-unstable ships nvim-treesitter's full rewrite ("main" branch),
-- which dropped the old require("nvim-treesitter.configs").setup({...})
-- compat API entirely (the module doesn't exist anymore) - see
-- https://github.com/nvim-treesitter/nvim-treesitter for the current one.

-- Indentation is separate per the new API and still marked experimental
-- upstream - opt-in per filetype rather than globally, in case any of
-- these need falling back to normal indentexpr.
vim.api.nvim_create_autocmd('FileType', {
    pattern = {
        'lua', 'odin', 'python', 'rust', 'sql',
        'c', 'cpp', 'c_sharp',
        'gdscript', 'gdshader',
        'bash', 'just', 'nix',
        'html', 'css',
    },
    callback = function()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

vim.cmd([[highlight! link @class_name_statement.name Type]])

-- nvim-treesitter sometimes passes invalid TSNodes to get_node_text during
-- injection processing; node:range() crashes on them even though node ~= nil
local orig_get_node_text = vim.treesitter.get_node_text
vim.treesitter.get_node_text = function(node, ...)
    if node == nil then return '' end
    local ok, result = pcall(orig_get_node_text, node, ...)
    return ok and result or ''
end

-- start (or restart, if a crash killed it) treesitter highlighting
vim.api.nvim_create_autocmd('BufEnter', {
    callback = function(ev)
        local buf = ev.buf
        if vim.bo[buf].buftype ~= '' then return end
        if not vim.treesitter.highlighter.active[buf] then
            pcall(vim.treesitter.start, buf)
        end
    end,
})
