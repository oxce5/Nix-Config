{
  inputs,
  config,
  ...
}: {
  unify.hosts.nixos.rei = {
    modules = with config.unify.modules; [
      bar
      hacking
      hyprland
      ssh
    ];
    # primaryDisplay = config.unify.hosts.nixos.rei.displays.eDP-1;
    primaryUser = "adachi";
    primaryWallpaper = builtins.fetchurl {
      url = "https://w.wallhaven.cc/full/21/wallhaven-2119vy.jpg";
      sha256 = "0l67mxk5hz2vx1nz7bmk5pzszmw3pafzlw5m94x8b7yp6qnc6fmk";
    };
    baseImage = builtins.fetchurl {
      url = "https://w.wallhaven.cc/full/21/wallhaven-2119vy.jpg";
      sha256 = "0l67mxk5hz2vx1nz7bmk5pzszmw3pafzlw5m94x8b7yp6qnc6fmk";
    };

    users.adachi.modules = config.unify.hosts.nixos.rei.modules;

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
        hostName = "rei";
      };
    };
  };
}
