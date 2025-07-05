{ pkgs, ... }:
{
  imports = [
    ./git.nix
  ];
  home = {
    username = "witch";
    stateVersion = "25.11";
    packages = with pkgs; [
      starship
      zsh
      zoxide
    ];
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };
  };
  programs.starship.enable = true;
  programs.zoxide.enable = true;
}
