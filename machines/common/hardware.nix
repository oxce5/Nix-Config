{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  hardware.sane.enable = true; # enables support for SANE scanners
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      ocl-icd
    ];
  };
  hardware.enableRedistributableFirmware = true; # update Intel CPU microcode
  hardware.cpu.intel.updateMicrocode = true; # update Intel CPU microcode

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 75;
    priority = 100;
  };

  services.swapspace = {
    enable = true;
    settings = {
      min_swapsize = "1m";
      max_swapsize = "10g";
    };
  };
}
