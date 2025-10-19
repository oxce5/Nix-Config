{ inputs, config, ... }:
{
  unify.hosts.nixos.overlord = {
    modules = with config.unify.modules; [
      workstation
      laptop
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

    nixos =
      { pkgs, ... }:
      {
        facter.reportPath = ./facter.json;
        imports = with inputs.nixos-hardware.nixosModules; [
          common-cpu-amd
          common-gpu-amd
          common-pc-ssd
        ];

        boot.kernelPackages = inputs.chaotic.legacyPackages.${pkgs.system}.linuxPackages_cachyos;

        networking = {
          networkmanager.enable = false;
          hostName = "overlord";
        };

        services = {
          fwupd.enable = true;
        };
      };
  };
}
