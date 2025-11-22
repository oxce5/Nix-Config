{
  unify.modules.nvidia.nixos = {
    config,
    pkgs,
    ...
  }: {
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
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        libva
        intel-media-driver
        nvidia-vaapi-driver
      ];
    };
  };
  unify.modules.comfy.nixos = {
    hardware.nvidia-container-toolkit.enable = true;
  };
}
