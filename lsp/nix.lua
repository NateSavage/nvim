---@type vim.lsp.Config
return {
  cmd = { 'nil', '--stdio' },
  filetypes = { 'nix' },
  root_markers = { 'flake.nix', 'default.nix', '.git' },
  settings = {
    ['nil'] = {
      formatting = {
        command = { 'nixpkgs-fmt' },
      },
    },
  },
}
