{inputs, ...}: {
  unify.modules.dms = {
    home = {pkgs, ...}: {
      imports = [
        inputs.dms.homeModules.dank-material-shell
        inputs.dms.homeModules.niri
      ];

      programs.dankMaterialShell = {
        enable = true;

        systemd = {
          enable = true;
          restartIfChanged = true;
        };

        enableSystemMonitoring = true;
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
        compositor.name = "niri";

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
