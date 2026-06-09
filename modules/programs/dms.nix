{inputs, ...}: {
  unify.modules.dms = {
    home = {pkgs, ...}: {
      imports = [
        inputs.dms.homeModules.dank-material-shell
        inputs.dms.homeModules.niri
      ];

      programs.dank-material-shell = {
        enable = true;

        systemd = {
          enable = true;
          restartIfChanged = true;
        };

        niri = {
          enableKeybinds = true;
          includes = {
            enable = true;

            override = true;
            originalFileName = "hm";
            filesToInclude = [
              "alttab"
              "binds"
              "colors"
              "layout"
              "outputs"
              "wpblur"
              "blur"
            ];
          };
        };

        enableSystemMonitoring = true;
        enableVPN = true;
        enableDynamicTheming = true;
        enableAudioWavelength = true;
        enableCalendarEvents = true;
      };
    };

    nixos = {pkgs, ...}: {
      systemd.user.services.niri-flake-polkit.enable = false;

      services.displayManager.dms-greeter = {
        enable = true;
        compositor.name = "niri";
        package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;

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
