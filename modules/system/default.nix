{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: 
let
  quickshell = inputs.quickshell.packages.${pkgs.system}.default;
in
{
  imports = [
    # ./example.nix - add your modules here
    inputs.nix-flatpak.nixosModules.nix-flatpak
    inputs.sops-nix.nixosModules.sops
    inputs.hydenix.inputs.nixos-hardware.nixosModules.common-gpu-nvidia

    ./aagl.nix
  ];

  environment.systemPackages = with pkgs; [
    inputs.jerry.packages.${pkgs.system}.default
    (obs-studio.override {
      cudaSupport = true;
    })
    (import ./quickshell.nix {
      inherit symlinkJoin makeWrapper quickshell kdePackages lib;
    })
    atuin
    aria2
    nvidia-vaapi-driver
    sbctl
    xsane
    waydroid-helper
    cloudflare-warp
    ouch
    p7zip
    ffmpeg-full
    wineWowPackages.stable
    alejandra
    bat
    nix-ld
    nextdns

    python313Packages.aria2p
    # pkgs.vscode - hydenix's vscode version
    # pkgs.userPkgs.vscode - your personal nixpkgs version
  ];
  
  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/oxce5/.config/sops/age/keys.txt";
    secrets."aria2_rpc" = { };
  };

  specialisation = {
    battery-saver.configuration = {
      system.nixos.tags = ["battery-saver"];
      hardware = {
        nvidia = {
          prime.offload.enable = lib.mkForce false;
          prime.offload.enableOffloadCmd = lib.mkForce false;
          powerManagement.finegrained = lib.mkForce false;
        };
      };
    };
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
    open = false;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
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
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      package = pkgs.steam.override {
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
    };
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
      openPorts = true;
      rpcSecretFile = config.sops.secrets."aria2_rpc".path;
      settings = {
        enable-rpc = true;
      };
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
  };
  systemd.services.flatpak-repo = {
    wantedBy = ["multi-user.target"];
    path = [pkgs.flatpak];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
  systemd.services.nextdns-activate = {
    script = ''
      /run/current-system/sw/bin/nextdns activate
    '';
    after = [ "nextdns.service" ];
    wantedBy = [ "multi-user.target" ];
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
    memoryPercent = 50;
    priority = 80;
  };
  swapDevices = [{
    device = "/swapfile";
    size = 10*1024;
    priority = 30;
    }];
  nix.settings = {
    substituters = [
      "https://ezkea.cachix.org"
    ];
    trusted-public-keys = [
      "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
    ];
  };
}
