-- INACTIVE: `enabled = false`. Not required by lua/config/plugins.lua and
-- not in nvim-wrapper/module.nix's specs.
return {
  'Mathijs-Bakker/godotdev.nvim',
  enabled = false,
  dependencies = { 'nvim-lspconfig', 'nvim-dap', 'nvim-dap-ui', 'nvim-treesitter' },
}
