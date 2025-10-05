{ pkgs, ... }:
{
  programs.obsidian = {
    enable = true;
    vaults."obsidian" = {
      enable = true;
      target = "vcs/obsidian";
      settings.communityPlugins = [
        {
          pkg = pkgs.callPackage ./plugins/obsidian-git.nix { };
        }
      ];
    };
  };
}
