{
  pkgs,
  config,
  ...
}: {
  services = {
    thermald.enable = true;
    auto-cpufreq.enable = true;
    auto-cpufreq.settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
    tlp = {
      enable = true;
      settings.CPU_MAX_PERF_ON_BAT = 50;
      settings.CPU_MAX_PERF_ON_AC = 100;
    };
    undervolt = {
      enable = true;
      coreOffset = -125;
    };
    earlyoom = {
      enable = true;
      enableNotifications = true;
      freeMemThreshold = 7;
    };

    deluge = {
      enable = true;
      web.enable = true;
      user = "oxce5";
    };

    aria2 = {
      enable = true;
      rpcSecretFile = config.sops.secrets.aria2_rpc.path;
      settings = import ./config/aria2.nix;
    };

    flatpak = {
      enable = true;
      packages = [
        "com.github.tchx84.Flatseal"
        "com.usebottles.bottles"
        "io.mrarm.mcpelauncher"
        "org.vinegarhq.Vinegar"
        "org.vinegarhq.Sober"
      ];
    };
    cron = {
      enable = true;
      systemCronJobs = [
        "*/20 * * * * /home/0xce5/hydenix/scripts/weather.sh /tmp/hyprlock-weather.txt >/dev/null 2>&1"
      ];
    };
    nextdns = {
      enable = true;
      arguments = [
        "-config"
        "9a438c"
        "-cache-size"
        "10MB"
      ];
    };
    fwupd.enable = true;
  };
  systemd = {
    services.flatpak-repo = {
      wantedBy = ["multi-user.target"];
      path = [pkgs.flatpak];
      script = ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
    };
    services.nextdns-activate = {
      script = ''
        /run/current-system/sw/bin/nextdns activate
      '';
      after = ["nextdns.service"];
      wantedBy = ["multi-user.target"];
    };
  };
}
