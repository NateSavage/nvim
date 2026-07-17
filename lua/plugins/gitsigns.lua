require('gitsigns').setup({
    signs = {
        add          = { hl = 'DiffAdd', text = '│' },
        change       = { hl = 'DiffChange', text = '│' },
        delete       = { hl = 'DiffDelete', text = '_', show_count = true },
        topdelete    = { hl = 'DiffDelete', text = '‾', show_count = true },
        changedelete = { hl = 'DiffChange', text = '~', show_count = true },
    },
    signcolumn = true,
})

vim.keymap.set("n", "gb", function()
    -- Check if there's a blame window open
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.api.nvim_get_option_value('filetype', { buf = buf })
        if ft == 'gitsigns-blame' then
            vim.api.nvim_win_close(win, true)
            return
        end
    end
    -- No blame window found, open one
    vim.cmd('Gitsigns blame')
end, { desc = "Toggle Git Blame" })

vim.keymap.set("n", "gj", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next Git Hunk" })
vim.keymap.set("n", "gk", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Previous Git Hunk" })
vim.keymap.set("n", "gu", "<cmd>Gitsigns rest_hunk<cr>", { desc = "Git Undo (reset selected hunk)" })
vim.keymap.set("n", "gp", "<cmd>Gitsigns preview_hunk_inline<cr>", { desc = "Git Preview (shows changes to current hunk)" })
