{
  imports = [./hyprlock.nix];

  hydenix.hm = {
    hyprland = {
      enable = true; # enable hyprland module
      extraConfig = ''
        $TERMINAL = ghostty
        $env.BATTERY_NOTIFY_EXECUTE_UNPLUG = "hyprctl keyword monitor eDP-1,1920x1080@60,0x0,1"
        $env.BATTERY_NOTIFY_EXECUTE_CHARGING = "hyprctl keyword monitor eDP-1,1920x1080@144,0x0,1"
        $env.BATTERY_NOTIFY_EXECUTE_DISCHARGING = "hyprctl keyword monitor eDP-1,1920x1080@60,0x0,1"

        $CURSOR_THEME=Rice_Cursor
        $CURSOR_SIZE=24

        exec-once = hyprctl setcursor "Rice_Cursor" 24
        exec-once = kurukurubar
        exec-once = flatpak run com.dec05eba.gpu_screen_recorder

        bindd = ALT_R, Control_R,toggle waybar, exec,  pkill kurukurubar || pkill -f .quickshell || pkill dunst && dunst & kurukurubar & 
        bindd = $mainMod, T, $d terminal emulator , exec, ghostty
        bindd = $mainMod Alt, T, $d dropdown terminal , exec, [float; move 20% 5%; size 60% 60%] ghostty

        monitor = eDP-1, 1920x1080@144, 0x0, 1

        misc {
          vfr = true
          render_unfocused_fps = 30
        }

        windowrulev2 = float, initialClass:^(Waydroid)$
        windowrulev2 = fullscreen, initialClass:^(Waydroid)$

        windowrulev2 = renderunfocused, initialClass:^(starrail)$
        windowrulev2 = renderunfocused, initialClass:^Minecraft.*$
        windowrulev2 = renderunfocused, initialClass:^steam_app_*$

        $&=override

        windowrulev2 = opacity 0.995 $& 0.995 $& 1,class:^(zen-twilight)$

        debug {
          full_cm_proto = true
          suppress_errors = true
          error_limit = 0
        }
      '';
    };
    lockscreen = {
      enable = false; # enable lockscreen module
      hyprlock = false; # enable hyprlock lockscreen
      swaylock = false; # enable swaylock lockscreen
    };
  };
  services.hyprpolkitagent.enable = true;
}
