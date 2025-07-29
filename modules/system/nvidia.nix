{
  config,
  lib,
  inputs,
  ...
}:

let
  nvidiaPackage = config.hardware.nvidia.package;
in {
  import = [
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia
  ];

  hardware.nvidia = {
    open = lib.mkOverride 990 (nvidiaPackage ? open && nvidiaPackage ? firmware);
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
}
