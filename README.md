# dotfiles

- Just nix files at the moment.
- wsl-nixos may need a reboot on initial setup because of changing the default user, see [docs](https://nix-community.github.io/NixOS-WSL/how-to/change-username.html)

## New System Setup - OSx
1. Grant the terminal emulator Full Disk Access.
2. Install using the [Lix Installer](https://lix.systems/).
3. Install [nix-darwin](https://github.com/nix-darwin/nix-darwin)
4. Install [homebrew](https://docs.brew.sh/Installation) since it won't be done automatically.
4. Clone the repo.
5. Set up [flake.nix](./flake.nix) for the new environment if necessary.
6. Run `sudo darwin-rebuild switch --flake [path_to_repo]`

### Docker

Docker really doesn't like to behave with homebrew, so if you need stuff with it, install it using the [Mac installer](https://docs.docker.com/desktop/setup/install/mac-install/).

### OPNix

For 1password tokens to be available, you'll need to configure a service account. Follow the [1password developer instructions](https://developer.1password.com/docs/service-accounts/manage-service-accounts) and then run `sudo opnix token set` with the value.