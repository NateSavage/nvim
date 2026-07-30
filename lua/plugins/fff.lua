-- Fast Fuzzy Finder binary is downloaded and managed by the nix flake
--
require('fff').setup({
    prompt = '🕯 ',
    frecency = {
        enabled = true,
        db_path = vim.fn.stdpath('cache') .. '/fff_nvim',
    },
    history = {
        enabled = true,
        db_path = vim.fn.stdpath('data') .. '/fff_queries',
    },
    layout = {
        height = 0.85,
        width = 0.85,
        prompt_position = 'bottom', -- or 'top'
        preview_position = 'right', -- or 'left', 'right', 'top', 'bottom'
        preview_size = 0.5,
    },
    debug = {
        enabled = false,
        show_scores = false,
    },
    keymaps = {
        move_up = { '<Up>', '<A-k>' },
        move_down = { '<Down>', '<A-j>' },
        preview_scroll_up = { '<C-u>', '<C-k>' },
        preview_scroll_down = { '<C-d>', '<C-j>' },
        close = { '<Esc>', '<C-c>' },
        select = '<CR>',
    },
})

vim.keymap.set("n", "ff", function() require('fff').find_files() end, { desc = 'FFFind files' })
vim.keymap.set("n", "fg", function() require('fff').find_in_git_root() end, { desc = 'FFFind files in git' })
