{ pkgs, ... }:
{
  home.packages = with pkgs; [
    starship
    zsh
    zoxide
  ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      cat = "bat";
    };
  };
  programs.zsh.oh-my-zsh = {
    enable = true;
    plugins = [ "git" ];
  };
  programs.starship.enable = true;
  programs.zoxide.enable = true;
}
