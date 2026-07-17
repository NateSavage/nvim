-- INACTIVE: was `enabled = false` under lazy.nvim, so never actually ran.
-- Not required by lua/config/plugins.lua and not in nvim-wrapper/module.nix's
-- specs.
return {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'nvim-dap' },
    enabled = false,
    event = "VeryLazy",
}
