{inputs, ...}: {
  unify.modules.bar = {
    home = {hostConfig, ...}: {
      imports = [inputs.noctalia.homeModules.default];

      programs.ghostty.settings.theme = "noctalia";

      programs.noctalia-shell = {
        enable = true;
        settings = {
          appLauncher = {
            enableClipboardHistory = true;
            position = "bottom_center";
            terminalCommand = "ghostty -e";
          };

          audio = {
            cavaFrameRate = 60;
            visualizerType = "none";
            volumeOverdrive = true;
          };

          bar = {
            density = "comfortable";
            outerCorners = false;
            position = "left";

            widgets = {
              left = [
                {
                  id = "SystemMonitor";
                  showCpuTemp = true;
                  showCpuUsage = true;
                  showDiskUsage = false;
                  showMemoryAsPercent = false;
                  showMemoryUsage = true;
                  showNetworkStats = false;
                  usePrimaryColor = false;
                }
                {
                  id = "ActiveWindow";
                  colorizeIcons = false;
                  hideMode = "hidden";
                  maxWidth = 145;
                  scrollingMode = "hover";
                  showIcon = true;
                  useFixedWidth = false;
                }
                {
                  id = "MediaMini";
                  hideMode = "hidden";
                  hideWhenIdle = false;
                  maxWidth = 145;
                  scrollingMode = "hover";
                  showAlbumArt = true;
                  showVisualizer = true;
                  useFixedWidth = false;
                  visualizerType = "mirrored";
                }
                {
                  id = "Spacer";
                  width = 20;
                }
                {
                  id = "Workspace";
                  characterCount = 2;
                  hideUnoccupied = false;
                  labelMode = "index";
                }
              ];

              center = [];

              right = [
                {
                  id = "Tray";
                  blacklist = [];
                  pinned = [];
                  drawerEnabled = true;
                  colorizeIcons = false;
                }
                {
                  id = "WiFi";
                  displayMode = "onhover";
                }
                {
                  id = "Bluetooth";
                  displayMode = "onhover";
                }
                {
                  id = "Battery";
                  displayMode = "onhover";
                  warningThreshold = 30;
                }
                {
                  id = "Volume";
                  displayMode = "onhover";
                }
                {
                  id = "Brightness";
                  displayMode = "onhover";
                }
                {
                  id = "Clock";
                  customFont = "";
                  formatHorizontal = "hh:mm ddd, MMM dd";
                  formatVertical = "hh mm AP - dd MM";
                  useCustomFont = false;
                  usePrimaryColor = true;
                }
                {id = "ScreenRecorder";}
                {
                  id = "ControlCenter";
                  icon = "noctalia";
                  customIconPath = "";
                  colorizeDistroLogo = false;
                  useDistroLogo = true;
                }
              ];
            };
          };

          general = {
            avatarImage = "/home/oxce5/.face";
          };

          location = {
            name = "Davao";
            use12hourFormat = true;
          };

          wallpaper = {
            directory = "/home/oxce5/Pictures/Wallpaper";
            overviewEnabled = true;

            monitors = [
              {
                name = "eDP-1";
                directory = "/home/oxce5/Pictures/Wallpaper";
                wallpaper = "${hostConfig.primaryWallpaper}";
              }
            ];
          };

          dock = {
            enabled = false;
          };

          colorSchemes = {
            useWallpaperColors = true;
            matugenSchemeType = "scheme-fidelity";
          };

          templates = {
            discord = true;
            enableUserTemplates = true;
            ghostty = true;
          };

          osd = {
            location = "bottom";
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
