{
  programs.niri.settings = {
    layer-rules = [
      {
        matches = [
          {namespace = "^swww-daemonbackdrop$";}
        ];
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
          {app-id = "^discord$";}
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
    ];
  };
}
