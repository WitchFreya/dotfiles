{ ... }:
{
  imports = [
    ./common.nix
  ];
  programs.git.extraConfig = {
    core.sshCommand = "ssh.exe";
  };
  programs.zsh.shellAliases = {
    upgrade = "sudo nixos-rebuild switch --flake ~/vcs/dotfiles";
    ssh = "ssh.exe";
  };
}
