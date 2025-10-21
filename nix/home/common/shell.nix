{
  self,
  pkgs,
  config,
  ...
}:
{
  imports = [
    self.inputs.opnix.homeManagerModules.default
    self.inputs._1password-shell-plugins.hmModules.default
  ];

  home.packages = with pkgs; [
    starship
    zsh
    zoxide
  ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    sessionVariables = config.home.sessionVariables;
    shellAliases = {
      cat = "bat";
    };
  };
  programs.zsh.oh-my-zsh = {
    enable = true;
    plugins = [ "git" ];
  };
  programs.starship.enable = true;
  programs.zoxide.enable = true;
  programs._1password-shell-plugins.enable = true;
  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };
}
