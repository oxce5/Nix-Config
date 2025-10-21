{
  unify.modules.laptop.nixos = {
    services.power-profiles-daemon.enable = false;
    hardware.system76.power-daemon.enable = true;
    services = {
      upower.enable = true;
      thermald.enable = true;
      auto-cpufreq = {
        enable = true;
        settings = {
          battery = {
            governor = "powersave";
            turbo = "never";
          };
          charger = {
            governor = "performance";
            turbo = "auto";
          };
        };
      };
    };
  };
}
