{inputs, ...}: {
  unify.modules.dms = {
    home = {pkgs, ...}: {
      imports = [
        inputs.dms.homeModules.dankMaterialShell.default
        inputs.dms.homeModules.dankMaterialShell.niri
      ];

      programs.dankMaterialShell = {
        enable = true;

        systemd = {
          enable = true;
          restartIfChanged = true;
        };

        enableSystemMonitoring = true;
        enableClipboard = true;
        enableVPN = true;
        enableDynamicTheming = true;
        enableAudioWavelength = true;
        enableCalendarEvents = true;
      };
    };

    nixos = {
      systemd.user.services.niri-flake-polkit.enable = false;

      services.displayManager.dms-greeter = {
        enable = true;
        compositor.name = "niri"; # Or "hyprland" or "sway"

        # Sync your user's DankMaterialShell theme with the greeter. You'll probably want this
        configHome = "/home/oxce5";

        # Save the logs to a file
        logs = {
          save = true;
          path = "/tmp/dms-greeter.log";
        };
      };
    };
  };
}
