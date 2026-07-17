
{ fff-nvim, configDirectory }:
{ config, wlib, lib, pkgs, ... }:
let

  mkNiche = { owner, repo, branch, rev }: pkgs.vimUtils.buildVimPlugin {
    pname = repo;
    version = rev;
    src = builtins.fetchGit {
      url = "https://github.com/${owner}/${repo}.git";
      ref = branch;
      inherit rev;
    };
    doCheck = false;
  };

  # Same require-check false-positive as above, but for a plugin nixpkgs
  # itself packages: blink-cmp's lua/plugins/blink.lua comments call out an
  # optional cargo build step, the same profile that's hit this twice
  # already (fff.nvim, and avante-nvim before it got dropped - see below).
  # If a build fails on some *other* pkgs.vimPlugins.* entry below with the
  # same "Require check failed" signature, wrap that one too rather than
  # assuming the plugin itself is broken.
  noCheck = pkg: pkg.overrideAttrs (_: { doCheck = false; });

  # .overrideAttrs pname here is the actual fix for the
  # `require("nvim-treesitter.configs")` failure - not the spec-level
  # `name = "..."` in specs.general below. withPlugins keeps the same
  # pname ("nvim-treesitter") as the plain package it wraps, and
  # nix-wrapper-modules apparently dedupes packpath entries by the
  # *package's* pname, not by the spec's name field - so both plain
  # nvim-treesitter and this stayed collapsed into a single packpath
  # entry regardless of what the spec was named, which is also why the
  # built store path's hash never changed across that attempt. Giving the
  # grammar-bundled derivation an actually distinct pname is what makes it
  # a genuinely separate packpath entry.
  treesitterGrammars = (pkgs.unstable.vimPlugins.nvim-treesitter.withPlugins (p: with p; [
    lua odin python rust sql c cpp c_sharp gdscript gdshader bash just nix html css
  ])).overrideAttrs (_: { pname = "nvim-treesitter-grammars"; });
in
{
  imports = [ wlib.wrapperModules.neovim ];

  # Live-editable (no rebuild needed for Lua changes) - see the "Still open"
  # comment above for the in-store alternative.
  config.settings.config_directory = configDirectory;

  config.runtimePkgs = with pkgs; [
    stable.nodejs
    stable.csharp-ls     # lsp/roslyn.lua
    stable.crystal
    stable.shards         # lsp/crystalline.lua build
    stable.cargo
    stable.rustc          
                           
    stable.nerd-fonts._0xproto
    stable.gcc
    unstable.tree-sitter
    ripgrep         

    stable.lua-language-server     # lsp/lua.lua
    stable.nil                     # lsp/nix.lua (also the source of nixpkgs-fmt, nil's own formatter cmd)
    stable.nixpkgs-fmt             # lsp/nix.lua's formatting.command
    stable.vscode-langservers-extracted  # lsp/html.lua + lsp/cssls.lua (vscode-html-language-server, vscode-css-language-server)
    stable.astro-language-server   # lsp/astro.lua (binary: astro-ls)
    stable.just-lsp                # lsp/just.lua
  ];

  config.specs.general = with pkgs.vimPlugins; [
    # --- packaged in nixpkgs  ---
    plenary-nvim
    telescope-nvim               
    nvim-web-devicons
    (noCheck blink-cmp)
    friendly-snippets
    gitsigns-nvim
    inc-rename-nvim
    indent-blankline-nvim
    lualine-nvim
    neoscroll-nvim
    nvim-dap
    nvim-dap-virtual-text
    nvim-scrollbar
    trouble-nvim

    { name = "nvim-treesitter"; data = pkgs.unstable.vimPlugins.nvim-treesitter; }
    { name = "nvim-treesitter-grammars"; data = treesitterGrammars; }

    fff-nvim.packages.${pkgs.stdenv.hostPlatform.system}.fff-nvim

    # --- not (confidently) in nixpkgs - pinned to the exact lazy-lock.json rev ---
    (mkNiche { owner = "Cpoing";         repo = "microscope.nvim";   branch = "main";   rev = "8a6ccffc930a384abfb4572e8af2bf03177b1546"; })
    (mkNiche { owner = "chrisgrieser";   repo = "nvim-origami";      branch = "main";   rev = "02312301df125908031b27dc556adb4cd81893d6"; })
    (mkNiche { owner = "sphamba";        repo = "smear-cursor.nvim"; branch = "main";   rev = "9e9378d6ee34bb3782e0e8c63d9ec8ca618b479b"; })
    (mkNiche { owner = "mikavilpas";     repo = "yazi.nvim";         branch = "main";   rev = "8a26074568790bb5c73e56eb871a74709a13dd43"; })
  ];
}
