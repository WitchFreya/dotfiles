{ pkgs, ... }:
{
  programs.obsidian = {
    enable = true;
    defaultSettings = {
      corePlugins = [
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

      communityPlugins = with pkgs.obsidianPlugins; [
        obsidian-git
        system3-relay
      ];
    };
    vaults."obsidian" = {
      enable = true;
      target = "vcs/obsidian";
    };
  };
}
