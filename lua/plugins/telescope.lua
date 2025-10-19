return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim', 'BurntSushi/ripgrep' },
    config = function()
        local telescope = require('telescope')
        local actions = require('telescope.actions')

        telescope.setup({
            defaults = {
                path_display = {"filename_first"},
                mappings = {
                    i = {
                        -- alt+j select next
                        ["<A-j>"] = {
                            actions.move_selection_next, type = "action",
                            opts = { nowait = true, silent = true }
                        },
                        -- alt+k select previous
                        ["<A-k>"]  = {
                            actions.move_selection_previous, type = "action",
                            opts = { nowait = true, silent = true }
                        },
                    }
                },
                file_ignore_patterns = {
                   "build/*",         -- Exclude build folder
                   "%.dll",    -- binary
                   -- unity game engine
                   "%.meta",
                   "%.anim",
                   "%.asset",
                   "%.mat",
                   "%.terrainlayer",
                   "%.unity",
                   -- godot game engine
                   "%.uid",
                   "%.res",  -- binary scene format
                   -- images
                   "%.afphoto", -- binary
                   "%.psd", -- sometimes binary? x_x
                   "%.jpg",
                   "%.png",
                   "%.tga",
                   "%.exr",
                   -- audio
                   "%.wav",
                    -- 3d files
                   "%.obj",   -- 
                   "%.fbx",   -- autodesk proprietary 3d interchange format
                   "%.FBX",   -- autodesk proprietary 3d interchange format
                   "%.glb",   -- OpenGL binary transmission format
                   "%.gltf",  -- OpenGL text format
                   "%.blend", -- are blend files binary?
                   "%.mb",    -- maya binary
                   "%.ma",    -- maya ascii
                   -- fonts
                   "%.ttf",
               },
            },
        })

        local builtin = require('telescope.builtin')
	    vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
        vim.keymap.set("n", "<leader>fg", builtin.git_files, {})
	    vim.keymap.set("n", "<leader>fw", builtin.live_grep, {}) -- requires ripgrep in path as rg
    end
}
