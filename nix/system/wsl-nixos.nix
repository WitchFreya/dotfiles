{ pkgs, ... }:
{
  imports = [
    ./configuration.nix
  ];
  wsl.enable = true;
  wsl.defaultUser = "witch";
  programs.nix-ld.enable = true;
  documentation.dev.enable = true;
  users.defaultUserShell = pkgs.zsh;

}
