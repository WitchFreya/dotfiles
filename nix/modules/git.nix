{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.git.publicKey = lib.mkOption {
    type = lib.types.string;
    description = "The primary SSH public key to be used for signing commits.";
  };
  options.git.email = lib.mkOption {
    type = lib.types.string;
    description = "The email used for the global git configuration.";
  };

  config.programs.git =
    let
      email = config.git.email;
      key = config.git.publicKey;
      signersFile = pkgs.writeText "git-allowed-signers" ''
        ${email} namespaces="git" ${key}
      '';
    in
    {
      enable = true;
      userName = "Freya Gaynor";
      userEmail = email;
      signing.key = key;
      signing.signByDefault = true;
      signing.format = "ssh";

      extraConfig = {
        init.defaultBranch = "main";
        core.editor = "code --wait";
        pull.rebase = true;
        gpg.ssh.allowedSignersFile = builtins.toString signersFile;
      };
    };
}
