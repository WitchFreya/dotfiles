# Root configuration for all systems.
{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.11";
  nix.settings.experimental-features = "nix-command flakes";
  environment.systemPackages = with pkgs; [
    wget
    vim
    git
    gh
    bat
    man-pages
    man-pages-posix
    home-manager
    nixfmt-rfc-style
    nixd
  ];
  environment.pathsToLink = [ "/share/zsh" ];
}
