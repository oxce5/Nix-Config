{
  programs.niri.settings = {
    layer-rules = [
      {
        matches = [{namespace = "^quickshell-wallpaper$";}];
        place-within-backdrop = true;
      }
      {
        matches = [{namespace = "^quickshell-overview$";}];
        opacity = 0.0;
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
          {app-id = "^at.yrlf.wl_mirror*";}
        ];
        open-on-output = "HDMI-A-1";
      }
    ];
  };
}
