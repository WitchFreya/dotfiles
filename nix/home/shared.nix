{ pkgs, ... }:
{
  home = {
    username = "witch";
    stateVersion = "25.11";
    packages = with pkgs; [
      starship
      zsh
      zoxide
    ];
  };
  programs.git = {
    enable = true;
    userName = "Freya Gaynor";
    userEmail = "freya@webwitch.org";
  };
  programs.git.extraConfig = {
    user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFPmZTMA6pUYhm8RxKRF6x7QMVGcueMnTrdOn1btnkRd";
    gpg.format = "ssh";
    commit.gpgsign = true;
    init.defaultBranch = "main";
    core.editor = "code --wait";
    pull.rebase = true;
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
