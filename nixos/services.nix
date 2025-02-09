{ config, lib, pkgs, ... }:

{
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "gtk";
  services.flatpak.enable = true;
}
