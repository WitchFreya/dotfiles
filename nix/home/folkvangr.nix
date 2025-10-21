{ ... }:
{
  home.homeDirectory = "/home/witch";
  programs.git.extraConfig = {
    core.sshCommand = "ssh.exe";
    gpg.ssh.program = "/mnt/c/Users/freya/AppData/Local/1Password/app/8/op-ssh-sign-wsl";
  };
  programs.zsh.shellAliases = {
    upgrade = "sudo nixos-rebuild switch --flake ~/vcs/nix-config";
    update = "home-manager switch --flake ~/vcs/nix-config";
  };
}
