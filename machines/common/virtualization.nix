{pkgs, ...}: {
  virtualisation = {
    waydroid = {
      enable = true;
      package = pkgs.waydroid;
    };
    libvirtd.enable = true;
  };

  environment.systemPackages = [pkgs.waydroid-helper];
  programs.virt-manager.enable = true;
}
