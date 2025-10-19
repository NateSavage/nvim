vim.opt.number = true

-- relative line numbers with the selected line being absolute
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.showtabline = 2

-- TODO: set tab length to be variable per file type, 4 makes sense for C#, 2 makes sense for lua
-- 8 space tabs being the default is crazy
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.colorcolumn = "121" --"+1" -- highlight column after text width
--vim.opt.textwidth = 120
vim.opt.wrap = true
vim.opt.linebreak = true

-- long running undo files
--vim.opt.swapfile = false
--vim.opt.backup = false
--vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
--vim.opt.undofile = true

-- incremental search filter feedback
vim.opt.incsearch = true

-- tell vim our terminal supports more colors
vim.opt.termguicolors = true

-- number of characters to retain on screen when scrolling up and down
vim.opt.scrolloff = 8

-- milliseconds before swap buffer is automatically written, and time to wait for command holds
vim.opt.updatetime = 50



