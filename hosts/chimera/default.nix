{
  inputs,
  config,
  ...
}: {
  unify.hosts.nixos.chimera = {
    modules = with config.unify.modules; [
      workstation
      server
      neovim
      zellij
      tuigreet
    ];

    primaryDisplay = config.unify.hosts.nixos.chimera.displays.eDP-1;
    displays = {};

    users.teto.modules = config.unify.hosts.nixos.chimera.modules;

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

      chaotic.nyx.cache.enable = true;

      boot.kernelPackages = pkgs.linuxPackages_6_17;

      networking = {
        networkmanager.enable = true;
        hostName = "chimera";
      };

      services = {
        fwupd.enable = true;

      };
    };
  };
}
