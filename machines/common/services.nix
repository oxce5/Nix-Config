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
      rpcSecretFile = ./aria2_rpc;
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
        "com.dec05eba.gpu_screen_recorder"
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
