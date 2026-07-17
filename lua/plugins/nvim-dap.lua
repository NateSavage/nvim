vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

local dap = require('dap')
dap.adapters.godot = {
    type = "server",
    host = '127.0.0.1',
    port = 6006,
    options = {
        initialize_timeout_sec = 10
    }
}
dap.configurations.gdscript = {{
    type = "godot",
    request = "launch",
    name = "Launch scene",
    project = "${workspaceFolder}",
    --[[
    "address": "127.0.0.1",
    "port": 6007,
    "scene": "main|current|pinned|<path>",
    "editor_path": "<path>",

    // engine command line flags
    "profiling": false,
    "single_threaded_scene": false,
    "debug_collisions": false,
    "debug_paths": false,
    "debug_navigation": false,
    "debug_avoidance": false,
    "debug_stringnames": false,
    "frame_delay": 0,
    "time_scale": 1.0,
    "disable_vsync": false,
    "fixed_fps": 60,

    // anything else
    "additional_options": ""
    ]]--
}}

vim.keymap.set("n", "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = "Breakpoint Condition" })
vim.keymap.set("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dc", function() require("dap").continue() end, { desc = "Run/Continue" })
vim.keymap.set("n", "<leader>da", function() require("dap").continue({ before = get_args }) end, { desc = "Run with Args" })
vim.keymap.set("n", "<leader>dC", function() require("dap").run_to_cursor() end, { desc = "Run to Cursor" })
vim.keymap.set("n", "<leader>dg", function() require("dap").goto_() end, { desc = "Go to Line (No Execute)" })
vim.keymap.set("n", "<leader>dl", function() require("dap").step_into() end, { desc = "Step Into" })
vim.keymap.set("n", "<leader>dj", function() require("dap").down() end, { desc = "Down" })
vim.keymap.set("n", "<leader>dk", function() require("dap").up() end, { desc = "Up" })
vim.keymap.set("n", "<leader>dl", function() require("dap").run_last() end, { desc = "Run Last" })
vim.keymap.set("n", "<leader>dh", function() require("dap").step_out() end, { desc = "Step Out" })
vim.keymap.set("n", "<leader>dO", function() require("dap").step_over() end, { desc = "Step Over" })
vim.keymap.set("n", "<leader>dP", function() require("dap").pause() end, { desc = "Pause" })
vim.keymap.set("n", "<leader>dr", function() require("dap").repl.toggle() end, { desc = "Toggle REPL" })
vim.keymap.set("n", "<leader>dg", function() vim.cmd(":DapNew") end, { desc = "Start New Session" })
vim.keymap.set("n", "<leader>ds", function() require("dap").session() end, { desc = "Session" })
vim.keymap.set("n", "<leader>dq", function() require("dap").terminate() end, { desc = "Quit Debugging" })
vim.keymap.set("n", "<leader>dw", function() require("dap.ui.widgets").hover() end, { desc = "Widgets" })
