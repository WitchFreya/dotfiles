# iTerm2 loads these as dynamic profiles, so a new machine gets them without a trip through Settings.
{ config, lib, ... }:
let
  resources = "/Applications/iTerm.app/Contents/Resources";
  mainGuid = "8C3AB2E4-74A8-4DF2-9A06-7DDF6DEF34D7";
  hotkeyGuid = "08D46774-B460-4E71-B7CD-01E3D48DA579";

  base =
    lib.importJSON ./iterm2/profile.json
    // config.iterm2.profileSettings
    // {
      "Dynamic Profile Parent Name" = "Default";
    };

  main = base // {
    Name = "Summer";
    Guid = mainGuid;
  };

  hotkey = base // {
    Name = "Summer Hotkey";
    Guid = hotkeyGuid;
    "Has Hotkey" = true;
    "HotKey Key Code" = 50;
    "HotKey Characters" = "`";
    "HotKey Characters Ignoring Modifiers" = "`";
    "HotKey Modifier Flags" = 1048576;
    "HotKey Activated By Modifier" = false;
    "HotKey Modifier Activation" = 0;
    "HotKey Alternate Shortcuts" = [ ];
    "HotKey Window Animates" = true;
    "HotKey Window Floats" = true;
    # Pinned, so a dialog that takes focus (1Password's) doesn't hide it.
    "HotKey Window AutoHides" = false;
    "HotKey Window Dock Click Action" = 0;
    "HotKey Window Reopens On Activation" = false;
    "Window Type" = 2;
    Screen = -2;
    Space = -1;
    # Starts opaque; Cmd+U toggles the transparency.
    "Initial Use Transparency" = false;
    Transparency = 0.3;
    Blur = true;
    "Blur Radius" = 2;
    Blend = 0.5;
    Icon = 0;
    "Keyboard Map" = base."Keyboard Map" // {
      # Cmd+T opens new tabs in this profile rather than the default one.
      "0x74-0x100000" = {
        Version = 2;
        "Apply Mode" = 0;
        Action = 27;
        Text = hotkeyGuid;
        Escaping = 2;
      };
    };
  };
in
{
  options.iterm2.profileSettings = lib.mkOption {
    type = lib.types.attrsOf lib.types.anything;
    default = { };
    description = "Settings other modules add to both dynamic profiles, such as claude-code.nix's.";
  };

  config = {
    home.file."Library/Application Support/iTerm2/DynamicProfiles/summer.json".text = builtins.toJSON {
      Profiles = [
        main
        hotkey
      ];
    };

    # The bundled copy of what iTerm2's shell integration installer downloads; it only runs in interactive iTerm2 shells.
    programs.zsh.initContent = ''
      if [[ -r ${resources}/iterm2_shell_integration.zsh ]]; then
        source ${resources}/iterm2_shell_integration.zsh
      fi
    '';
    home.sessionPath = [ "${resources}/utilities" ];

    targets.darwin.defaults."com.googlecode.iterm2"."Default Bookmark Guid" = mainGuid;
  };
}
