{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      userSettings = builtins.fromJSON (builtins.readFile ./vs-codium.settings.json);
      extensions = with pkgs.vscode-marketplace // pkgs.open-vsx; [
        # visuals
        pkief.material-icon-theme
        akamud.vscode-theme-onedark

        # basic features
        mkhl.direnv
        streetsidesoftware.code-spell-checker
        wmaurer.change-case
        firefox-devtools.vscode-firefox-debug
        fill-labs.dependi
        editorconfig.editorconfig
        esbenp.prettier-vscode
        gruntfuggly.todo-tree
        eamodio.gitlens
        github.vscode-pull-request-github
        tyriar.sort-lines

        # language support
        tamasfe.even-better-toml
        dbaeumer.vscode-eslint
        yoavbls.pretty-ts-errors
        unifiedjs.vscode-mdx
        jnoortheen.nix-ide
      ];
    };
  };
}
