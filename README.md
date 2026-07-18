> I have something here for you. Your father wanted you to have this when you were old enough, but your uncle wouldn't allow it. He feared you might follow on some damn fool idealistic crusade like your father did. It's your father's text editor. This is the weapon of a computer scientist. Not as clumsy or as random as an integrated development environment, but an elegant weapon for a more civilized age.

This is my [neovim](https://neovim.io/) configuration. If you want to try it out, you can just clone it to where neovim stores it's configuration on your OS. <br>
Because I believe Nix is the best package manager, my neovim config does not use include Mason to download language servers that aren't on your system already. If you install the config using Nix, all of the language servers I use will be included. You can also try it out using my [WSL flake](https://github.com/NateSavage/wsl) if you don't have a NixOS machine.

<details><summary>Config Locations</summary>
  <details><summary>Windows</summary>
  Under <code>%AppdataLocal%</code>, like <code>C:\Users\NateS\AppData\Local\nvim</code> and not <code>C:\Users\NateS\AppData\Local\nvim\nvim</code>.
  </details><details>
  <summary>Mac</summary>
   Under <code>~/.config/</code>, like <code>/Users/nates/.config/nvim</code> and not <code>/Users/nates/.config/nvim/nvim</code>.
  </details><details>
  <summary>Linux</summary>
   Under <code>~/.config/</code>, like <code>/home/nates/.config/nvim</code> and not <code>/home/nates/.config/nvim/nvim</code>.
  </details><details>
  <summary>BSD</summary>
   Under <code>~/.config/</code>, like <code>/home/nates/.config/nvim</code> and not <code>/home/nates/.config/nvim/nvim</code>.
  </details>
</details>

## Nix Install

<details><summary>Flake Example</summary>
  
```nix
# flake.nix
{
  description = "My machine";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nates-nvim = {
      url = "github:NateSavage/nvim";
      # optional but recommended: prevents the nvim flake from pulling its own separate nixpkgs copy
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-unstable.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nates-nvim, ... }: {
    nixosConfigurations.my-machine = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        nates-nvim.nixosModules
        {
          programs.nates-nvim = {
            enable = true;
            user = "YOUR_USERNAME";
          };
        }
        ./configuration.nix
      ];
    };
  };
}
```
</details>

---

### Hotkeys
*How the hell do I even use a text editor without a mouse, let alone one with customized hotkeys?*

#### Legend
**blue**: default neovim binding <br>
**green**: binding custom to nates configuration <br>
**orange**: key held or pressed first
