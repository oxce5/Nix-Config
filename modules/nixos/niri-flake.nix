{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports = [inputs.niri-flake.nixosModules.niri];

  nixpkgs.overlays = [inputs.niri-flake.overlays.niri];
  programs.niri = {
    enable = true;
  };
  niri-flake.cache.enable = true;

  # systemd.user.services = {
  #   xdg-desktop-portal = {
  #     after = [ "xdg-desktop-autostart.target" ];
  #   };
  #   xdg-desktop-portal-gtk = {
  #     after = [ "xdg-desktop-autostart.target" ];
  #   };
  #   xdg-desktop-portal-gnome = {
  #     after = [ "xdg-desktop-autostart.target" ];
  #   };
  #   niri-flake-polkit = {
  #     after = [ "xdg-desktop-autostart.target" ];
  #   };
  # };
}
