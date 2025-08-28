{ self, pkgs, ... }:
{
  imports = [
    self.inputs._1password-shell-plugins.hmModules.default
    ./aws-cli.nix
    ../common
    ../common/vs-code
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
  programs._1password-shell-plugins = {
    enable = true;
    plugins = with pkgs; [
      gh
    ];
  };
}
