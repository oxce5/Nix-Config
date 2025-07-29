{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: 
let
  quickshell = inputs.quickshell.packages.${pkgs.system}.default;
  unstable = inputs.nixpkgs.legacyPackages.${pkgs.system};
in
{
  imports = [
    # ./example.nix - add your modules here
    inputs.nix-flatpak.nixosModules.nix-flatpak
    inputs.sops-nix.nixosModules.sops

    ./aagl.nix
    ./nvidia.nix
  ];

  environment.systemPackages = with pkgs; [
    inputs.jerry.packages.${pkgs.system}.default
    (obs-studio.override {
      cudaSupport = true;
    })
    (import ./kurukurubar.nix {
      inherit symlinkJoin makeWrapper quickshell kdePackages lib;
      makeFontsConf = pkgs.makeFontsConf;
      nerd-fonts = pkgs.nerd-fonts.caskaydia-mono;
      material-symbols = pkgs.material-symbols;
    })
    atuin
    nvidia-vaapi-driver
    sbctl
    xsane
    waydroid-helper
    cloudflare-warp
    ouch
    p7zip
    ffmpeg-full
    python314Full
    uv
    inputs.nix-gaming.packages.${pkgs.system}.wine-tkg-ntsync
    unstable.winetricks
    unstable.protontricks
    ripgrep
    alejandra
    timeshift
    bat
    nix-ld
    nextdns
    lenovo-legion

    unstable.python313Packages.aria2p
    # pkgs.vscode - hydenix's vscode version
    # pkgs.userPkgs.vscode - your personal nixpkgs version
  ];

  environment = {
    localBinInPath = true;
  };
  
  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/oxce5/.config/sops/age/keys.txt";
    secrets."aria2_rpc" = { };
  };

  hardware.sane.enable = true; # enables support for SANE scanners
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      ocl-icd
    ];
  };
  hardware.nvidia = {
    primeBatterySaverSpecialisation = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.cpu.intel.updateMicrocode = true; # update Intel CPU microcode

  programs = {
    steam.enable = true;
    # Fixes using gamescope in steam
    steam.package = pkgs.steam.override {
      extraPkgs = pkgs:
        with pkgs; [
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
        ];
    };

    gamescope.enable = true;
    gamescope.capSysNice = false; # Breaks gamescope in steam

    adb.enable = true;
    nix-ld = {
      enable = true;
      libraries = pkgs.steam-run.args.multiPkgs pkgs;
    }; 
    gamemode.enable = true;
  };

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
      settings.CPU_MAX_PERF_ON_BAT = 30;
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
        "-config" "9a438c"
        "-cache-size" "10MB"
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
      after = [ "nextdns.service" ];
      wantedBy = [ "multi-user.target" ];
    };
  };

  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
    waydroid.enable = true;
  };

  networking = {
    firewall = {
      enable = true;
      allowedUDPPorts = [];
    };
  };

  systemd.packages = [pkgs.cloudflare-warp]; # for warp-cli
  systemd.targets.multi-user.wants = ["warp-svc.service"]; # causes warp-svc to be started automatically
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 75;
    priority = 80;
  };

  nix.settings.accept-flake-config = true;
}
