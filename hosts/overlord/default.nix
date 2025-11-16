{
  inputs,
  config,
  ...
}: {
  unify.hosts.nixos.overlord = {
    modules = with config.unify.modules; [
      workstation
      laptop
      neovim
      plymouth
      bar
      gaming
      zellij
      tuigreet
      comfy
    ];

    primaryDisplay = config.unify.hosts.nixos.overlord.displays.eDP-1;
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

    nixos = {pkgs, ...}: {
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

      networking = {
        networkmanager.enable = true;
        hostName = "overlord";
        nameservers = [
          "192.168.1.26"
          "8.8.8.8"
        ];
      };

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
  };
}
