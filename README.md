# dotfiles

- Just nix files at the moment.
- wsl-nixos may need a reboot on initial setup because of changing the default user, see [docs](https://nix-community.github.io/NixOS-WSL/how-to/change-username.html)

## New System Setup - OSx
1. Grant the terminal emulator Full Disk Access.
2. Install using the [Lix Installer](https://lix.systems/).
3. Install [nix-darwin](https://github.com/nix-darwin/nix-darwin)
4. Clone the repo.
5. Set up [flake.nix](./flake.nix) for the new environment if necessary.
6. Run `sudo darwin-rebuild switch --flake [path_to_repo]`