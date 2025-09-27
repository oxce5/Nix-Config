{
  inputs,
  outputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./niri-inputs.nix
    ./niri-layouts.nix
    ./niri-env.nix
    ./niri-binds.nix
    ./niri-rules.nix
  ];

  home.packages = with pkgs; [
    xwayland-satellite
    alacritty
    mako
    sway-audio-idle-inhibit
  ];

  services = {
    swayidle =  let
      lock = "${config.programs.caelestia.package}/bin/caelestia-shell ipc call lock lock";
      display = status: "${pkgs.niri}/bin/niri msg action power-${status}-monitors";
    in 
    {
    enable = true;
    timeouts = [
      {
        timeout = 15; 
        command = "${pkgs.libnotify}/bin/notify-send 'Locking in 5 seconds' -t 5000";
      }
      {
        timeout = 45;
        command = lock;
      }
      {
        timeout = 75;
        command = display "off";
        resumeCommand = display "on";
      }
      {
        timeout = 100;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
    events = [
        {
          event = "before-sleep";
          command = (display "off") + "; " + lock;
        }
        {
          event = "after-resume";
          command = display "on";
        }
        {
          event = "lock";
          command = (display "off") + "; " + lock;
        }
        {
          event = "unlock";
          command = display "on";
        }
      ];
    };
  };

  nixpkgs.overlays = [inputs.niri-flake.overlays.niri];

  programs.niri = {
    package = pkgs.niri-unstable;
    settings = {
      prefer-no-csd = true;
      hotkey-overlay.skip-at-startup = true;

      outputs."eDP-1" = {
        mode = {
          width = 1920;
          height = 1080;
        };
        scale = 1.0;
        position.x = 0;
        position.y = 0;
      };

      overview.workspace-shadow.enable = false;
      spawn-at-startup = [
        {command = ["${pkgs.mate.mate-polkit}/libexec/polkit-mate-authentication-agent-1"];}
        {command = ["caelestia-shell"];}
        {command = ["caelestia-shell" "ipc" "call" "wallpaper" "set" "/home/oxce5/nix-setup/home/oxce5/wallpapers/tetoes5.jpg"];}

        {command = ["xwayland-satellite"];}
        {command = ["sway-audio-idle-inhibit"];}
        {command = ["systemctl" "--user" "restart" "xdg-desktop-portal-gtk"];}
        {command = ["flatpak" "run" "com.dec05eba.gpu_screen_recorder"];}
      ];
    };
  };
}
