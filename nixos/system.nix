{ config, pkgs, ...}:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set your time zone.
  time.timeZone = "Asia/Manila";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US";
      LC_IDENTIFICATION = "en_US";
      LC_MEASUREMENT = "en_US";
      LC_MONETARY = "en_US";
      LC_NAME = "en_US";
      LC_NUMERIC = "en_US";
      LC_PAPER = "en_US";
      LC_TELEPHONE = "en_US";
      LC_TIME = "en_US";
    };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
