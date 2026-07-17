
-- every file here runs unconditionally at startup, in list order.
local plugins = {
    "gitsigns",
    "inc-rename",
    "indent-blankline",
    "lualine",
    "microscope",
    "neoscroll",
    "nvim-dap",
    "nvim-dap-virtual-text",
    "nvim-origami",
    "nvim-scrollbar",
    "smearcursor",
    "telescope",
    "treesitter",
    "trouble",
    "yazi",
    "blink",
    "fff",

    -- not loaded
    -- "avante"
    -- "nvim-dap-ui"
    -- "godotdev"
}

-- runs each plugin's own setup()/keymap code, in place of what lazy.nvim used to do with each file's `opts`/`config`/`keys` table.
for _, name in ipairs(plugins) do
    local ok, err = pcall(require, "plugins." .. name)
    if not ok then
        vim.notify("plugin config failed: " .. name .. "\n" .. err, vim.log.levels.ERROR)
    end
end
