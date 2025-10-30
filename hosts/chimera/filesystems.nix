{
  unify.hosts.nixos.chimera = {
    nixos = {lib, ...}: {
      fileSystems."/" = {
        device = "/dev/disk/by-uuid/3db44b5e-34f1-44f2-bfaa-8d044af0e43e";
        fsType = "ext4";
      };
      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/3552-0F2A";
        fsType = "vfat";
        options = ["fmask=0077" "dmask=0077"];
      };
    };
  };
}
