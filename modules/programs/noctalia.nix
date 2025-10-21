{inputs, ...}: {
  unify.modules.bar = {
    home = {
      pkgs,
      config,
      lib,
      ...
    }: {
      imports = [inputs.noctalia.homeModules.default];

      programs.noctalia-shell = {
        enable = true;
        settings = {
          appLauncher = {
            enableClipboardHistory = true;
            position = "bottom_center";
            sortByMostUsed = true;
            terminalCommand = "ghostty -e";
          };

          audio = {
            visualizerType = "none";
            volumeOverdrive = true;
            volumeStep = 5;
          };

          bar = {
            density = "comfortable";
            position = "left";
            showCapsule = true;
            widgets = {
              center = [
                {
                  hideUnoccupied = false;
                  id = "Workspace";
                  labelMode = "index";
                }
              ];
              left = [
                {
                  id = "SystemMonitor";
                  showCpuTemp = true;
                  showCpuUsage = true;
                  showDiskUsage = false;
                  showMemoryAsPercent = false;
                  showMemoryUsage = true;
                  showNetworkStats = false;
                }
                {
                  autoHide = false;
                  id = "ActiveWindow";
                  scrollingMode = "hover";
                  showIcon = true;
                  width = 145;
                }
                {
                  autoHide = false;
                  id = "MediaMini";
                  scrollingMode = "hover";
                  showAlbumArt = true;
                  showVisualizer = true;
                  visualizerType = "mirrored";
                }
              ];
              right = [
                {id = "Tray";}
                {id = "WiFi";}
                {id = "Bluetooth";}
                {
                  displayMode = "onhover";
                  id = "Battery";
                  warningThreshold = 30;
                }
                {
                  displayMode = "onhover";
                  id = "Volume";
                }
                {
                  displayMode = "onhover";
                  id = "Brightness";
                }
                {
                  customFont = "";
                  formatHorizontal = "hh:mm ddd, MMM dd";
                  formatVertical = "hh mm AP - dd MM";
                  id = "Clock";
                  useCustomFont = false;
                  usePrimaryColor = true;
                }
                {id = "ScreenRecorder";}
                {
                  customIconPath = "";
                  icon = "noctalia";
                  id = "ControlCenter";
                  useDistroLogo = true;
                }
              ];
            };
          };

          brightness = {
            brightnessStep = 5;
          };

          colorSchemes = {
            darkMode = true;
            generateTemplatesForPredefined = true;
            matugenSchemeType = "scheme-fruit-salad";
            predefinedScheme = "Noctalia (default)";
            useWallpaperColors = true;
          };

          general = {
            avatarImage = "/home/oxce5/.face";
          };

          location = {
            name = "Manila";
            use12hourFormat = true;
            useFahrenheit = false;
          };

          osd = {
            autoHideMs = 2000;
            enabled = true;
            location = "bottom";
            monitors = [];
          };

          wallpaper = {
            defaultWallpaper = "";
            directory = "/home/oxce5/Pictures/Wallpaper";
            enabled = true;
            monitors = [
              {
                directory = "/home/oxce5/Pictures/Wallpaper";
                name = "eDP-1";
                wallpaper = "/home/oxce5/Pictures/Wallpaper/teto_unedited.png";
              }
            ];
          };
        };
      };
    };
    nixos = {pkgs, ...}: {
      imports = [inputs.noctalia.nixosModules.default];
      services.noctalia-shell.enable = true;
    };
  };
}
