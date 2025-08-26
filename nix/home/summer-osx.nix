{ ... }:
{
  imports = [
    ./common.nix
    ./vs-code
  ];
  home.homeDirectory = "/Users/witch";
  programs.git.extraConfig.gpg.ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
  programs.zsh.shellAliases = {
    upgrade = "sudo darwin-rebuild switch --flake ~/Documents/vcs/dotfiles";
  };
}
