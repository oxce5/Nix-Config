{
  unify.modules.hyprland = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        hyprpaper
        hyprland
        wl-clipboard
        hyprland-qtutils
        hyprpolkitagent
        wlogout
        clipse
      ];
    };
    home = {pkgs, ...}: {
      wayland.windowManager.hyprland = {
        enable = true;
        systemd = {
          enable = true;
          enableXdgAutostart = true;
        };
        xwayland.enable = true;
        plugins = [
          pkgs.hyprlandPlugins.hyprsplit
        ];
        settings = {
          monitor = [
            "Virtual-1,1280x720@60,0x0,1"
          ];
          exec-once = [
            "dunst"
            "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP GTK_THEME"
            "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP GTK_THEME"
            "systemctl --user start hyprpolkitagent"
            "clipse -listen"
          ];
          misc = {
            disable_hyprland_logo = true;
            disable_splash_rendering = true;
          };
          input = {
            follow_mouse = 1;
            sensitivity = 0.3;
          };
          general = {
            gaps_in = 6;
            gaps_out = 12;
            border_size = 4;
          };
          decoration = {
            rounding = 8;
            blur = {
              enabled = false;
            };
          };
          animations = {
            enabled = 1;
            animation = [
              "windowsIn,1,4,default"
              "windowsMove,1,2,default"
              "windowsOut,1,4,default,slide"
              "border,1,5,default"
              "fade,1,5,default"
              "workspaces,0,1,default"
            ];
          };
          dwindle = {
            pseudotile = 0;
          };
          windowrule = [
            "float,class:(clipse)"
            "size 622 652,class:(clipse)"
            "center,class:(clipse)"
          ];
          bind = [
            # Basic binds
            "SUPER,T,exec,ghostty"
            "SUPER,Q,killactive,"
            "SUPER,V,togglefloating,"
            "SUPER,Space,exec,fuzzel"
            "SUPERSHIFT,S,exec,grimblast copy area"
            "SUPERSHIFT,V,exec,ghostty --app-id=clipse clipse"
            "SUPER,F,fullscreen,0"
            "SUPER,X,exec,wlogout"
            "SUPER,L,exec,hyprlock"
            # Focus
            "SUPER,left,movefocus,l"
            "SUPER,right,movefocus,r"
            "SUPER,up,movefocus,u"
            "SUPER,down,movefocus,d"
            # Movemente
            "SUPERSHIFT,left,movewindow,l"
            "SUPERSHIFT,right,movewindow,r"
            "SUPERSHIFT,up,movewindow,u"
            "SUPERSHIFT,down,movewindow,d"
            # Resize
            "SUPERCTRL,right,resizeactive,10 0"
            "SUPERCTRL,left,resizeactive,-10 0"
            "SUPERCTRL,up,resizeactive,0 -10"
            "SUPERCTRL,down,resizeactive,0 10"
            # Change to Workspace
            "SUPER,1,split:workspace,1"
            "SUPER,2,split:workspace,2"
            "SUPER,3,split:workspace,3"
            "SUPER,4,split:workspace,4"
            "SUPER,5,split:workspace,5"
            "SUPER,6,split:workspace,6"
            "SUPER,7,split:workspace,7"
            "SUPER,8,split:workspace,8"
            "SUPER,9,split:workspace,9"
            "SUPER,0,split:workspace,0"
            # Move app to workspace
            "SUPERSHIFT,1,split:movetoworkspacesilent,1"
            "SUPERSHIFT,2,split:movetoworkspacesilent,2"
            "SUPERSHIFT,3,split:movetoworkspacesilent,3"
            "SUPERSHIFT,4,split:movetoworkspacesilent,4"
            "SUPERSHIFT,5,split:movetoworkspacesilent,5"
            "SUPERSHIFT,6,split:movetoworkspacesilent,6"
            "SUPERSHIFT,7,split:movetoworkspacesilent,7"
            "SUPERSHIFT,8,split:movetoworkspacesilent,8"
            "SUPERSHIFT,9,split:movetoworkspacesilent,9"
            "SUPERSHIFT,0,split:movetoworkspacesilent,0"
            ",XF86MonBrightnessUp,exec,brightnessctl set +5%"
            ",XF86MonBrightnessDown,exec,brightnessctl set 5%-"
            ",XF86AudioRaiseVolume,exec,amixer -D pipewire sset Master 5%+"
            ",XF86AudioLowerVolume,exec,amixer -D pipewire sset Master 5%-"
            ",XF86AudioMute,exec,amixer -D pipewire sset Master 1+ toggle"
          ];
          bindm = [
            "SUPER, mouse:272, movewindow"
            "SUPER, mouse:273, resizewindow"
          ];
        };
      };
    };
  };
}
