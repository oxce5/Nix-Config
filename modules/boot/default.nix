{
  unify.nixos = {lib, ...}: {
    boot = {
      initrd.systemd.enable = true;
      loader = {
        grub = {
          enable = lib.mkForce false;
          devices = ["/dev/disk/by-uuid/1A3A-626E"];
        };
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
        timeout = 3;
      };
      kernel.sysctl = {
        "transparent_hugepage" = "always";
        "vm.nr_hugepages_defrag" = 0;
        "ipcs_shm" = 1;
        "default_hugepagez" = "1G";
        "hugepagesz" = "1G";
        "vm.swappiness" = 1;
        "vm.compact_memory" = 0;
      };
      supportedFilesystems = ["ntfs"]; # Adds NTFS driver
    };
  };
}
