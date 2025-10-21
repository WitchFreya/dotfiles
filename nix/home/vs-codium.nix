{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default.extensions = with pkgs.vscode-marketplace; [
      jnoortheen.nix-ide
    ];
  };
}
