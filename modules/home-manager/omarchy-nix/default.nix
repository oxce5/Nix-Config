{config, lib, inputs, outputs, pkgs, ...}:

let
  cfg = config.omarchy;
  userBinds = cfg.quick_app_bindings ++ [
    "Alt_R, Control_R, exec, ${builtins.toString ../../bin/reset_notif.sh}"
    "SUPER, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"

    ''SUPER, P, exec, grim -g "$(slurp)" - | satty -f - -o ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png''
    "SUPER ALT_L, P, exec, grim -o eDP-1 - | satty -f - -o ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png"

    "SUPER SHIFT, V, togglefloating,"
  ];
  baseBinds = [
    "SUPER, space, exec, wofi --show drun --sort-order=alphabetical"

    "SUPER, W, killactive,"
    "SUPER, Backspace, killactive,"

    # End active session
    "SUPER, ESCAPE, exec, hyprlock"
    "SUPER SHIFT, ESCAPE, exit,"
    "SUPER CTRL, ESCAPE, exec, reboot"
    "SUPER SHIFT CTRL, ESCAPE, exec, systemctl poweroff"
    "SUPER, K, exec, ~/.local/share/omarchy/bin/omarchy-show-keybindings"

    # Control tiling
    "SUPER, J, togglesplit, # dwindle"
    "SUPER SHIFT, Plus, fullscreen,"

    # Move focus with mainMod + arrow keys
    "SUPER, left, movefocus, l"
    "SUPER, right, movefocus, r"
    "SUPER, up, movefocus, u"
    "SUPER, down, movefocus, d"

    # Switch workspaces with mainMod + [0-9]
    "SUPER, 1, workspace, 1"
    "SUPER, 2, workspace, 2"
    "SUPER, 3, workspace, 3"
    "SUPER, 4, workspace, 4"
    "SUPER, 5, workspace, 5"
    "SUPER, 6, workspace, 6"
    "SUPER, 7, workspace, 7"
    "SUPER, 8, workspace, 8"
    "SUPER, 9, workspace, 9"
    "SUPER, 0, workspace, 10"
    
    "SUPER, comma, workspace, -1"
    "SUPER, period, workspace, +1"

    # Move active window to a workspace with mainMod + SHIFT + [0-9]
    "SUPER SHIFT, 1, movetoworkspace, 1"
    "SUPER SHIFT, 2, movetoworkspace, 2"
    "SUPER SHIFT, 3, movetoworkspace, 3"
    "SUPER SHIFT, 4, movetoworkspace, 4"
    "SUPER SHIFT, 5, movetoworkspace, 5"
    "SUPER SHIFT, 6, movetoworkspace, 6"
    "SUPER SHIFT, 7, movetoworkspace, 7"
    "SUPER SHIFT, 8, movetoworkspace, 8"
    "SUPER SHIFT, 9, movetoworkspace, 9"
    "SUPER SHIFT, 0, movetoworkspace, 10"

    # Swap active window with the one next to it with mainMod + SHIFT + arrow keys
    "SUPER SHIFT, left, swapwindow, l"
    "SUPER SHIFT, right, swapwindow, r"
    "SUPER SHIFT, up, swapwindow, u"
    "SUPER SHIFT, down, swapwindow, d"

    # Resize active window
    "SUPER, minus, resizeactive, -100 0"
    "SUPER, equal, resizeactive, 100 0"
    "SUPER SHIFT, minus, resizeactive, 0 -100"
    "SUPER SHIFT, equal, resizeactive, 0 100"

    # Scroll through existing workspaces with mainMod + scroll
    "SUPER, mouse_down, workspace, e+1"
    "SUPER, mouse_up, workspace, e-1"

    # Control Apple Display brightness
    "CTRL, F1, exec, ~/.local/share/omarchy/bin/apple-display-brightness -5000"
    "CTRL, F2, exec, ~/.local/share/omarchy/bin/apple-display-brightness +5000"
    "SHIFT CTRL, F2, exec, ~/.local/share/omarchy/bin/apple-display-brightness +60000"

    # Super workspace floating layer
    "SUPER, S, togglespecialworkspace, magic"
    "SUPER SHIFT, S, movetoworkspace, special:magic"

    # Color picker
    "SUPER, PRINT, exec, hyprpicker -a"
  ];
  finalBinds = userBinds ++ baseBinds;
in {

    imports = [
      inputs.omarchy-nix.homeManagerModules.default
      outputs.nixosModules.omarchy-config
    ];

    omarchy = {
      theme = "gruvbox";
      theme_overrides = {
        wallpaper_path = ../../home/oxce5/tetoes4.jpg;
      };
      scale = 1;
      monitors = [
        "eDP-1, 1920x1080@144, 0x0, 1"
      ];
    };

    wayland.windowManager.hyprland = {
      package = lib.mkForce inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = lib.mkForce inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

      settings = {
        "$terminal" = "ghostty";
        "$fileManager" = "nautilus --new-window";
        "$browser" = "zen";
        "$music" = "youtube-music";
        "$passwordManager" = "1password";
        "$messenger" = "telegram-desktop";
        "$webapp" = "$browser --app";
        

        exec-once = [
          "mako"
          "nm-applet"
          "sleep 0.5 && kurukurubar"
          "flatpak run com.dec05eba.gpu_screen_recorder"
        ];

        exec = [
          "wl-paste --watch cliphist store &"
        ];

        env = [
          "GTK_THEME,Teto_Cursor"
          "XCURSOR_SIZE,24"
          "HYPRCURSOR_SIZE,24"
          "XCURSOR_THEME,Teto_Cursor"
          "HYPRCURSOR_THEME,Teto_Cursor"
        ];

        input = {
          kb_options = "ctrl:nocaps";
          accel_profile = "flat";
          sensitivity = 0.25;
          touchpad = {
            natural_scroll = true;
            tap-to-click = true;
            drag_lock = true;
          };
        };
        gestures = {
          workspace_swipe = true;
        };

        windowrule = [
          "noscreenshare, title:.*Messenger.*"
          "noscreenshare, initialClass:discord"
          "noscreenshare, title:.*X — Zen Twilight"
        ];
      };
    };

    wayland.windowManager.hyprland.settings.bind = lib.mkForce finalBinds;
}
