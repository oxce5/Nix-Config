{
  config,
  lib,
  inputs,
  ...
}: let
  nvidiaPackage = config.hardware.nvidia.package;
in {
  imports = [
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia
  ];

  hardware.nvidia = {
    open = lib.mkOverride 990 (nvidiaPackage ? open && nvidiaPackage ? firmware);
    primeBatterySaverSpecialisation = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    prime = {
      offload = {
        enable = lib.mkOverride 990 true;
        enableOffloadCmd = lib.mkIf config.hardware.nvidia.prime.offload.enable true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
  services.xserver.videoDrivers = ["nvidia"];

  specialisation = lib.mkIf config.hardware.nvidia.primeBatterySaverSpecialisation {
    battery-saver.configuration = {
      hardware.nvidia.prime.offload.enableOffloadCmd = lib.mkForce false;
    };
  };
}
