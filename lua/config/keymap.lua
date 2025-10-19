
-- shift selected lines up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- shift selected lines left (ctrl by tabs, shift by spaces, alt shifts to line start
vim.keymap.set("v", "H", ":s/^ // <CR>:nohl<CR>gv")
vim.keymap.set("v", "<C-h>", ":s/^[\\t]\\| \\{1,2}//<CR>:nohl<CR>gv")
vim.keymap.set("v", "<A-h>", ":s/^[\\t+]\\| \\+//<CR>:nohl<CR>gv")
-- shift selected lines right (crtl by tabs, shift by spaces)
vim.keymap.set("v", "<C-l>", ":'<,'> normal! I\t<Esc> v gv")
vim.keymap.set("v", "L", ":'<,'> normal! I <Esc> v gv")

-- gv reselects previously selected text
-- = aligns text to tab boundaries
-- <CR> simulates hitting the enter key
-- v enters visual mode
-- I inserts the following character
-- normal! enters normal editing mode
-- :nohl<CR> clears selected highlighting
-- :s substitutes using a regex expression
