{pkgs, ...}: {
  hardware.sane.enable = true; # enables support for SANE scanners
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      ocl-icd
    ];
  };
  hardware.cpu.intel.updateMicrocode = true; # update Intel CPU microcode

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 75;
    priority = 80;
  };
}
