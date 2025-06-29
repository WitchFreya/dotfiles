# Root configuration for all systems.
{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.11";
  environment.systemPackages = with pkgs; [
    wget
    vim
    git
    man-pages
    man-pages-posix
    home-manager
  ];
  nix.settings.experimental-features = "nix-command flakes";
}
