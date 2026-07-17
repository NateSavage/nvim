-- mark netrw as loaded so it's not loaded at all.
-- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
vim.g.loaded_netrwPlugin = 1

require('yazi').setup({
    -- if you want to open yazi instead of netrw, see below for more info
    open_for_directories = false,
    keymaps = {
        show_help = "<f1>",
    },
})

vim.keymap.set({ "n", "v" }, "fd", "<cmd>Yazi<cr>", { desc = "Find Directory (open yazi to current file directory)" })
vim.keymap.set("n", "<leader>cw", "<cmd>Yazi cwd<cr>", { desc = "Open the file manager in nvim's working directory" })
vim.keymap.set("n", "<c-up>", "<cmd>Yazi toggle<cr>", { desc = "Resume the last yazi session" })
