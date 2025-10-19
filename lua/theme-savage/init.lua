local M = {}

function M.setup()
    vim.o.background = 'dark'
    vim.g.colors_name = 'savage'
    
    local util = require("theme-savage.util")
    local theme = require("theme-savage.theme")
    util.load(theme)
end
    
return M
