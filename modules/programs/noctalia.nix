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
            backgroundOpacity = 1;
            customLaunchPrefix = "";
            customLaunchPrefixEnabled = false;
            enableClipboardHistory = true;
            pinnedExecs = [];
            position = "bottom_center";
            sortByMostUsed = true;
            terminalCommand = "ghostty -e";
            useApp2Unit = false;
          };

          audio = {
            cavaFrameRate = 60;
            mprisBlacklist = [];
            preferredPlayer = "";
            visualizerType = "none";
            volumeOverdrive = true;
            volumeStep = 5;
          };

          bar = {
            backgroundOpacity = 1;
            density = "comfortable";
            floating = false;
            marginHorizontal = 0.25;
            marginVertical = 0.25;
            monitors = [];
            position = "left";
            showCapsule = true;
            widgets = {
              center = [
                {
                  characterCount = 2;
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
                  colorizeIcons = false;
                  hideMode = "hidden";
                  id = "ActiveWindow";
                  maxWidth = 145;
                  scrollingMode = "hover";
                  showIcon = true;
                  useFixedWidth = false;
                }
                {
                  hideMode = "hidden";
                  id = "MediaMini";
                  maxWidth = 145;
                  scrollingMode = "hover";
                  showAlbumArt = true;
                  showVisualizer = true;
                  useFixedWidth = false;
                  visualizerType = "mirrored";
                }
              ];
              right = [
                {
                  blacklist = [];
                  colorizeIcons = false;
                  id = "Tray";
                }
                {
                  displayMode = "onhover";
                  id = "WiFi";
                }
                {
                  displayMode = "onhover";
                  id = "Bluetooth";
                }
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

          battery = {chargingMode = 0;};

          brightness = {
            brightnessStep = 5;
            enforceMinimum = true;
          };

          colorSchemes = {
            darkMode = true;
            generateTemplatesForPredefined = true;
            manualSunrise = "06:30";
            manualSunset = "18:30";
            matugenSchemeType = "scheme-fruit-salad";
            predefinedScheme = "Noctalia (default)";
            schedulingMode = "off";
            useWallpaperColors = true;
          };

          controlCenter = {
            cards = [
              {
                enabled = true;
                id = "profile-card";
              }
              {
                enabled = true;
                id = "shortcuts-card";
              }
              {
                enabled = true;
                id = "audio-card";
              }
              {
                enabled = true;
                id = "weather-card";
              }
              {
                enabled = true;
                id = "media-sysmon-card";
              }
            ];
            position = "close_to_bar_button";
            shortcuts = {
              left = [
                {id = "WiFi";}
                {id = "Bluetooth";}
                {id = "ScreenRecorder";}
                {id = "WallpaperSelector";}
              ];
              right = [
                {id = "Notifications";}
                {id = "PowerProfile";}
                {id = "KeepAwake";}
                {id = "NightLight";}
              ];
            };
          };

          dock = {
            backgroundOpacity = 1;
            colorizeIcons = false;
            displayMode = "always_visible";
            enabled = false;
            floatingRatio = 1;
            monitors = [];
            onlySameOutput = true;
            pinnedApps = [];
            size = 1;
          };

          general = {
            animationDisabled = false;
            animationSpeed = 1;
            avatarImage = "/home/oxce5/.face";
            compactLockScreen = false;
            dimDesktop = true;
            forceBlackScreenCorners = false;
            language = "";
            lockOnSuspend = true;
            radiusRatio = 1;
            scaleRatio = 1;
            screenRadiusRatio = 1;
            showScreenCorners = false;
          };

          hooks = {
            darkModeChange = "";
            enabled = false;
            wallpaperChange = "";
          };

          location = {
            analogClockInCalendar = false;
            firstDayOfWeek = -1;
            name = "Manila";
            showCalendarEvents = true;
            showCalendarWeather = true;
            showWeekNumberInCalendar = false;
            use12hourFormat = true;
            useFahrenheit = false;
            weatherEnabled = true;
          };

          network = {wifiEnabled = true;};

          nightLight = {
            autoSchedule = true;
            dayTemp = "6500";
            enabled = false;
            forced = false;
            manualSunrise = "06:30";
            manualSunset = "18:30";
            nightTemp = "4000";
          };

          notifications = {
            backgroundOpacity = 1;
            criticalUrgencyDuration = 15;
            doNotDisturb = false;
            location = "top_right";
            lowUrgencyDuration = 3;
            monitors = [];
            normalUrgencyDuration = 8;
            overlayLayer = true;
            respectExpireTimeout = false;
          };

          osd = {
            autoHideMs = 2000;
            enabled = true;
            location = "bottom";
            monitors = [];
            overlayLayer = true;
          };

          screenRecorder = {
            audioCodec = "opus";
            audioSource = "default_output";
            colorRange = "limited";
            directory = "";
            frameRate = 60;
            quality = "very_high";
            showCursor = true;
            videoCodec = "h264";
            videoSource = "portal";
          };

          settingsVersion = 16;
          setupCompleted = true;

          templates = {
            code = false;
            discord = false;
            discord_armcord = false;
            discord_dorion = false;
            discord_equibop = true;
            discord_lightcord = false;
            discord_vesktop = true;
            discord_webcord = false;
            enableUserTemplates = false;
            foot = false;
            fuzzel = false;
            ghostty = true;
            gtk = false;
            kcolorscheme = false;
            kitty = false;
            pywalfox = false;
            qt = false;
            vicinae = false;
            walker = false;
          };

          ui = {
            fontDefault = "Roboto";
            fontDefaultScale = 1;
            fontFixed = "DejaVu Sans Mono";
            fontFixedScale = 1;
            panelsAttachedToBar = true;
            panelsOverlayLayer = true;
            tooltipsEnabled = true;
          };

          wallpaper = {
            defaultWallpaper = "";
            directory = "/home/oxce5/Pictures/Wallpaper";
            enableMultiMonitorDirectories = false;
            enabled = true;
            fillColor = "#000000";
            fillMode = "crop";
            monitors = [
              {
                directory = "/home/oxce5/Pictures/Wallpaper";
                name = "eDP-1";
                wallpaper = "/home/oxce5/Pictures/Wallpaper/teto_unedited.png";
              }
            ];
            randomEnabled = false;
            randomIntervalSec = 300;
            recursiveSearch = false;
            setWallpaperOnAllMonitors = true;
            transitionDuration = 1500;
            transitionEdgeSmoothness = 0.05;
            transitionType = "random";
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
