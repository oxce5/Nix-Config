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
      url = "https://i.postimg.cc/pLgRKzPs/Gk-Y6b-Xao-AAX5Il.jpg";
      sha256 = "0b12ancxqsvknz9126prh8ivibinawr5kh7cr4xhfap3nc2xljkk";
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
          oldnodejs_24 = inputs.node24-old.legacyPackages.${prev.system}.nodejs_24;
        })
        inputs.blender-bin.overlays.default
      ];

      environment.systemPackages = [
        (pkgs.winboat.override {
          nodejs_24 = pkgs.oldnodejs_24;
        })
      ];

      services = {
        fwupd.enable = true;

        keyd = {
          enable = true;
          keyboards = {
            default = {
              ids = ["*"];
              settings = {
                main = {
                  esc = "esc";
                  capslock = "timeout(esc, 150, capslock)";
                  kpasterisk = "'";
                  kpplus = "g";
                  kpminus = "h";
                };
              };
            };
            external = {
              ids = ["048d:c996:20fedd66"];
              settings = {
                main = {
                  esc = "esc";
                  capslock = "timeout(esc, 150, capslock)";
                };
              };
            };
          };
        };
        swapspace = {
          enable = true;
          settings = {
            max_swapsize = "5g";
            min_swapsize = "1g";
          };
        };
        # sunshine = {
        #   enable = true;
        #   capSysAdmin = true;
        # };
      };
      zramSwap = {
        enable = true;
        memoryPercent = 75;
      };

      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
          General = {
            # Shows battery charge of connected devices on supported
            # Bluetooth adapters. Defaults to 'false'.
            Experimental = true;
            # When enabled other devices can connect faster to us, however
            # the tradeoff is increased power consumption. Defaults to
            # 'false'.
            FastConnectable = true;
          };
          Policy = {
            # Enable all controllers when they are found. This includes
            # adapters present on start as well as adapters that are plugged
            # in later on. Defaults to 'true'.
            AutoEnable = true;
          };
        };
      };
    };
    home = {pkgs, ...}: {
      home.sessionVariables = {
        TZ = "Asia/Manila";
      };
      services = {
        wayvnc = {
          enable = true;
          settings = {
            address = "0.0.0.0";
            port = 5901;
          };
        };
      };
    };
  };
}
