{
  inputs,
  outputs,
  pkgs,
  lib,
  ...
}: let
  swww = inputs.swww.packages.${pkgs.system}.swww;
in {
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
    swww
  ];

  services = {
    swayidle = {
      enable = true;
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
        {command = ["mako"];}
        {command = ["ignis" "init"];}
        {command = ["swww-daemon"];}
        {command = ["swww-daemon" "-n" "backdrop"];}
        {command = ["swww" "img" "-n" "backdrop" "~/nix-setup/home/oxce5/wallpapers/tetoes5_blur.jpg"];}
        {command = ["xwayland-satellite"];}
        {command = ["systemctl" "--user" "restart" "xdg-desktop-portal-gtk"];}
        {command = ["flatpak" "run" "com.dec05eba.gpu_screen_recorder"];}
      ];
    };
  };
}
