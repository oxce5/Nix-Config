{inputs, ...}: {
  unify.modules.niri = {
    home = {
      config,
      pkgs,
      hostConfig,
      ...
    }: {
      home.packages = with pkgs; [
        sway-audio-idle-inhibit
        xwayland-satellite
      ];

      xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gnome
          xdg-desktop-portal-gtk
        ];
        config = {
          niri = {
            "org.freedesktop.impl.portal.Secret" = ["gnome-keyring"];
            "org.freedesktop.impl.portal.FileChooser" = ["gtk"];
          };
        };
      };

      services = {
        cliphist.enable = true;
      };

      programs.niri = {
        settings = {
          prefer-no-csd = true;
          hotkey-overlay.skip-at-startup = true;
          debug = {
            honor-xdg-activation-with-invalid-serial = true;
          };

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

    nixos = {pkgs, ...}: {
      imports = [inputs.niri-flake.nixosModules.niri];

      nixpkgs.overlays = [inputs.niri-flake.overlays.niri];
      programs.niri = {
        enable = true;
        package = pkgs.niri-unstable;
      };
      niri-flake.cache.enable = true;
    };
  };
}
