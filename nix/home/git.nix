{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Freya Gaynor";
    userEmail = "freya@webwitch.org";
    signing.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFPmZTMA6pUYhm8RxKRF6x7QMVGcueMnTrdOn1btnkRd";
    signing.signByDefault = true;
    signing.format = "ssh";

    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "code --wait";
      pull.rebase = true;
    };
  };
}
