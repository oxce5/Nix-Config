{
  unify.hosts.nixos.overlord = {
    nixos = {lib, ...}: {
      fileSystems."/" = {
        device = "/dev/disk/by-label/ROOT";
        fsType = "ext4";
      };
      fileSystems."/boot" = {
        device = "/dev/disk/by-label/NIXBOOT";
        fsType = "vfat";
        options = ["fmask=0077" "dmask=0077"];
      };
    };
  };
}
