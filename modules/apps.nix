{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    bat
    git
    gh
    nixd
    nixfmt-rfc-style
  ];
}
