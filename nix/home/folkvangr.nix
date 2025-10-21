{ ... }: {
  home = {
    username = "witch";
    homeDirectory = "/home/witch";
    stateVersion = "25.11";
  };
  programs.git = {
    enable = true;
    userName = "Freya Gaynor";
    userEmail = "freya@webwitch.org";
  };
  programs.git.extraConfig = {
    core.sshCommand = "ssh.exe";
    user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFPmZTMA6pUYhm8RxKRF6x7QMVGcueMnTrdOn1btnkRd";
    gpg.format = "ssh";
    commit.gpgsign = true;
    "gpg \"ssh\"".program = "/mnt/c/Users/freya/AppData/Local/1Password/app/8/op-ssh-sign-wsl";
  };
}