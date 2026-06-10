{ ... }:
{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
      extraFlags = [ "--force-cleanup" ];
    };
    casks = [
      "firefox"
      "bettertouchtool"
      "1password"
      "todoist-app"
      "keymapp"
    ];
  };
}
