{ pkgs, ... }:
let
  key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFPmZTMA6pUYhm8RxKRF6x7QMVGcueMnTrdOn1btnkRd";
  email = "freya@webwitch.org";
  signersFile = pkgs.writeText "git-allowed-signers" ''
    ${email} namespaces="git" ${key}
  '';
in
{
  programs.git = {
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
