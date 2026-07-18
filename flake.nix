{
  description = "Nate's neovim config.";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    # Builds pkgs.nvimWrapped - see nix/module.nix (replaces the old lazy.nvim + wrapNeovimUnstable setup).
    nvim-wrappers.url = "github:BirdeeHub/nix-wrapper-modules";
    nvim-wrappers.inputs.nixpkgs.follows = "nixpkgs-unstable";

    # fff.nvim's Rust FFI component needs its own flake (crane/rust-overlay/ zig) to build - see nix/module.nix.
    # Pinned to the same commit lazy-lock.json had.
    fff-nvim.url = "github:dmtrKovalenko/fff.nvim/1104a8deaf551fdb17fecadc87d6872397c98a6a";
  };

  outputs = { nixpkgs, nixpkgs-unstable, nvim-wrappers, fff-nvim, ... }: let

    stableOverlay = final: prev: { # use lib.wrap for manual/advanced use.
      stable = import nixpkgs {
        system = prev.stdenv.hostPlatform.system;
        config.allowUnfree = true;
      };
    };
    unstableOverlay = final: prev: {
      unstable = import nixpkgs-unstable {
        system = prev.stdenv.hostPlatform.system;
        config.allowUnfree = true;
      };
    };

    wrap = { pkgs, configDirectory ? "/home/nates/.config/nvim" }:
      (nvim-wrappers.lib.evalModule (import ./nix/module.nix {
        inherit fff-nvim configDirectory;
      })).config.wrap { inherit pkgs; };

    nvimNixosModule = { config, lib, pkgs, ... }: let
      cfg = config.programs.nates-nvim;
      homeDir = "/home/${cfg.user}";
    in {
      options.programs.nates-nvim = {
        enable = lib.mkEnableOption "Nate's neovim setup (Nix-built plugins/tooling, config live-cloned from this repo)";

        user = lib.mkOption {
          type = lib.types.str;
          description = "User to install neovim for - this repo gets cloned to that user's $HOME/.config/nvim.";
        };

        configRepo = lib.mkOption {
          type = lib.types.str;
          default = "https://github.com/NateSavage/nvim.git";
          description = "Repo URL to clone into ~/.config/nvim if it isn't already a checkout there.";
        };
      };

      config = lib.mkIf cfg.enable {
        nixpkgs.overlays = [
          stableOverlay
          unstableOverlay
          (final: prev: {
            nvimWrapped = wrap {
              pkgs = final;
              configDirectory = "${homeDir}/.config/nvim";
            };
          })
        ];

        users.users.${cfg.user}.packages = [ pkgs.nvimWrapped ];

        # Only clones if missing, so this never touches (or fights with) an
        # existing checkout's local edits/commits.
        system.activationScripts."nvim-config-${cfg.user}" = {
          text = ''
            if [ ! -e ${homeDir}/.config/nvim/.git ]; then
              ${pkgs.git}/bin/git clone ${cfg.configRepo} ${homeDir}/.config/nvim
              chown -R ${cfg.user} ${homeDir}/.config/nvim
            fi
          '';
          deps = [ "users" ];
        };
      };
    };
  in {
    lib.wrap = wrap;

    # Both point at the same module - `nixosModule` (singular, no `.default`)
    # is just the shorter name to type in a consumer's `imports`.
    nixosModules.default = nvimNixosModule;
    nixosModule = nvimNixosModule;

    # `nix build .#default` to test the wrapped package standalone.
    packages.x86_64-linux.default = wrap {
      pkgs = import nixpkgs-unstable {
        system = "x86_64-linux";
        config.allowUnfree = true;
        overlays = [ stableOverlay unstableOverlay ];
      };
    };
  };
}
