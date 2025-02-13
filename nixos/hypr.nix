{ config, lib, pkgs, ... }:

{
  programs.hyprland = {
      enable = true;
      withUWSM = true;
    };
   programs.hyprlock.enable = true;
   programs.uwsm.enable = true;
   services.hypridle.enable = true;
}
