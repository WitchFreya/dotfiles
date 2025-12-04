{ pkgs, ... }:
{
  programs.obsidian = {
    enable = true;
    vaults."obsidian" = {
      enable = true;
      target = "vcs/obsidian";
      settings.corePlugins = [
        "backlink"
        "bookmarks"
        "canvas"
        "command-palette"
        "daily-notes"
        "editor-status"
        "file-explorer"
        "file-recovery"
        "global-search"
        "graph"
        "note-composer"
        "outgoing-link"
        "outline"
        "page-preview"
        "switcher"
        "tag-pane"
        "templates"
        "word-count"
        "workspaces"
      ];
      settings.communityPlugins = [
        { pkg = pkgs.callPackage ./plugins/obsidian-git.nix { }; }
        { pkg = pkgs.callPackage ./plugins/relay.nix { }; }
      ];
    };
  };
}
