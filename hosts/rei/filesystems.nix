{
  unify.hosts.nixos.rei = {
    nixos = {lib, ...}: {
      fileSystems."/" = {
        device = "/dev/disk/by-uuid/36fda643-446f-4e7f-ab5b-99c40e92e797";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/3433-EF13";
        fsType = "vfat";
        options = ["fmask=0077" "dmask=0077"];
      };
    };
  };
}
