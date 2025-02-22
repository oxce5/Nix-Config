{ config, pkgs, ...}:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Set your time zone.
  time.timeZone = "Asia/Manila";

  # Select internationalisation properties.

  # Select internationalisation properties.
  i18n.defaultLocale = "en_PH.UTF-8";
  # i18n.supportedLocales = [
  #   "en_PH.UTF-8/UTF-8"
  #   "fil_PH.UTF-8/UTF-8"
  # ];
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fil_PH";
    LC_IDENTIFICATION = "fil_PH";
    LC_MEASUREMENT = "fil_PH";
    LC_MONETARY = "fil_PH";
    LC_NAME = "fil_PH";
    LC_NUMERIC = "fil_PH";
    LC_PAPER = "fil_PH";
    LC_TELEPHONE = "fil_PH";
    LC_TIME = "en_PH.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  environment.variables = {
    OCL_ICD_VENDORS="/run/opengl-driver/etc/OpenCL/vendors";
  };

  nix.settings = {
    substituters = [ "https://ezkea.cachix.org" ];
    trusted-public-keys = [ "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI=" ];
  };
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
}

