{ config, lib, pkgs, ... }:

{
  #Enable OpenGL
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ 
      ocl-icd
      nvidia-vaapi-driver
    ];
  };


  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  hardware.nvidia.prime = {
		offload = {
			enable = true;
			enableOffloadCmd = true;
		};
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
  };
}
