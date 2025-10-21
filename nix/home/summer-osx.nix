{ ... }:
{
  imports = [
    ./common.nix
    ./vs-code
  ];
  programs.git.userEmail = "freya.gaynor@meetsummer.com";
  programs.git.signing.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMOponRRd3mlOyzfeEhFovZaWH49JuzoOmeyP9Fnq9p0";
  programs.zsh.shellAliases = {
    upgrade = "sudo darwin-rebuild switch --flake ~/Documents/vcs/dotfiles";
  };
  programs.ssh =
    let
      onePassPath = "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
      IdentityAgent = ''IdentityAgent "${onePassPath}"'';
    in
    {
      enable = true;
      extraConfig = IdentityAgent;
    };
}
