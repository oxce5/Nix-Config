{ config, lib, pkgs, ... }:

{
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "gtk";
  services.flatpak.enable = true; 
  services.blueman.enable = true;
  systemd.packages = [ pkgs.cloudflare-warp ]; # for warp-cli
  systemd.targets.multi-user.wants = [ "warp-svc.service" ]; # causes warp-svc to be started automatically
  services.avahi = {
    enable = true;
    hostName = "mad-fak";
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      userServices = true;
    };
  };
  programs.adb.enable = true;
  users.users."oxce5".extraGroups = ["adbusers"];
  services.udev.packages = [
    pkgs.android-udev-rules
    pkgs.platformio-core.udev
    pkgs.openocd 
  ];
}
