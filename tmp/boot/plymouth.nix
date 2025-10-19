{pkgs, ...}:
{
  unify.modules.plymouth.nixos.boot = {
    plymouth = {
      enable = true;
      theme = "prts-plymouth";
      themePackages = let
        prts-plymouth = pkgs.callPackage ./prts-plymouth {};
      in [ prts-plymouth ];
    };
    consoleLogLevel = 3;
    initrd.verbose = false;
    initrd.systemd.enable = true;
    kernelParams = [
      "quiet"
      "splash"
      "intremap=on"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
  };
}
