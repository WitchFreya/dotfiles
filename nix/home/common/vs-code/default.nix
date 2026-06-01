{ pkgs, lib, ... }:
{
  home.sessionVariables.EDITOR = "codium";
  programs.vscodium = {
    enable = true;
    package = pkgs.vscodium;
    mutableExtensionsDir = false;
    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      userSettings = builtins.fromJSON (builtins.readFile ./user-settings.json);
      extensions =
        let
          unfreeExtensions = [
            "threadheap.serverless-ide-vscode"
          ];
          freeExtensions = [
            # visuals
            "pkief.material-icon-theme"

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

            # language support
            "tamasfe.even-better-toml"
            "yoavbls.pretty-ts-errors"
            "unifiedjs.vscode-mdx"
            "jnoortheen.nix-ide"
            "yzhang.markdown-all-in-one"
            "meganrogge.template-string-converter"
            "bradlc.vscode-tailwindcss"
            "effectful-tech.effect-vscode"
          ];
        in
        pkgs.nix4vscode.forVscode unfreeExtensions ++ pkgs.nix4vscode.forOpenVsx freeExtensions;
    };
  };

  # some ephemeral settings change while working in VS Code; this allows them to modify in place and be rewritten when upgrading
  home.activation.makeVSCodeSettingsMutable = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    settings="$HOME/Library/Application Support/VSCodium/User/settings.json"
    if [ -L "$settings" ]; then
      cp --remove-destination "$(readlink "$settings")" "$settings"
      chmod u+w "$settings"
    fi
  '';
}
