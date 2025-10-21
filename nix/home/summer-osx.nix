{ ... }:
{
  imports = [
    ./common.nix
    ./vs-code
  ];
  home.homeDirectory = "/Users/witch";
  programs.git.userEmail = "freya.gaynor@meetsummer.com";
  programs.git.signing.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMOponRRd3mlOyzfeEhFovZaWH49JuzoOmeyP9Fnq9p0";
  programs.zsh.shellAliases = {
    upgrade = "sudo darwin-rebuild switch --flake ~/Documents/vcs/dotfiles";
  };
}
