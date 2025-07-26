# Root configuration for all systems.
{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
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
    direnv
  ];
  fonts.packages = with pkgs; [ nerd-fonts.fira-code ];
  environment.pathsToLink = [ "/share/zsh" ];
  programs.zsh.enable = true;
  time.timeZone = "America/Los_Angeles";
}
