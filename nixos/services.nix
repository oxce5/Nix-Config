{ pkgs, ...}:

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
  services.udev.extraRules = ''
    ACTION=="change", SUBSYSTEM=="power_supply", KERNEL=="ACAD", ENV{POWER_SUPPLY_ONLINE}=="1", RUN+="${pkgs.systemd}/bin/systemctl start --no-block dynamic-rr@144.service"
    ACTION=="change", SUBSYSTEM=="power_supply", KERNEL=="ACAD", ENV{POWER_SUPPLY_ONLINE}=="0", RUN+="${pkgs.systemd}/bin/systemctl start --no-block dynamic-rr@60.service"
  '';
  services.gvfs.enable = true;

  systemd.services."dynamic-rr@" = {
    description = "Change refresh rate dynamically";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/home/oxce5/nix-config/assets/dynamic_rr.sh %i";
    };
  };
  services.cloudflared = {
    enable = true;
    user = "cloudflared";
    tunnels = {
      "capstone-mad-fak" = {
        default = "http://localhost:80";  # Make sure this is the correct entry point
        credentialsFile = "/var/lib/cloudflared/capstone-mad-fak.json";
        ingress = {
          "mad-fak.space" = "http://localhost:80";  # Main site
          default = "http_status:404";  # Default rule for unmatched requests
        };
      };
    };
  };
  services.udisks2.enable = true;

  services.upower.enable = true;
  services.thermald.enable = true;
}
