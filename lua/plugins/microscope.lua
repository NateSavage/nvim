return {
  "Cpoing/microscope.nvim",
  config = function()
    require("microscope").setup({
      keymaps = {
        preview_definition = "<S-k>",
      },
    })
  end,
}
