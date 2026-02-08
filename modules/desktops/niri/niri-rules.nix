{
  unify.modules.niri.home = {
    programs.niri.settings = {
      layer-rules = [
        {
          matches = [{namespace = "^dms:blurwallpaper*";}];
          place-within-backdrop = true;
        }
      ];

      window-rules = [
        {
          matches = [
            {
              app-id = "firefox$";
              title = "^Picture-in-Picture$";
            }
          ];
          open-floating = true;
        }

        {
          matches = [{is-window-cast-target = true;}];

          focus-ring = {
            enable = true;
            active.color = "#f38ba8";
            inactive.color = "#7d0d2d";
          };

          border = {
            inactive.color = "#7d0d2d";
          };

          shadow = {
            enable = true;
            color = "#7d0d2d70";
          };

          tab-indicator = {
            active.color = "#f38ba8";
            inactive.color = "#7d0d2d";
          };
        }

        {
          matches = [
            {title = "^*.Messenger.*$";}
          ];
          block-out-from = "screencast";
        }
        {
          matches = [
            {app-id = "^vesktop$";}
          ];
          block-out-from = "screencast";
        }
        {
          matches = [
            {
              title = "^gsr notify$";
            }
          ];
          default-floating-position = {
            relative-to = "top-right";
            x = 12;
            y = 24;
          };
        }
        {
          matches = [
            {app-id = "^at.yrlf.wl_mirror$";}
          ];
          open-on-output = "HDMI-A-5";
        }
        {
          clip-to-geometry = true;
        }
      ];
    };
  };
}
