{
  unify.modules.workstation.nixos =
  { config, ... }:
  {
    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      open = false;
      nvidiaSettings = true;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
      package = config.boot.kernelPackages.nvidiaPackages.production;
    };
    services.xserver.videoDrivers = ["nvidia"];
  };
}
