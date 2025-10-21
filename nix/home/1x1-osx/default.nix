{ ... }:
{
  imports = [
    ../common
    ../common/vs-code
  ];
  programs.zsh.shellAliases = {
    upgrade = "sudo darwin-rebuild switch --flake ~/vcs/dotfiles";
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
