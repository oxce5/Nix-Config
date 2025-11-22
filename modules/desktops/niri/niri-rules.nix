{
  unify.modules.niri.home = {
    programs.niri.settings = {
      layer-rules = [
        {
          matches = [{namespace = "^noctalia-overview*";}];
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
          geometry-corner-radius = {
            bottom-left = 20.0;
            bottom-right = 20.0;
            top-left = 20.0;
            top-right = 20.0;
          };
        }
      ];
    };
  };
}
