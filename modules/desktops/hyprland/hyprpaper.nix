{
  unify.modules.hyprland = {
    home = {hostConfig, ...}: {
      services.hyprpaper = {
        enable = true;
        settings = {
          preload = [
            "${hostConfig.primaryWallpaper}"
          ];
          wallpaper = [
            "Virtual-1,${hostConfig.primaryWallpaper}"
          ];
          ipc = "on";
          splash = false;
        };
      };
    };
  };
}
