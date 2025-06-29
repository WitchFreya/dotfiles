{ ... }:
{
  home = {
    homeDirectory = "/Users/witch";
  };
  programs.git.extraConfig = {
    "gpg \"ssh\"".program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
  };
}
