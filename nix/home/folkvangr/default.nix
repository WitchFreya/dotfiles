{ pkgs, ... }:
{
  imports = [
    ../common
  ];
  programs.git.settings.core.sshCommand = "ssh.exe";
  programs.zsh.shellAliases = {
    upgrade = "sudo nixos-rebuild switch --flake ~/vcs/dotfiles";
    ssh = "ssh.exe";
  };
  home.packages = [ pkgs.dconf ];
}
