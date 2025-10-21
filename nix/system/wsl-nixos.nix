{ pkgs, ... }:
{
  imports = [
    ./configuration.nix
  ];
  system.stateVersion = "24.11";
  wsl.enable = true;
  wsl.defaultUser = "witch";
  programs.nix-ld.enable = true;
  documentation.dev.enable = true;
  users.defaultUserShell = pkgs.zsh;
}
