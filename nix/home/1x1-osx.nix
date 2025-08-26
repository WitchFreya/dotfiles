{ ... }:
{
  imports = [
    ./common.nix
    ./vs-code
  ];
  home.homeDirectory = "/Users/witch";
  programs.zsh.shellAliases = {
    upgrade = "sudo darwin-rebuild switch --flake ~/vcs/dotfiles";
  };
}
