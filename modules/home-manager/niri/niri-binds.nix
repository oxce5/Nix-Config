{config, ...}:

{
  programs.niri.settings.binds = with config.lib.niri.actions; {
    "Mod+Shift+Slash".action = show-hotkey-overlay;
    "Mod+T".action = spawn "ghostty";
    "Mod+Space".action = spawn "wofi" "--show" "drun" "--sort-order=alphabetical";
    "Mod+L".action = spawn "swaylock";

    "XF86AudioRaiseVolume".action =  spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+";
    "XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";
    "XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
    "XF86AudioMicMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";

    "XF86MonBrightnessUp".action = spawn "brightnessctl" "--class=backlight" "set" "+10%";
    "XF86MonBrightnessDown".action =  spawn "brightnessctl" "--class=backlight" "set" "10%-"; 

    "Mod+O".action = toggle-overview;        # nix: Mod+O repeat=false { toggle-overview; }
    "Mod+Q".action = close-window;           # nix: Mod+Q repeat=false { close-window; }

    "Mod+Left".action = focus-column-left;   # nix: Mod+Left  { focus-column-left; }
    "Mod+Down".action = focus-window-down;   # nix: Mod+Down  { focus-window-down; }
    "Mod+Up".action = focus-window-up;       # nix: Mod+Up    { focus-window-up; }
    "Mod+Right".action = focus-column-right; # nix: Mod+Right { focus-column-right; }
    "Mod+H".action = focus-column-left;      # nix: Mod+H     { focus-column-left; }
    "Mod+J".action = focus-window-down;      # nix: Mod+J     { focus-window-down; }
    "Mod+K".action = focus-window-up;        # nix: Mod+K     { focus-window-up; }
    "Mod+L".action = focus-column-right;     # nix: Mod+L     { focus-column-right; }

    "Mod+Ctrl+Left".action = move-column-left;   # nix: Mod+Ctrl+Left  { move-column-left; }
    "Mod+Ctrl+Down".action = move-window-down;   # nix: Mod+Ctrl+Down  { move-window-down; }
    "Mod+Ctrl+Up".action = move-window-up;       # nix: Mod+Ctrl+Up    { move-window-up; }
    "Mod+Ctrl+Right".action = move-column-right; # nix: Mod+Ctrl+Right { move-column-right; }
    "Mod+Ctrl+H".action = move-column-left;      # nix: Mod+Ctrl+H     { move-column-left; }
    "Mod+Ctrl+J".action = move-window-down;      # nix: Mod+Ctrl+J     { move-window-down; }
    "Mod+Ctrl+K".action = move-window-up;        # nix: Mod+Ctrl+K     { move-window-up; }
    "Mod+Ctrl+L".action = move-column-right;     # nix: Mod+Ctrl+L     { move-column-right; }

    "Mod+Home".action = focus-column-first;      # nix: Mod+Home { focus-column-first; }
    "Mod+End".action = focus-column-last;        # nix: Mod+End  { focus-column-last; }
    "Mod+Ctrl+Home".action = move-column-to-first; # nix: Mod+Ctrl+Home { move-column-to-first; }
    "Mod+Ctrl+End".action = move-column-to-last;   # nix: Mod+Ctrl+End  { move-column-to-last; }

    "Mod+Shift+Left".action = focus-monitor-left;   # nix: Mod+Shift+Left  { focus-monitor-left; }
    "Mod+Shift+Down".action = focus-monitor-down;   # nix: Mod+Shift+Down  { focus-monitor-down; }
    "Mod+Shift+Up".action = focus-monitor-up;       # nix: Mod+Shift+Up    { focus-monitor-up; }
    "Mod+Shift+Right".action = focus-monitor-right; # nix: Mod+Shift+Right { focus-monitor-right; }
    "Mod+Shift+H".action = focus-monitor-left;      # nix: Mod+Shift+H     { focus-monitor-left; }
    "Mod+Shift+J".action = focus-monitor-down;      # nix: Mod+Shift+J     { focus-monitor-down; }
    "Mod+Shift+K".action = focus-monitor-up;        # nix: Mod+Shift+K     { focus-monitor-up; }
    "Mod+Shift+L".action = focus-monitor-right;     # nix: Mod+Shift+L     { focus-monitor-right; }

    "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;   # nix: Mod+Shift+Ctrl+Left  { move-column-to-monitor-left; }
    "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;   # nix: Mod+Shift+Ctrl+Down  { move-column-to-monitor-down; }
    "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;       # nix: Mod+Shift+Ctrl+Up    { move-column-to-monitor-up; }
    "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right; # nix: Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }
    "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;      # nix: Mod+Shift+Ctrl+H     { move-column-to-monitor-left; }
    "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;      # nix: Mod+Shift+Ctrl+J     { move-column-to-monitor-down; }
    "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;        # nix: Mod+Shift+Ctrl+K     { move-column-to-monitor-up; }
    "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;     # nix: Mod+Shift+Ctrl+L     { move-column-to-monitor-right; }

    "Mod+Page_Down".action = focus-workspace-down;           # nix: Mod+Page_Down      { focus-workspace-down; }
    "Mod+Page_Up".action = focus-workspace-up;               # nix: Mod+Page_Up        { focus-workspace-up; }
    "Mod+U".action = focus-workspace-down;                   # nix: Mod+U              { focus-workspace-down; }
    "Mod+I".action = focus-workspace-up;                     # nix: Mod+I              { focus-workspace-up; }
    "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down; # nix: Mod+Ctrl+Page_Down { move-column-to-workspace-down; }
    "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;     # nix: Mod+Ctrl+Page_Up   { move-column-to-workspace-up; }
    "Mod+Ctrl+U".action = move-column-to-workspace-down;     # nix: Mod+Ctrl+U         { move-column-to-workspace-down; }
    "Mod+Ctrl+I".action = move-column-to-workspace-up;       # nix: Mod+Ctrl+I         { move-column-to-workspace-up; }

    "Mod+Shift+Page_Down".action = move-workspace-down;  # nix: Mod+Shift+Page_Down { move-workspace-down; }
    "Mod+Shift+Page_Up".action = move-workspace-up;      # nix: Mod+Shift+Page_Up   { move-workspace-up; }
    "Mod+Shift+U".action = move-workspace-down;          # nix: Mod+Shift+U         { move-workspace-down; }
    "Mod+Shift+I".action = move-workspace-up;            # nix: Mod+Shift+I         { move-workspace-up; }

    "Mod+WheelScrollDown".action = cooldown-ms=150 focus-workspace-down;      # nix: Mod+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
    "Mod+WheelScrollUp".action = cooldown-ms=150 focus-workspace-up;          # nix: Mod+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
    "Mod+Ctrl+WheelScrollDown".action = cooldown-ms=150 move-column-to-workspace-down; # nix: Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
    "Mod+Ctrl+WheelScrollUp".action = cooldown-ms=150 move-column-to-workspace-up;     # nix: Mod+Ctrl+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }

    "Mod+WheelScrollRight".action = focus-column-right;   # nix: Mod+WheelScrollRight      { focus-column-right; }
    "Mod+WheelScrollLeft".action = focus-column-left;     # nix: Mod+WheelScrollLeft       { focus-column-left; }
    "Mod+Ctrl+WheelScrollRight".action = move-column-right; # nix: Mod+Ctrl+WheelScrollRight { move-column-right; }
    "Mod+Ctrl+WheelScrollLeft".action = move-column-left;   # nix: Mod+Ctrl+WheelScrollLeft  { move-column-left; }

    "Mod+Shift+WheelScrollDown".action = focus-column-right;      # nix: Mod+Shift+WheelScrollDown      { focus-column-right; }
    "Mod+Shift+WheelScrollUp".action = focus-column-left;         # nix: Mod+Shift+WheelScrollUp        { focus-column-left; }
    "Mod+Ctrl+Shift+WheelScrollDown".action = move-column-right;  # nix: Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
    "Mod+Ctrl+Shift+WheelScrollUp".action = move-column-left;     # nix: Mod+Ctrl+Shift+WheelScrollUp   { move-column-left; }

    "Mod+1".action = focus-workspace 1;   # nix: Mod+1 { focus-workspace 1; }
    "Mod+2".action = focus-workspace 2;   # nix: Mod+2 { focus-workspace 2; }
    "Mod+3".action = focus-workspace 3;   # nix: Mod+3 { focus-workspace 3; }
    "Mod+4".action = focus-workspace 4;   # nix: Mod+4 { focus-workspace 4; }
    "Mod+5".action = focus-workspace 5;   # nix: Mod+5 { focus-workspace 5; }
    "Mod+6".action = focus-workspace 6;   # nix: Mod+6 { focus-workspace 6; }
    "Mod+7".action = focus-workspace 7;   # nix: Mod+7 { focus-workspace 7; }
    "Mod+8".action = focus-workspace 8;   # nix: Mod+8 { focus-workspace 8; }
    "Mod+9".action = focus-workspace 9;   # nix: Mod+9 { focus-workspace 9; }
    "Mod+Ctrl+1".action = move-column-to-workspace 1; # nix: Mod+Ctrl+1 { move-column-to-workspace 1; }
    "Mod+Ctrl+2".action = move-column-to-workspace 2; # nix: Mod+Ctrl+2 { move-column-to-workspace 2; }
    "Mod+Ctrl+3".action = move-column-to-workspace 3; # nix: Mod+Ctrl+3 { move-column-to-workspace 3; }
    "Mod+Ctrl+4".action = move-column-to-workspace 4; # nix: Mod+Ctrl+4 { move-column-to-workspace 4; }
    "Mod+Ctrl+5".action = move-column-to-workspace 5; # nix: Mod+Ctrl+5 { move-column-to-workspace 5; }
    "Mod+Ctrl+6".action = move-column-to-workspace 6; # nix: Mod+Ctrl+6 { move-column-to-workspace 6; }
    "Mod+Ctrl+7".action = move-column-to-workspace 7; # nix: Mod+Ctrl+7 { move-column-to-workspace 7; }
    "Mod+Ctrl+8".action = move-column-to-workspace 8; # nix: Mod+Ctrl+8 { move-column-to-workspace 8; }
    "Mod+Ctrl+9".action = move-column-to-workspace 9; # nix: Mod+Ctrl+9 { move-column-to-workspace 9; }

    "Mod+BracketLeft".action = consume-or-expel-window-left;   # nix: Mod+BracketLeft  { consume-or-expel-window-left; }
    "Mod+BracketRight".action = consume-or-expel-window-right; # nix: Mod+BracketRight { consume-or-expel-window-right; }
    "Mod+Comma".action = consume-window-into-column;           # nix: Mod+Comma  { consume-window-into-column; }
    "Mod+Period".action = expel-window-from-column;            # nix: Mod+Period { expel-window-from-column; }

    "Mod+R".action = switch-preset-column-width;       # nix: Mod+R { switch-preset-column-width; }
    "Mod+Shift+R".action = switch-preset-window-height;# nix: Mod+Shift+R { switch-preset-window-height; }
    "Mod+Ctrl+R".action = reset-window-height;         # nix: Mod+Ctrl+R { reset-window-height; }
    "Mod+F".action = maximize-column;                  # nix: Mod+F { maximize-column; }
    "Mod+Shift+F".action = fullscreen-window;          # nix: Mod+Shift+F { fullscreen-window; }
    "Mod+Ctrl+F".action = expand-column-to-available-width; # nix: Mod+Ctrl+F { expand-column-to-available-width; }
    "Mod+C".action = center-column;                    # nix: Mod+C { center-column; }
    "Mod+Ctrl+C".action = center-visible-columns;      # nix: Mod+Ctrl+C { center-visible-columns; }

    "Mod+Minus".action = set-column-width "-10%";     # nix: Mod+Minus { set-column-width "-10%"; }
    "Mod+Equal".action = set-column-width "+10%";     # nix: Mod+Equal { set-column-width "+10%"; }
    "Mod+Shift+Minus".action = set-window-height "-10%"; # nix: Mod+Shift+Minus { set-window-height "-10%"; }
    "Mod+Shift+Equal".action = set-window-height "+10%"; # nix: Mod+Shift+Equal { set-window-height "+10%"; }

    "Mod+V".action = toggle-window-floating;         # nix: Mod+V       { toggle-window-floating; }
    "Mod+Shift+V".action = switch-focus-between-floating-and-tiling; # nix: Mod+Shift+V { switch-focus-between-floating-and-tiling; }
    "Mod+W".action = toggle-column-tabbed-display;   # nix: Mod+W { toggle-column-tabbed-display; }

    "Mod+P".action = screenshot;                     # nix: Mod+P { screenshot; }
    "Mod+Alt+P".action = screenshot-screen;          # nix: Mod+Alt+P { screenshot-screen; }

    "Mod+Escape" = {
      action =  toggle-keyboard-shortcuts-inhibit; # nix: Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }
      allow-inhibiting=false;
    };
    "Mod+Shift+E".action = quit;                     # nix: Mod+Shift+E { quit; }
    "Ctrl+Alt+Delete".action = quit;                 # nix: Ctrl+Alt+Delete { quit; }
    "Mod+Shift+P".action = power-off-monitors;       # nix: Mod+Shift+P { power-off-monitors; }
  };
}
