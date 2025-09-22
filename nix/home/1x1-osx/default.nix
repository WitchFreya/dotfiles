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
      folkvangrWslIP = "172.22.190.38";
    in
    {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks."*".identityAgent =
        ''"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"'';
      matchBlocks."${folkvangrWslIP}".proxyCommand = "ssh -q -W %h:%p freya@Folkvangr.local";
    };
}
