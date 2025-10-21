{ config, ... }:
{
  imports = [
    ./aws-cli.nix
    ../common
    ../common/vs-code
  ];
  programs.git.settings.user.email = "freya.gaynor@meetsummer.com";
  programs.git.signing.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMOponRRd3mlOyzfeEhFovZaWH49JuzoOmeyP9Fnq9p0";
  programs.zsh.shellAliases = {
    upgrade = "sudo darwin-rebuild switch --flake ~/Documents/vcs/dotfiles";
  };
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*".identityAgent =
      ''"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"'';
  };
  home.sessionVariables = {
    GITHUB_TOKEN = "$(cat ${config.home.homeDirectory}/.config/github.pat)";
  };

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
  };
}
