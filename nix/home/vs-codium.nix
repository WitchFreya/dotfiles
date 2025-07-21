{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      userSettings = builtins.fromJSON (builtins.readFile ../../.vscode/settings.json);
      extensions =
        pkgs.nix4vscode.forVscode [
          # visuals
          "akamud.vscode-theme-onedark"
          "pkief.material-icon-theme"

          # basic features
          "mkhl.direnv"
          "streetsidesoftware.code-spell-checker"
          "wmaurer.change-case"
          "firefox-devtools.vscode-firefox-debug"
          "fill-labs.dependi"
          "editorconfig.editorconfig"
          "esbenp.prettier-vscode"
          "ue.alphabetical-sorter"
          "gruntfuggly.todo-tree"
          "eamodio.gitlens"

          # language-specific
          "tamasfe.even-better-toml"
          "dbaeumer.vscode-eslint"
          "yoavbls.pretty-ts-errors"
        ]
        ++ pkgs.nix4vscode.forOpenVsx [
          "jnoortheen.nix-ide"
        ];
    };
  };
}
