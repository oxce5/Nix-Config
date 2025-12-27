{
  inputs,
  config,
  ...
}: {
  unify.hosts.nixos.overlord = {
    modules = with config.unify.modules; [
      workstation
      laptop
      development
      neovim
      plymouth
      dms
      gaming
      zellij
      tuigreet
      comfy
      virtualisation
      waydroid
      nvidia
      niri
      cachix
      stylix
      ghostty
    ];
    primaryDisplay = config.unify.hosts.nixos.overlord.displays.eDP-1;
    primaryUser = "oxce5";
    primaryWallpaper = builtins.fetchurl {
      url = "https://img2.gelbooru.com/images/1a/2b/1a2bc2154348dc38ca7a19c4e34bd914.jpg";
      sha256 = "1c6dzrl21vrd53zm68yd6rnd3nc97cbl3k03wnnsa1ssgikkr96g";
    };
    baseImage = builtins.fetchurl {
      url = "https://w.wallhaven.cc/full/21/wallhaven-2119vy.jpg";
      sha256 = "0l67mxk5hz2vx1nz7bmk5pzszmw3pafzlw5m94x8b7yp6qnc6fmk";
    };
    displays = {
      eDP-1 = {
        primary = true;
        refreshRate = 144;
        width = 1920;
        height = 1080;
      };
      HDMI-A-5 = {
        refreshRate = 60;
        width = 1920;
        height = 1080;
        x = -1920;
      };
    };

    users.oxce5.modules = config.unify.hosts.nixos.overlord.modules;

    nixos = {
      pkgs,
      config,
      ...
    }: {
      facter.reportPath = ./facter.json;
      imports = with inputs; [
        nixos-hardware.nixosModules.common-cpu-amd
        nixos-hardware.nixosModules.common-gpu-amd
        nixos-hardware.nixosModules.common-pc-ssd

        nix-flatpak.nixosModules.nix-flatpak
        stylix.nixosModules.stylix
        chaotic.nixosModules.default
      ];

      boot.kernelPackages = pkgs.linuxPackages_zen;
      boot.extraModulePackages = with config.boot.kernelPackages; [lenovo-legion-module];

      networking = {
        networkmanager.enable = true;
        hostName = "overlord";
        nameservers = [
          "192.168.1.26"
          "8.8.8.8"
        ];
      };

      nixpkgs.overlays = [
        (final: prev: {
          oldNodejs_24 = inputs.node24-old.legacyPackages.${prev.system}.nodejs_24;
        })
      ];

      environment.systemPackages = [
        (pkgs.winboat.override {
          nodejs_24 = pkgs.oldNodejs_24;
        })
      ];

      services = {
        fwupd.enable = true;

        keyd = {
          enable = true;
          keyboards = {
            default = {
              ids = ["048d:c996:20fedd66"];
              settings = {
                main = {
                  capslock = "timeout(esc, 150, capslock)";
                  esc = "esc";
                  kpasterisk = "\"";
                };
              };
            };
          };
        };
        swapspace = {
          enable = true;
          settings = {
            max_swapsize = "20g";
            min_swapsize = "1g";
          };
        };
      };
      zramSwap = {
        enable = true;
        memoryPercent = 75;
      };
    };
    home = {pkgs, ...}: {
      home.packages = [pkgs.exegol];
    };
  };
}
