{
  inputs,
  config,
  ...
}: {
  unify.hosts.nixos.chimera = {
    modules = with config.unify.modules; [
      server
      proxy
      nextcloud
      pihole
      anime
      downloader
      ssh
      sso
      sillytavern
      monitoring
      termix
      crafty
      zellij
    ];

    primaryUser = "teto";
    users = {
      teto.modules = config.unify.hosts.nixos.chimera.modules;
      # sillytavern.modules = [config.unify.modules.sillytavern];
    };
    nixos = {
      lib,
      pkgs,
      ...
    }: {
      facter.reportPath = ./facter.json;
      imports = with inputs; [
        nixos-hardware.nixosModules.common-cpu-amd
        nixos-hardware.nixosModules.common-cpu-intel
        nixos-hardware.nixosModules.common-gpu-amd
        nixos-hardware.nixosModules.common-pc-ssd
        nixos-hardware.nixosModules.common-pc-hdd

        nix-flatpak.nixosModules.nix-flatpak
        stylix.nixosModules.stylix
        chaotic.nixosModules.default
      ];

      chaotic.nyx.cache.enable = true;

      boot.kernelPackages = pkgs.linuxPackages_6_17;

      networking = {
        networkmanager.enable = true;
        hostName = "chimera";
        firewall.allowedTCPPorts = [80];
      };

      services = {
        fwupd.enable = true;
      };
      programs = {
        dconf.enable = lib.mkForce false;
      };
    };
  };
}
