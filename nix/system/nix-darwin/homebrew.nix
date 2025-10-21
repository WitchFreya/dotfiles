{ ... }:
{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    casks = [
      "firefox"
      "bettertouchtool"
      "1password"
      "todoist-app"
    ];
  };
}
