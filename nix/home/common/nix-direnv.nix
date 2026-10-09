{ ... }:
{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
    # patch until #790 (https://github.com/nix-community/nix-direnv/pull/790) is released
    stdlib = "_nix_refresh_gcroots() { :; }";
  };
}
