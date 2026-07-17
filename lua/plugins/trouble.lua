require('trouble').setup({})

vim.keymap.set("n", "td", "<cmd>Trouble diagnostics toggle focus=true<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "ts", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
vim.keymap.set("n", "tr", "<cmd>Trouble lsp toggle focus=true win.position=top<cr>", { desc = "LSP Definitions / references / ... (Trouble)" })
