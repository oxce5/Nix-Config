{
  programs.hyprlock = {
    enable = true;
    extraConfig = "source=~/.config/hypr/hyprlock/hyprlock.conf";
  };

  services.hypridle = {
    enable = true;
    settings = {
        general = {
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
          lock_cmd = "pidof hyprlock || hyprlock";
          ignore_dbus_inhibit = false;
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "hyprlock";
          on-resume = "notify-send 'Welcome back!'";
        }
        {
          timeout = 540;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
