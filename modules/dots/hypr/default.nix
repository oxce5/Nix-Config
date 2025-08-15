{
  imports = [./hyprlock.nix];
  hydenix = {
    hm.hyprland = {
      enable = true; # enable hyprland module
      extraConfig = ''
        $TERMINAL = ghostty
        $env.BATTERY_NOTIFY_EXECUTE_UNPLUG = "hyprctl keyword monitor eDP-1,1920x1080@60,0x0,1"
        $env.BATTERY_NOTIFY_EXECUTE_CHARGING = "hyprctl keyword monitor eDP-1,1920x1080@144,0x0,1"
        $env.BATTERY_NOTIFY_EXECUTE_DISCHARGING = "hyprctl keyword monitor eDP-1,1920x1080@60,0x0,1"

        $env.CURSOR_THEME=Teto_Cursor
        $env.CURSOR_SIZE=24

        exec = hyprctl setcursor "Teto_Cursor" 24
        exec = kurukurubar &
        exec-once = flatpak run com.dec05eba.gpu_screen_recorder

        monitor = eDP-1, 1920x1080@144, 0x0, 1

        misc {
          vfr = true
          render_unfocused_fps = 30
        }

        debug {
          full_cm_proto = true
          suppress_errors = true
          error_limit = 0
        }
      ''; # extra config appended to userprefs.conf
      overrideMain = null; # complete override of hyprland.conf
      suppressWarnings = true; # suppress warnings
      # Animation configurations
      animations = {
        enable = true; # enable animation configurations
        preset = "standard"; # animation preset: "LimeFrenzy", "classic", "diablo-1", "diablo-2", "disable", "dynamic", "end4", "fast", "high", "ja", "me-1", "me-2", "minimal-1", "minimal-2", "moving", "optimized", "standard", "vertical"
        extraConfig = ""; # additional animation configuration
        overrides = {}; # override specific animation files by name
      };
      # Shader configurations
      shaders = {
        enable = true; # enable shader configurations
        overrides = {}; # override or add custom shaders
      };
      # Workflow configurations
      workflows = {
        enable = true; # enable workflow configurations
        active = "snappy"; # active workflow preset: "default", "editing", "gaming", "powersaver", "snappy"
        overrides = {}; # override or add custom workflows
      };
      # Hypridle configurations
      hypridle = {
        enable = true; # enable hypridle configurations
        extraConfig = ""; # additional hypridle configuration
        overrideConfig = null; # complete hypridle configuration override (null or lib.types.lines)
      };
      # Keybindings configurations
      keybindings = {
        enable = true; # enable keybindings configurations
        extraConfig = ''
          bindd = ALT_R, Control_R, toggle waybar, exec, pkill kurukurubar || pkill -f .quickshell || pkill dunst; (dunst &) & (kurukurubar &);
          bindd = $mainMod, T, $d terminal emulator , exec, ghostty
          bindd = $mainMod Alt, T, $d dropdown terminal , exec, [float; move 20% 5%; size 60% 60%] ghostty
        ''; # additional keybindings configuration
        overrideConfig = null; # complete keybindings configuration override (null or lib.types.lines)
      };
      # Window rules configurations
      windowrules = {
        enable = true; # enable window rules configurations
        extraConfig = ''
          windowrulev2 = float, initialClass:^(Waydroid)$
          windowrulev2 = fullscreen, initialClass:^(Waydroid)$

          windowrulev2 = renderunfocused, initialClass:^(starrail)$
          windowrulev2 = renderunfocused, initialClass:^Minecraft.*$
          windowrulev2 = renderunfocused, initialClass:^steam_app_*$

          $&=override

          windowrulev2 = opacity 0.995 $& 0.995 $& 1,class:^(zen-twilight)$
        ''; # additional window rules configuration
        overrideConfig = null; # complete window rules configuration override (null or lib.types.lines)
      };
      # NVIDIA configurations
      nvidia = {
        enable = true; # enable NVIDIA configurations (defaults to config.hardware.nvidia.enabled)
        extraConfig = ""; # additional NVIDIA configuration
        overrideConfig = null; # complete NVIDIA configuration override (null or lib.types.lines)
      };
      # Monitor configurations
      monitors = {
        enable = true; # enable monitor configurations
        overrideConfig = null; # complete monitor configuration override (null or lib.types.lines)
      };
    };
    hm.lockscreen = {
      enable = false; # enable lockscreen module
      hyprlock = false; # enable hyprlock lockscreen
      swaylock = false; # enable swaylock lockscreen
    };
  };
  services.hyprpolkitagent.enable = true;
}
