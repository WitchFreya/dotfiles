{ self, ... }:
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

  # see https://github.com/zhaofengli/nix-homebrew
  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    # TODO: make this pull from some parameter.
    user = "witch";
    taps = {
      "homebrew/homebrew-core" = self.inputs.homebrew-core;
      "homebrew/homebrew-cask" = self.inputs.homebrew-cask;
    };
    mutableTaps = false;
    autoMigrate = true;
  };
}
