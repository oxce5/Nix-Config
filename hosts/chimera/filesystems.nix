{
  unify.hosts.nixos.chimera = {
    nixos = {lib, ...}: {
      fileSystems."/" = {
        device = "/dev/disk/nvme-SK_hynix_BC501_HFM128GDJTNG-8310A_NI94M00031310460X";
        fsType = "ext4";
      };
      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/1A3A-626E";
        fsType = "vfat";
        options = ["fmask=0077" "dmask=0077"];
      };
    };
  };
}
