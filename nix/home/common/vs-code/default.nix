{ pkgs, ... }:
{
  home.sessionVariables.EDITOR = "codium";
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    mutableExtensionsDir = false;
    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      userSettings = builtins.fromJSON (builtins.readFile ./user-settings.json);
      extensions =
        let
          unfreeExtensions = [ ];
          freeExtensions = [
            # visuals
            "pkief.material-icon-theme"
            "akamud.vscode-theme-onedark"

            # basic features
            "mkhl.direnv"
            "streetsidesoftware.code-spell-checker"
            "gruntfuggly.todo-tree"
            "firefox-devtools.vscode-firefox-debug"
            "usernamehw.errorlens"

            # text editing
            "wmaurer.change-case"
            "britesnow.vscode-toggle-quotes"
            "tyriar.sort-lines"

            # styling and formatting
            "editorconfig.editorconfig"
            "esbenp.prettier-vscode"
            "dbaeumer.vscode-eslint"

            # version control
            "fill-labs.dependi"
            "eamodio.gitlens"
            "github.vscode-pull-request-github"

            # language support
            "tamasfe.even-better-toml"
            "yoavbls.pretty-ts-errors"
            "unifiedjs.vscode-mdx"
            "jnoortheen.nix-ide"
            "yzhang.markdown-all-in-one"
          ];
        in
        pkgs.nix4vscode.forVscode unfreeExtensions ++ pkgs.nix4vscode.forOpenVsx freeExtensions;
    };
  };
}
