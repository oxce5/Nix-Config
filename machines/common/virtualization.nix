{pkgs, ...}:

{
  virtualisation = {
    waydroid = {
      enable = true;
      package = pkgs.unstable.waydroid;
    };
    libvirtd.enable = true;
  };

  environment.systemPackages = [ pkgs.unstable.waydroid-helper ];
  programs.virt-manager.enable = true;
}

