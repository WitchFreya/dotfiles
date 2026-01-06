{
  config,
  pkgs,
  ...
}:
{
  config.programs.git = {
    enable = true;
    signing.signByDefault = true;
    signing.format = "ssh";
    ignores = [
      ".env.op-template"
    ];

    settings =
      let
        email = config.programs.git.settings.user.email;
        key = config.programs.git.signing.key;
        signersFile = pkgs.writeText "git-allowed-signers" ''
          ${email} namespaces="git" ${key}
        '';
        onePassSshPath =
          if pkgs.stdenv.isDarwin then
            "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
          else
            "/mnt/c/Users/freya/AppData/Local/Microsoft/WindowsApps/op-ssh-sign-wsl.exe";
        editor = if config.programs.vscode.package == pkgs.vscodium then "codium" else "code";
      in
      {
        user.name = "Freya Gaynor";
        init.defaultBranch = "main";
        core.editor = "${editor} --wait";
        pull.rebase = true;
        gpg.ssh.allowedSignersFile = toString signersFile;
        gpg.ssh.program = onePassSshPath;
      };
  };
}
