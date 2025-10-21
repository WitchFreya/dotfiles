{
  config,
  pkgs,
  ...
}:
{
  config.programs.git =
    let
      email = config.programs.git.userEmail;
      key = config.programs.git.signing.key;
      signersFile = pkgs.writeText "git-allowed-signers" ''
        ${email} namespaces="git" ${key}
      '';
      onePassSshPath =
        if pkgs.stdenv.isDarwin then
          "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
        else
          "/mnt/c/Users/freya/AppData/Local/1Password/app/8/op-ssh-sign-wsl";
    in
    {
      enable = true;
      userName = "Freya Gaynor";
      signing.signByDefault = true;
      signing.format = "ssh";
      ignores = [
        ".env.op-template"
      ];

      extraConfig =
        let
          editor = if config.programs.vscode.package == pkgs.vscodium then "codium" else "code";
        in
        {
          init.defaultBranch = "main";
          core.editor = "${editor} --wait";
          pull.rebase = true;
          gpg.ssh.allowedSignersFile = builtins.toString signersFile;
          gpg.ssh.program = onePassSshPath;
        };
    };
}
