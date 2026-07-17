> I have something here for you. Your father wanted you to have this when you were old enough, but your uncle wouldn't allow it. He feared you might follow on some damn fool idealistic crusade like your father did. It's your father's text editor. This is the weapon of a computer scientist. Not as clumsy or as random as an integrated development environment, but an elegant weapon for a more civilized age.

This is Nate's [neovim](https://neovim.io/) configuration. If you want to try it out, you can just clone it to where neovim stores it's configuration on your OS. <br>
But my reccomendation would be to either install it in your NixOS flake, or try it out using my [WSL flake](https://github.com/NateSavage/wsl).

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

This flake is meant to be dropped into any NixOS machine flake — it's fully self-contained, no manual overlay/package
wiring needed:

```nix
inputs.nvim-config.url = "github:NateSavage/nvim";

# ...then, wherever your system config lives:
imports = [ inputs.nvim-config.nixosModules.default ];
programs.nates-nvim.enable = true;
programs.nates-nvim.user = "your-username";
```

`nix build .#default` tests the wrapped package standalone, without any of
the above.

---

### Hotkeys
*How the hell do I even use a text editor without a mouse, let alone one with customized hotkeys?*

#### Legend
**blue**: default neovim binding <br>
**green**: binding custom to nates configuration <br>
**orange**: key held or pressed first
