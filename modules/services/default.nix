{
  unify = {
    home.services = {
      ssh-agent.enable = true;
    };
    nixos = {pkgs, ...}: {
      services = {
        dbus.implementation = "broker";
        earlyoom = {
          enable = true;
          enableNotifications = true;
          freeMemThreshold = 7;
        };
        fwupd.enable = true;
      };
    };
  };
}
