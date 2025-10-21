{lib, ...}: {
  unify = {
    modules.virtualisation.nixos = {
      pkgs,
      hostConfig,
      ...
    }: {
      boot.kernelParams = ["kvm-intel" "ip_tables" "iptable_nat"];
      users.users.${hostConfig.primaryUser}.extraGroups = ["kvm" "libvirtd" "qemu"];
      programs.virt-manager.enable = true;
      environment.systemPackages = with pkgs; [
        virglrenderer
      ];
      services.qemuGuest.enable = true;
      virtualisation = {
        libvirtd.enable = true;
      };
    };
    modules.waydroid.nixos = {
      virtualisation.waydroid.enable = true;
    };
  };
}
