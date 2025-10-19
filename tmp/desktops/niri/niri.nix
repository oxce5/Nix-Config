{
  unify.modules.workstation = {
    home = 
    {config, pkgs, hostConfig, ...}:
    {
      home.packages = with pkgs; [
        sway-audio-idle-inhibit
      ];

      services = {
        swayidle = let
          lock = "${config.programs.caelestia.package}/bin/caelestia-shell ipc call lock lock";
          display = status: "${pkgs.niri}/bin/niri msg action power-${status}-monitors";
        in {
          enable = false;
          timeouts = [
            {
              timeout = 15;
              command = "${pkgs.libnotify}/bin/notify-send 'Locking in 5 seconds' -t 5000";
            }
            {
              timeout = 45;
              command = lock;
            }
            {
              timeout = 75;
              command = display "off";
              resumeCommand = display "on";
            }
            {
              timeout = 100;
              command = "${pkgs.systemd}/bin/systemctl suspend";
            }
          ];
          events = [
            {
              event = "before-sleep";
              command = (display "off") + "; " + lock;
            }
            {
              event = "after-resume";
              command = display "on";
            }
            {
              event = "lock";
              command = (display "off") + "; " + lock;
            }
            {
              event = "unlock";
              command = display "on"; 
            }
          ];
        };
      };

      programs.niri = {
        package = pkgs.niri-unstable;
        settings = {
          prefer-no-csd = true;
          hotkey-overlay.skip-at-startup = true;

          outputs."eDP-1" = {
            mode = {
              width = hostConfig.primaryDisplay.width;
              height = hostConfig.primaryDisplay.height;
            };
            scale = 1.0;
            position.x = 0;
            position.y = 0;
          };

          outputs."HDMI-A-5" = {
            mode = {
              width = hostConfig.primaryDisplay.width;
              height = hostConfig.primaryDisplay.height;
            };
            scale = 1.0;
            position.x = 0;
            position.y = 0;
          };

          overview.workspace-shadow.enable = false;
          spawn-at-startup = [
            {command = ["${pkgs.mate.mate-polkit}/libexec/polkit-mate-authentication-agent-1"];}
            {command = ["sway-audio-idle-inhibit"];}
            {command = ["systemctl" "--user" "restart" "xdg-desktop-portal-gtk"];}
            {command = ["flatpak" "run" "com.dec05eba.gpu_screen_recorder"];}
          ];
        };
      };
    };

    nixos = 
    { inputs, ...}:
    {
      imports = [inputs.niri-flake.nixosModules.niri];

      nixpkgs.overlays = [inputs.niri-flake.overlays.niri];
      programs.niri = {
        enable = true;
      };
      niri-flake.cache.enable = true;
    };
  };
}
