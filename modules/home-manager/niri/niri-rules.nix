{
  programs.niri.settings = {
    layer-rules = {
      backdrop = {
        matches = {
          backdrop = {
            namespace = "^swww-daemonbackdrop$";
          };
        };
        place-within-backdrop = true;
      };
    };

    window-rules = {
      floating = {
        matches = {
          firefox = {
            app-id = "firefox$";
            title="^Picture-in-Picture$";
          };
        };
      };
      screencast = {
        matches = {
          messenger = {
            title = "^*.Messenger.*$";
          };
          discord = {
            app-id = "^discord$";
          };
        };
        block-out-from = "screencast";
      };
    };
  };
}
